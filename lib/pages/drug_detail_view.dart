import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../model/drug.dart';

class DrugDetailView extends StatefulWidget {
  final Drug drug;
  final bool admin;
  final String drugId;
  const DrugDetailView(
      {Key? key, required this.drug, required this.admin, required this.drugId})
      : super(key: key);

  @override
  _DrugDetailViewState createState() => _DrugDetailViewState();
}

class _DrugDetailViewState extends State<DrugDetailView> {
  late Drug drug;

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  
  String imageUploadedUrl = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    drug = widget.drug;
  }

  void _handlePurchase() {
    return;
  }

  Widget _changeDrugName() {
    return TextField(
      controller: _nameController,
      decoration: const InputDecoration(
        labelText: "Drug Name",
        border: OutlineInputBorder()
      ),
    );
  }

  _changeDescription() {
    return TextField(
      controller: _descriptionController,
      decoration: const InputDecoration(
        labelText: "Description",
        border: OutlineInputBorder()
      ),
    );
  }

  _changePrice() {
    return TextField(
      controller: _priceController,
      decoration: const InputDecoration(
        labelText: "Price",
        border: OutlineInputBorder()
      ),
    );
  }

  _changeImage() {
    // upload image from gallery --- find package
    // save uploaded image to firebase storage
    // get url of saved image
    // return url
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Column(
        children: [
          Center(
            child: ElevatedButton(
              child: const Text('Update Image'),
              onPressed: () async {
                final results = await FilePicker.platform.pickFiles(
                    allowMultiple: false,
                    type: FileType.custom,
                    allowedExtensions: ['png', 'jpg']);
                if (results == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No file seleted.'),
                    ),
                  );
                }
                final path = results!.files.single.path;
                final fileName = results.files.single.name;

                print(path);
                print(fileName);
                if (path != null && path.isNotEmpty) {
                  imageUploadedUrl = await _storageUpload(path, fileName);
                  if (imageUploadedUrl.isEmpty) {
                    print("something went wrong. no download url");
                    return;
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Image url obtained.'),
                    ),
                  );
                  }
                } else {
                  print("couldn't upload image. no file");
                } 
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<String> _storageUpload(String path, String fileName) async {
    final storageRef = FirebaseStorage.instance.ref();
    final imagesRef = storageRef.child("images/$fileName");

    File file = File(path);

    try {
      await imagesRef.putFile(file).whenComplete(() {
        print("upload done");
      });
      return await imagesRef.getDownloadURL();
    } on FirebaseException catch (e) {
      // todo: remove later
      print(e.message);
    }
    // if you get here image retrieval failed.
    return "";
  }

  _saveToStore() {
    drug = Drug(
      name: _nameController.text.isEmpty ? drug.name : _nameController.text,
      description: _descriptionController.text.isEmpty ? drug.description : _descriptionController.text,
      price: _priceController.text.isEmpty ? drug.price : double.parse(_priceController.text),
      url: imageUploadedUrl.isEmpty ? drug.url : imageUploadedUrl, // original
    );

    final data = drug.toMap();
    FirebaseFirestore.instance
        .collection("drugs")
        .doc(widget.drugId)
        .update(data)
        .then((value) => {
          print("data saved successfully")
          })
        .onError((error, stackTrace) => {print(error)})
        .whenComplete(() {
          Navigator.pop(context);
        });
  }

  @override
  Widget build(BuildContext context) {
    String defaultImage = "assets/image/bg.jpg";

    return Scaffold(
      appBar: AppBar(title: Text(widget.drug.name), actions: [
        IconButton(
          icon: const Icon(Icons.shop_2),
          onPressed: _handlePurchase,
        )
      ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Image.network(
                widget.drug.url != null ? widget.drug.url! : defaultImage,
                height: 300.0,
              ),
              const SizedBox(
                width: 20.0,
              ),
              widget.admin ? _changeDrugName() : Text(widget.drug.name),
              const SizedBox(height: 5),
              widget.admin
                  ? _changeDescription()
                  : Text(
                      widget.drug.description!,
                    ),
              const SizedBox(height: 5),
              widget.admin
                  ? _changePrice()
                  : Text(widget.drug.price.toString()),
               const SizedBox(height: 5),
              widget.admin
                  ? _changeImage() : Container(),
              const SizedBox(
                height: 20,
              ),
              Container(
                  width: 200,
                  child: ElevatedButton(
                      onPressed: widget.admin ? _saveToStore : _handlePurchase,
                      child: Text(widget.admin ? "UPDATE" : "BUY"))),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.shop),
      //       label: "buy"
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.shop),
      //       label: ''
      //     ),
      //   ],
      // ),
    );
  }
}
