import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:random_string/random_string.dart';


class Wine {

  String docID = randomAlphaNumeric(20);
  String manufacturer;
  String type;
  int productID;
  int criticalQuantity;
  String imageURL;
  double sellingPrice;
  int quantity;

  Wine.empty();
  Wine({
    @required this.docID,
    @required this.manufacturer,
    @required this.type,
    @required this.productID,
    @required this.criticalQuantity,
    @required this.imageURL,
    @required this.sellingPrice,
    this.quantity,
  });




  // Serialize Class to JSON (Key,Value) for writing to Database
  Map<String, dynamic> toFireStore() =>
      {
        'DocumentID': docID,
        'Manufacturer': manufacturer ,
        'Type': type,
        'ProductID': productID,
        'CriticalQuantity': criticalQuantity,
        'ImageURL': imageURL,
        'SellingPrice': sellingPrice,
        'Quantity': quantity,
      };

  // Deserialize JSON (Key,Value) to Class for reading from Database
  factory Wine.fromFireStore(DocumentSnapshot documentSnapshot){
    Map documentData = documentSnapshot.data;

    return Wine(
      docID: documentSnapshot.documentID ?? null,
      manufacturer: documentData['Manufacturer'] ?? null,
      type: documentData['Type'] ?? null,
      productID: documentData['ProductID'] ?? null,
      criticalQuantity: documentData['CriticalQuantity'] ?? null,
      imageURL: documentData['ImageURL'] ?? null,
      sellingPrice: documentData['SellingPrice'] ?? null,
      quantity: documentData['Quantity'] ?? null,

    );
  }






}