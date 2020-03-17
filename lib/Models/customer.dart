import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:random_string/random_string.dart';

class Customer {
  String docID = randomAlphaNumeric(20);
  String name = '';
  String country = '';
  String address = '';
  int zipCode = 0;
  String phoneNumber = '';
  String email = '' ;
  String taxNumber = '';
  bool isInvoiceAddress = false;
  String invoiceAddress = '';

  Customer.empty();

  Customer({
    @required this.docID,
    @required this.name,
    this.country,
    this.address,
    this.zipCode,
    this.email,
    this.invoiceAddress,
    this.isInvoiceAddress,
    this.phoneNumber,
    this.taxNumber,
  });

  // Serialize Class to JSON (Key,Value) for writing to Database
  Map<String, dynamic> toFireStore() => {
        'DocumentID': docID,
        'Name': name,
        'Country': country,
        'Address': address,
        'ZipCode': zipCode,
        'Email': email,
        'InvoiceAddress': invoiceAddress,
        'isInvoiceAddress': isInvoiceAddress,
        'PhoneNumber': phoneNumber,
        'TaxNumber': taxNumber,
      };

  // Deserialize JSON (Key,Value) to Class for reading from Database
  factory Customer.fromFireStore(DocumentSnapshot documentSnapshot) {
    Map documentData = documentSnapshot.data;

    return Customer(
      docID: documentSnapshot.documentID,
      name: documentData['Name'] ?? null,
      country: documentData['Country'] ?? null,
      address: documentData['Address'] ?? null,
      zipCode: documentData['ZipCode'] ?? null,
      email: documentData['Email'] ?? null,
      isInvoiceAddress: documentData['isInvoiceAddress'] ?? null,
      invoiceAddress: documentData['InvoiceAddress'] ?? null,
      phoneNumber: documentData['PhoneNumber'] ?? null,
      taxNumber: documentData['TaxNumber'] ?? null,
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
}
