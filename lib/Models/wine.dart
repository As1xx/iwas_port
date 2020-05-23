import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:random_string/random_string.dart';



class Wine {

  String docID = randomAlphaNumeric(20);
  String manufacturer;
  String type ;
  int productID;
  String imageURL = 'https://firebasestorage.googleapis.com/v0/b/iwas-mit-port.appspot.com/o/Defaults%2Fcamera_default.png?alt=media&token=61b25e74-210a-4c63-b6dd-b88fe09be0a4';
  double purchasePrice;
  double sellingPrice;
  int criticalQuantity;
  int quantity;

  Wine.empty();

  Wine({
    @required this.docID,
    @required this.manufacturer,
    @required this.type,
    @required this.productID,
    @required this.imageURL,
    @required this.purchasePrice,
    @required this.sellingPrice,
    this.criticalQuantity,
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
        'PurchasePrice': purchasePrice,
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
      purchasePrice: documentData['PurchasePrice'] ?? null,
      sellingPrice: documentData['SellingPrice'] ?? null,
      quantity: documentData['Quantity'] ?? null,

    );
  }


  static List<Wine> initStreamData() {
    // Create Empty List with 1 Object for initialization
    //List<Wine> initList = null;
    //initList.add(Wine.empty());
    //return initList;
  }




}