import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:random_string/random_string.dart';

class Location {
  String docID = randomAlphaNumeric(20);
  String name = '';
  String country = '';
  String address = '';
  int zipCode = 0;
  bool isDefault = false;
  int numOfCategories = 0;
  int numOfProducts = 0;
  double totalValue  = 0;

   Location.empty();

  Location(
      {@required this.docID,
      @required this.name,
      @required this.country,
      @required this.address,
      @required this.zipCode,
      @required this.isDefault,
      this.numOfCategories,
      this.numOfProducts,
      this.totalValue});

  // Serialize Class to JSON (Key,Value) for writing to Database
  Map<String, dynamic> toFireStore() => {
        'DocumentID': docID,
        'Name': name,
        'Country': country,
        'Address': address,
        'ZipCode': zipCode,
        'isDefault': isDefault,
        'NumberOfCategories': numOfCategories,
        'NumberOfProducts': numOfProducts,
        'TotalValue': totalValue,
      };

  // Deserialize JSON (Key,Value) to Class for reading from Database
  factory Location.fromFireStore(DocumentSnapshot documentSnapshot) {
    Map documentData = documentSnapshot.data;
    return Location(
        docID: documentSnapshot.documentID,
        name: documentData['Name'] ?? null,
        country: documentData['Country'] ?? null,
        address: documentData['Address'] ?? null,
        zipCode: documentData['ZipCode'] ?? null,
        isDefault: documentData['isDefault'] ?? null,
        numOfCategories: documentData['NumberOfCategories'] ?? null,
        numOfProducts: documentData['NumberOfProducts'] ?? null,
        totalValue: documentData['TotalValue'] ?? null);
  }

  static Location findByName(List<Location> list, String itemName) {
    return list.firstWhere((item) => item.name == itemName);
  }

  static List<Location> initStreamData() {
    // Create Empty List with 1 Object for initialization
    List<Location> initList = <Location>[];
    initList.add(Location.empty());
    return initList;
  }

  // Deserialize JSON (Key,Value) to Class for reading from Database
  factory Location.fromOrder(Map<String,dynamic> documentData) {

    return Location(
        docID: documentData['DocumentID'] ?? null,
        name: documentData['Name'] ?? null,
        country: documentData['Country'] ?? null,
        address: documentData['Address'] ?? null,
        zipCode: documentData['ZipCode'] ?? null,
        isDefault: documentData['isDefault'] ?? null,
        numOfCategories: documentData['NumberOfCategories'] ?? null,
        numOfProducts: documentData['NumberOfProducts'] ?? null,
        totalValue: documentData['TotalValue'] ?? null);
  }


}
