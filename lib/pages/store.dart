import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:finalyearproject/model/drug.dart';
import 'package:finalyearproject/pages/drug_detail_view.dart';
import 'package:finalyearproject/widgets/drug_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:finalyearproject/pages/dashboard.dart';

class Store extends StatefulWidget {
  const Store({Key? key}) : super(key: key);

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  Stream _getDrugs() {
    return FirebaseFirestore.instance.collection("drugs").snapshots();
  }

  Widget _displayListOfDrugs(dynamic drugs) {
    // List<Drug> drugsList = drugs.document.map((item) {
    //   Drug.fromMap(item);
    // }).toList();

    return GridView.builder(
      itemCount: drugs.docs.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        Drug drug = Drug.fromMap(drugs.docs[index]);
        return GestureDetector(
          child: ItemCard(drug: drug) , // DrugCard(drug: drug),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DrugDetailView(
                          drug: drug,
                          admin: false,
                          drugId: drugs.docs[index].id,
                        )));
          },
        );
      },
    );
  }

  Widget _buildDrugsList() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: StreamBuilder(
        stream: _getDrugs(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            print("docs size: ${snapshot.data.docs.length}");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            // items are still loading
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            // items are ready
            return _displayListOfDrugs(snapshot.data);
          } else {
            return const Center(
              child: Text("An error while fetching data..."),
              // do any further thing...
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Store", style: TextStyle(color: Colors.blueGrey[700], fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(onPressed: () {
                      Get.to(const DashBoard());}, icon: const Icon(Icons.arrow_back, color: Colors.blueGrey,)),
        actions: [
          IconButton(
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
            },
            icon: Icon(Icons.picture_in_picture, color: Colors.blueGrey,),
            tooltip: "Upload image of prescription",
            
            
          )
        ],
      ),
      body: _buildDrugsList(),
    );
  }
}
