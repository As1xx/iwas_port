import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:random_string/random_string.dart';

class Supplier {
  String docID = randomAlphaNumeric(20);
  String name;
  String address;
  String phoneNumber;
  String email;
  bool isDefault = false;
  String flag = 'Supplier';

  Supplier.empty();

  Supplier({
    @required this.docID,
    @required this.name,
    @required this.address,
    @required this.flag,
    this.email,
    this.phoneNumber,
    this.isDefault,
  });

  // Serialize Class to JSON (Key,Value) for writing to Database
  Map<String, dynamic> toFireStore() => {
        'DocumentID': docID,
        'Name': name,
        'Address': address,
        'Email': email,
        'PhoneNumber': phoneNumber,
        'isDefault': isDefault,
        'Flag': flag,
      };

  // Deserialize JSON (Key,Value) to Class for reading from Database
  factory Supplier.fromFireStore(DocumentSnapshot documentSnapshot) {
    Map documentData = documentSnapshot.data;

    return Supplier(
      docID: documentSnapshot.documentID,
      name: documentData['Name'] ?? null,
      address: documentData['Address'] ?? null,
      email: documentData['Email'] ?? null,
      phoneNumber: documentData['PhoneNumber'] ?? null,
      isDefault: documentData['isDefault'] ?? null,
      flag: documentData['Flag'] ?? null,
    );
  }

  static Supplier findByName(List<Supplier> list, String itemName) {
    return list.firstWhere((item) => item.name == itemName);
  }

  static List<Supplier> initStreamData() {
    // Create Empty List with 1 Object for initialization
    List<Supplier> initList = <Supplier>[];
    initList.add(Supplier.empty());
    return initList;
  }

  // Deserialize JSON (Key,Value) to Class for reading from Database
  factory Supplier.fromOrder(Map<String, dynamic> documentData) {
    return Supplier(
      docID: documentData['DocumentID'] ?? null,
      name: documentData['Name'] ?? null,
      address: documentData['Address'] ?? null,
      email: documentData['Email'] ?? null,
      phoneNumber: documentData['PhoneNumber'] ?? null,
      isDefault: documentData['isDefault'] ?? null,
      flag: documentData['Flag'] ?? null,
    );
  }
}
