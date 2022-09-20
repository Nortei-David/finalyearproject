import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyearproject/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:finalyearproject/widgets/health_facts.dart';
import 'package:finalyearproject/pages/store.dart';
import 'package:finalyearproject/pages/map.dart';
import 'package:get/get.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
      .collection("users")
      .doc(user!.uid)
      .get()
      .then((value) {
        this.loggedInUser = UserModel.fromMap(value.data());
        setState(() {
          
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const Center(
            heightFactor: 3.0,
            child: Text(
              'PharmaTech',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 38.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Center(
            heightFactor: 1.0,
            child: Text(
              'Health Facts',
              style: TextStyle(
                color: Color.fromARGB(255, 72, 109, 131),
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const HealthFacts(),
          const SizedBox(height: 30.0),
          Center(
            child: Padding(padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Welcome Back',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                ),
                SizedBox(height: 10.0),
                Text('${loggedInUser.firstName} ${loggedInUser.secondName}', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500,),),
                SizedBox(height: 10.0),
                Text('${loggedInUser.email}', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500,),)
              ],
            ),
            ),
          ),
          SizedBox(height: 30.0),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 130,
                  height: 160,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        elevation: 1,
                        backgroundColor: Colors.blueGrey,
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    onPressed: () {
                      Get.to(const MapScreen());
                    },
                    child: const Text(
                      "Pharmacies Around Me",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
                Container(
                  width: 130,
                  height: 160,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        side: const BorderSide(color: Colors.blueGrey),
                        elevation: 1,
                        backgroundColor: Colors.white,
                        primary: Colors.blueGrey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    onPressed: () {
                      Get.to(const Store());
                    },
                    child: const Text(
                      "Move to Store",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
