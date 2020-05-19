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
  bool isSold = true;

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
      @required this.isSold,
      this.note = ''});

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
        'IsSold?': isSold,
      };

  // Deserialize JSON (Key,Value) to Class for reading from Database
  factory Order.fromFireStore(DocumentSnapshot documentSnapshot) {
    Map documentData = documentSnapshot.data;

    var list = documentData['Products'] as List;
    List<CartItem> cartItemList =
        list.map((item) => CartItem.fromFireStore(item)).toList();

    return Order(
      docID: documentSnapshot.documentID ?? null,
      user: documentData['User'] ?? null,
      location: Location.fromOrder(documentData['Location']) ?? null,
      supplier: Supplier.fromOrder(documentData['Supplier']) ?? null,
      customer: Customer.fromOrder(documentData['Customer']) ?? null,
      products: cartItemList ?? null,
      date: DateTime.fromMillisecondsSinceEpoch(
              documentData['Date'].millisecondsSinceEpoch) ??
          null,
      amount: documentData['Amount'] ?? null,
      discount: documentData['Discount'] ?? null,
      tax: documentData['Tax'] ?? null,
      note: documentData['Note'] ?? null,
      isPaymentPending: documentData['PaymentPending?'] ?? null,
      paymentMethod: documentData['PaymentMethod'] ?? null,
      isSold: documentData['IsSold?'] ?? null,
    );
  }

  static List<Order> initStreamData() {
    // Create Empty List with 1 Object for initialization
    List<Order> initList = <Order>[];
    initList.add(Order.empty());
    return initList;
  }

  int get totalOrderQuantity {

      int totalQuantity = 0;
      products.forEach((cartItem) {
        totalQuantity += cartItem.quantity;
      });
      return totalQuantity;
  }

}
