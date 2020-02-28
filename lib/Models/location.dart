import 'package:cloud_firestore/cloud_firestore.dart';

class Location {

  String docID;
  String name;
  String location;
  String address;
  String zipCode;
  bool isDefault;
  int numOfCategories;
  int numOfProducts;
  int totalValue;

  Location({this.docID, this.name, this.location, this.address, this.zipCode,
      this.isDefault, this.numOfCategories, this.numOfProducts,
      this.totalValue});


  // Serialize Class to JSON (Key,Value) for writing to Database
  Map<String, dynamic> toJson() =>
      {
        'DocumentID': docID,
        'Name': name ,
        'Location': location,
        'Address': address,
        'ZipCode': zipCode,
        'isDefault': isDefault,
        'NumberOfCategories': numOfCategories,
        'NumberOfProducts': numOfProducts,
        'TotalValue': totalValue,
      };

  // Deserialize JSON (Key,Value) to Class for reading from Database
  factory Location.fromFireStore(DocumentSnapshot documentSnapshot){
    Map documentData = documentSnapshot.data;

    return Location(
      docID: documentSnapshot.documentID,
      name: documentData['Name'] ?? '',
      location: documentData['Location'] ?? '',
      address: documentData['Address'] ?? '',
      zipCode: documentData['ZipCode'] ?? '',
      isDefault: documentData['isDefault'] ?? '',
      numOfCategories: documentData['NumberOfCategories'] ?? '',
      numOfProducts: documentData['NumberOfProducts'] ?? '',
      totalValue: documentData['TotalValue'] ?? ''
    );
  }






}