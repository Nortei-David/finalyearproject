// import 'package:flutter/material.dart';

class Drug {
  String name;
  String? description;
  String? url;
  double price;

  Drug({this.name = "", this.description, this.url, this.price = 0.0});

  //recieving data from server
  factory Drug.fromMap(map) {
    return Drug(
        name: map['drug_name'],
        description: map['drug_description'],
        url: map['drug_image_url'],
        price: map['drug_price']);
  }

  get image => null;

  //sending data to server
  Map<String, dynamic> toMap() {
    return {
      'drug_name': name,
      'drug_description': description,
      'drug_image_url': url,
      'drug_price': price
    };
  }
}
