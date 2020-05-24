import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:iwas_port/Models/wine.dart';
import 'package:random_string/random_string.dart';

class Location {
  String docID = randomAlphaNumeric(20);
  String name ;
  String address;
  bool isDefault;
  int numOfCategories;
  List<Wine> productList = [];
  double totalValue;

  Location.empty();

  Location(
      {@required this.docID,
      @required this.name,
      @required this.address,
      @required this.isDefault,
      this.numOfCategories,
      this.productList,
      this.totalValue});

  // Serialize Class to JSON (Key,Value) for writing to Database
  Map<String, dynamic> toFireStore() => {
        'DocumentID': docID,
        'Name': name,
        'Address': address,
        'isDefault': isDefault,
        'NumberOfCategories': numOfCategories,
        'ProductList': productList.map((product) => product.toFireStore()).toList(),
        'TotalValue': totalValue,
      };

  // Deserialize JSON (Key,Value) to Class for reading from Database
  factory Location.fromFireStore(DocumentSnapshot documentSnapshot) {
    Map documentData = documentSnapshot.data;

    var list = documentData['ProductList'] as List;
    List<Wine> productList =
    list.map((item) => Wine.fromFireStore(item)).toList();

    return Location(
        docID: documentSnapshot.documentID,
        name: documentData['Name'] ?? null,
        address: documentData['Address'] ?? null,
        isDefault: documentData['isDefault'] ?? null,
        numOfCategories: documentData['NumberOfCategories'] ?? null,
        productList: productList ?? null,
        totalValue: documentData['TotalValue'] ?? null);
  }

  static Location findByName(List<Location> list, String itemName) {
    return list.firstWhere((item) => item.name == itemName);
  }

  static List<Location> initStreamData() {
    // Create Empty List with 1 Object for initialization
    List<Location> initList = <Location>[];
    //initList.add(Location.empty());
    return initList;
  }

  // Deserialize JSON (Key,Value) to Class for reading from Database
  factory Location.fromOrder(Map<String,dynamic> documentData) {

    var list = documentData['ProductList'] as List;
    List<Wine> productList =
    list.map((item) => Wine.fromFireStore(item)).toList();

    return Location(
        docID: documentData['DocumentID'] ?? null,
        name: documentData['Name'] ?? null,
        address: documentData['Address'] ?? null,
        isDefault: documentData['isDefault'] ?? null,
        numOfCategories: documentData['NumberOfCategories'] ?? null,
        productList: productList ?? null,
        totalValue: documentData['TotalValue'] ?? null);
  }


}
