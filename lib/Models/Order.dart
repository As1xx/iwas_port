import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iwas_port/Models/CartItem.dart';
import 'package:iwas_port/Models/customer.dart';
import 'package:iwas_port/Models/location.dart';
import 'package:iwas_port/Models/supplier.dart';
import 'package:random_string/random_string.dart';

class Order {
  static const taxPercent = 0.19;
  String docID = randomAlphaNumeric(20);
  String user = '';
  Location location = Location.empty();
  Supplier supplier = Supplier.empty();
  Customer customer = Customer.empty();
  List<CartItem> products = <CartItem>[];
  DateTime date = DateTime.now();
  double amount = 0;
  double discount = 0;
  double tax = 0;
  String note = '';
  bool isPaymentPending = false;
  String paymentMethod = '';

  Order.empty();

  Order(
      {@required this.docID,
      @required this.user,
      @required this.location,
      @required this.supplier,
      @required this.customer,
      @required this.products,
      @required this.date,
      @required this.amount,
      @required this.discount,
      @required this.tax,
      @required this.isPaymentPending,
      @required this.paymentMethod,
      this.note = ''});

  //TODO: map CartItem of List to FIrestore
  // Serialize Class to JSON (Key,Value) for writing to Database
  Map<String, dynamic> toFireStore() => {
        'DocumentID': docID,
        'User': user,
        'Location': location.toFireStore(),
        'Supplier': supplier.toFireStore(),
        'Customer': customer.toFireStore(),
        'Products': products.map((product) => product.toFireStore()).toList(),
        'Date': date,
        'Amount': amount,
        'Discount': discount,
        'Tax': tax,
        'Note': note,
        'PaymentPending?': isPaymentPending,
        'PaymentMethod': paymentMethod,
      };

  // Deserialize JSON (Key,Value) to Class for reading from Database
  factory Order.fromFireStore(DocumentSnapshot documentSnapshot) {
    Map documentData = documentSnapshot.data;

    return Order(
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
      note: documentData['Note'] ?? null,
      isPaymentPending: documentData['PaymentPending?'] ?? null,
      paymentMethod: documentData['PaymentMethod'] ?? null,
    );
  }
}
