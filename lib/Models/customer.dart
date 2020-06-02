import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:random_string/random_string.dart';

class Customer {
  String docID = randomAlphaNumeric(20);
  String name;
  String address;
  String phoneNumber;
  String email;
  bool isInvoiceAddress = false;
  String invoiceAddress;
  String flag = 'Customer';

  Customer.empty();

  Customer({
    @required this.docID,
    @required this.name,
    @required this.address,
    @required this.flag,
    this.email,
    this.invoiceAddress,
    this.isInvoiceAddress,
    this.phoneNumber,
  });

  // Serialize Class to JSON (Key,Value) for writing to Database
  Map<String, dynamic> toFireStore() => {
        'DocumentID': docID,
        'Name': name,
        'Address': address,
        'Email': email,
        'InvoiceAddress': invoiceAddress,
        'isInvoiceAddress': isInvoiceAddress,
        'PhoneNumber': phoneNumber,
        'Flag': flag,
      };

  // Deserialize JSON (Key,Value) to Class for reading from Database
  factory Customer.fromFireStore(DocumentSnapshot documentSnapshot) {
    Map documentData = documentSnapshot.data;

    return Customer(
      docID: documentSnapshot.documentID,
      name: documentData['Name'] ?? null,
      address: documentData['Address'] ?? null,
      email: documentData['Email'] ?? null,
      isInvoiceAddress: documentData['isInvoiceAddress'] ?? null,
      invoiceAddress: documentData['InvoiceAddress'] ?? null,
      phoneNumber: documentData['PhoneNumber'] ?? null,
      flag: documentData['Flag'] ?? null,
    );
  }

  static Customer findByName(List<Customer> list, String itemName) {
    return list.firstWhere((item) => item.name == itemName);
  }

  static List<Customer> initStreamData() {
    // Create Empty List with 1 Object for initialization
    List<Customer> initList = <Customer>[];
    initList.add(Customer.empty());
    return initList;
  }

  // Deserialize JSON (Key,Value) to Class for reading from Database
  factory Customer.fromOrder(Map<String, dynamic> documentData) {
    return Customer(
      docID: documentData['DocumentID'] ?? null,
      name: documentData['Name'] ?? null,
      address: documentData['Address'] ?? null,
      email: documentData['Email'] ?? null,
      isInvoiceAddress: documentData['isInvoiceAddress'] ?? null,
      invoiceAddress: documentData['InvoiceAddress'] ?? null,
      phoneNumber: documentData['PhoneNumber'] ?? null,
      flag: documentData['Flag'] ?? null,
    );
  }
}
