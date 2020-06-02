import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String imageURL;
  final String manufacturer;
  final String type;
  final int quantity;
  final double price;
  final int maxStockQuantity;

  CartItem(
      {@required this.id,
        @required this.manufacturer,
        @required this.type,
        @required this.price,
        @required this.maxStockQuantity,
        this.imageURL,
        @ required this.quantity});


  Map<String, dynamic> toFireStore() => {
    'ID': id,
    'ImageURL': imageURL,
    'Manufacturer': manufacturer,
    'Type': type,
    'Quantity': quantity,
    'Price': price,
    'MaxStockQuantity': maxStockQuantity,
  };

  // Deserialize JSON (Key,Value) to Class for reading from Database
  factory CartItem.fromFireStore(Map<String, dynamic> documentData) {


    return CartItem(
      id: documentData['ID'] ?? null,
      imageURL: documentData['ImageURL'] ?? null,
      manufacturer: documentData['Manufacturer'] ?? null,
      type: documentData['Type']  ?? null,
      quantity: documentData['Quantity']  ?? null,
      price: documentData['Price'] ?? null,
      maxStockQuantity: documentData['MaxStockQuantity'] ?? null,
    );
  }

}