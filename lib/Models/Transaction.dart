

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iwas_port/Models/customer.dart';
import 'package:iwas_port/Models/location.dart';
import 'package:iwas_port/Models/supplier.dart';
import 'package:iwas_port/Models/wine.dart';
import 'package:random_string/random_string.dart';

class Transaction {
  static const taxPercent = 0.19;
  String docID = randomAlphaNumeric(20);
  String user;
  Location location;
  Supplier supplier;
  Customer customer;
  List<Wine> products;
  DateTime date;
  double amount;
  double discount = 0;
  double tax = 0;

  Transaction.empty();

  Transaction(
      {@required this.docID,
      @required this.user,
      @required this.location,
      @required this.supplier,
      @required this.customer,
      @required this.products,
      @required this.date,
      @required this.amount,
      @required this.discount,
      @required this.tax});

  // Serialize Class to JSON (Key,Value) for writing to Database
  Map<String, dynamic> toFireStore() => {
        'DocumentID': docID,
        'User': user,
        'Location': location.toFireStore(),
        'Supplier': supplier.toFireStore(),
        'Customer': customer.toFireStore(),
        'Products': products,
        'Date': date,
        'Amount': amount,
        'Discount': discount,
        'Tax': tax,
      };

  // Deserialize JSON (Key,Value) to Class for reading from Database
  factory Transaction.fromFireStore(DocumentSnapshot documentSnapshot) {
    Map documentData = documentSnapshot.data;

    return Transaction(
      docID: documentSnapshot.documentID ?? null,
      user: documentData['User'] ?? null,
      location: Location.fromFireStore(documentSnapshot) ?? null,
      supplier: Supplier.fromFireStore(documentSnapshot) ?? null,
      customer: Customer.fromFireStore(documentSnapshot) ?? null,
      products: documentData['Products'] ?? null,
      date: documentData['Date'] ?? null,
      amount: documentData['Amount'] ?? null,
      discount: documentData['Discount'] ?? null,
      tax: documentData['Tax'] ?? null,
    );
  }
}
