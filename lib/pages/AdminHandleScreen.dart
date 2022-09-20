import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/drug.dart';
import '../widgets/drug_card.dart';
import 'drug_detail_view.dart';

class AdminHandleScreen extends StatefulWidget {
  const AdminHandleScreen({Key? key}) : super(key: key);

  @override
  State<AdminHandleScreen> createState() => _AdminHandleScreenState();
}

class _AdminHandleScreenState extends State<AdminHandleScreen> {

   Stream _getDrugs() {
    return FirebaseFirestore.instance.collection("drugs").snapshots();
  }

  Widget _displayListOfDrugs(dynamic drugs) {

    return ListView.builder(
      itemCount:drugs.docs.length,
      itemBuilder: (context, index) {
        Drug drug = Drug.fromMap(drugs.docs[index]);
        print("image url: " + drug.url!);
        return GestureDetector(
          child: ItemCard(drug: drug),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => 
            DrugDetailView(drug: drug, admin: true, drugId: drugs.docs[index].id,
)));
          },
          );
      },
    );
  }

  // _viewCatalogue() {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 12.0),
  //     child: StreamBuilder(
  //       stream: _getDrugs(),
  //       builder: (context, AsyncSnapshot snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           // items are still loading
  //           return const Center(child: CircularProgressIndicator(),);
  //         } else if (snapshot.hasData) {
  //           // items are ready
  //           return _displayListOfDrugs(snapshot.data);
  //         } else {
  //           return const Center(
  //             child: Text("An error while fetching data..."),
  //             // do any further thing...
  //           );
  //         }
  //       },
  //     ),
  //   );
  // }

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
      appBar: AppBar(title:const Text("Welcome, Admin")),
      body: _buildDrugsList(),
    );
  }
}


