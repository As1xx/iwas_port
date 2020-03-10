import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:random_string/random_string.dart';


class Wine {

  String docID = randomAlphaNumeric(20);
  String manufacturer;
  String type;
  int productID;
  int quantity;
  int criticalQuantity;
  String location;
  String imageURL;
  String supplier;
  double purchasePrice;
  double sellingPrice;

  Wine.empty();
  Wine({
    @required this.docID,
    @required this.manufacturer,
    @required this.type,
    @required this.productID,
    @required this.criticalQuantity,
    @required this.quantity,
    @required this.location,
    @required this.imageURL,
    @required this.supplier,
    @required this.purchasePrice,
    @required this.sellingPrice
  });




  // Serialize Class to JSON (Key,Value) for writing to Database
  Map<String, dynamic> toFireStore() =>
      {
        'DocumentID': docID,
        'Manufacturer': manufacturer ,
        'Type': type,
        'ProductID': productID,
        'CriticalQuantity': criticalQuantity,
        'Quantity': quantity,
        'Location': location,
        'ImageURL': imageURL,
        'Supplier': supplier,
        'PurchasePrice': purchasePrice,
        'SellingPrice': sellingPrice,
      };

  // Deserialize JSON (Key,Value) to Class for reading from Database
  factory Wine.fromFireStore(DocumentSnapshot documentSnapshot){
    Map documentData = documentSnapshot.data;

    return Wine(
      docID: documentSnapshot.documentID ?? null,
      manufacturer: documentData['Manufacturer'] ?? null,
      type: documentData['Type'] ?? null,
      productID: documentData['ProductID'] ?? null,
      quantity: documentData['Quantity'] ?? null,
      criticalQuantity: documentData['CriticalQuantity'] ?? null,
      location: documentData['Location'] ?? null,
      imageURL: documentData['ImageURL'] ?? null,
      supplier: documentData['Supplier'] ?? null,
      purchasePrice: documentData['PurchasePrice'] ?? null,
      sellingPrice: documentData['SellingPrice'] ?? null,

    );
  }






}