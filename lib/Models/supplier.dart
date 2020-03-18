import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:random_string/random_string.dart';

class Supplier {
  String docID = randomAlphaNumeric(20);
  String name = '';
  String country = '';
  String address = '';
  int zipCode = 0;
  String phoneNumber = '';
  String email = '';
  String taxNumber = '';
  bool isDefault = false;


  Supplier.empty();

  Supplier({
    @required this.docID,
    @required this.name,
    this.country,
    this.address,
    this.zipCode,
    this.email,
    this.phoneNumber,
    this.taxNumber,
    this.isDefault,
  });

  // Serialize Class to JSON (Key,Value) for writing to Database
  Map<String, dynamic> toFireStore() => {
    'DocumentID': docID,
    'Name': name,
    'Country': country,
    'Address': address,
    'ZipCode': zipCode,
    'Email': email,
    'PhoneNumber': phoneNumber,
    'TaxNumber': taxNumber,
    'isDefault': isDefault,
  };

  // Deserialize JSON (Key,Value) to Class for reading from Database
  factory Supplier.fromFireStore(DocumentSnapshot documentSnapshot) {
    Map documentData = documentSnapshot.data;

    return Supplier(
      docID: documentSnapshot.documentID,
      name: documentData['Name'] ?? null,
      country: documentData['Country'] ?? null,
      address: documentData['Address'] ?? null,
      zipCode: documentData['ZipCode'] ?? null,
      email: documentData['Email'] ?? null,
      phoneNumber: documentData['PhoneNumber'] ?? null,
      taxNumber: documentData['TaxNumber'] ?? null,
      isDefault: documentData['isDefault'] ?? null,
    );
  }

  static Supplier findByName(List<Supplier> list, String itemName){
    return list.firstWhere((item) => item.name == itemName);
  }

  static List<Supplier> initStreamData(){
    // Create Empty List with 1 Object for initialization
    List<Supplier> initList = <Supplier>[];
    initList.add(Supplier.empty());
    return initList;
  }

  // Deserialize JSON (Key,Value) to Class for reading from Database
  factory Supplier.fromOrder(Map<String,dynamic> documentData) {

    return Supplier(
      docID: documentData['DocumentID'] ?? null,
      name: documentData['Name'] ?? null,
      country: documentData['Country'] ?? null,
      address: documentData['Address'] ?? null,
      zipCode: documentData['ZipCode'] ?? null,
      email: documentData['Email'] ?? null,
      phoneNumber: documentData['PhoneNumber'] ?? null,
      taxNumber: documentData['TaxNumber'] ?? null,
      isDefault: documentData['isDefault'] ?? null,
    );
  }

}
