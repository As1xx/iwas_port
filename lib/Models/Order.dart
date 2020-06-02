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
  String user;
  List<CartItem> products;
  DateTime date;
  double amount = 0;
  double discount = 0;
  double tax;
  String note = '';
  bool isPaymentPending = false;
  String paymentMethod = 'Bank Transfer';
  String method = 'Verkaufen';
  Object from;
  Object to;

  Order.empty();

  Order(
      {@required this.docID,
      @required this.user,
      @required this.products,
      @required this.date,
      @required this.amount,
      @required this.discount,
      @required this.tax,
      @required this.isPaymentPending,
      @required this.paymentMethod,
      @required this.method,
      @required this.from,
      @required this.to,
      this.note = ''});

  // Serialize Class to JSON (Key,Value) for writing to Database

  Map<String, dynamic> checkObjectTypeToFireStore(Object object) {
    if (object is Location) {
      Location location = object;
      return location.toFireStore();
    } else if (object is Supplier) {
      Supplier supplier = object;
      return supplier.toFireStore();
    } else if (object is Customer) {
      Customer customer = object;
      return customer.toFireStore();
    }else{
      return null;
    }

  }


  Map<String, dynamic> toFireStore() => {
        'DocumentID': docID,
        'User': user,
        'Products': products.map((product) => product.toFireStore()).toList(),
        'Date': date,
        'Amount': amount,
        'Discount': discount,
        'Tax': tax,
        'Note': note,
        'PaymentPending?': isPaymentPending,
        'PaymentMethod': paymentMethod,
        'Method': method,
        'From': checkObjectTypeToFireStore(from),
        'To': checkObjectTypeToFireStore(to),
      };

  // Deserialize JSON (Key,Value) to Class for reading from Database
    Order orderFromFireStore(DocumentSnapshot documentSnapshot) {
    Map documentData = documentSnapshot.data;

    var list = documentData['Products'] as List;
    List<CartItem> cartItemList =
        list.map((item) => CartItem.fromFireStore(item)).toList();

    T checkObjectTypeFromFireStore<T>(Map documentData,String objectName) {
      if (documentData[objectName]['Flag'] == 'Location') {
        return Location.fromOrder(documentData[objectName]) as T;
      } else if (documentData[objectName]['Flag'] == 'Supplier') {
        return Supplier.fromOrder(documentData[objectName]) as T;
      } else if (documentData[objectName]['Flag'] == 'Customer') {
        return Customer.fromOrder(documentData[objectName]) as T;
      }else{
        return null;
      }
    }


    return Order(
        docID: documentSnapshot.documentID ?? null,
        user: documentData['User'] ?? null,
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
        method: documentData['Method'] ?? null,
        from: checkObjectTypeFromFireStore(documentData, 'From'),
        to: checkObjectTypeFromFireStore(documentData, 'To'),
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
