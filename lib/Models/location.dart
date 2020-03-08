import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';

class Location {

  String docID = randomAlphaNumeric(20);
  String name;
  String country;
  String address;
  int zipCode;
  bool isDefault;
  int numOfCategories;
  int numOfProducts;
  double totalValue;

  Location.empty();

  Location({this.docID, this.name, this.country, this.address, this.zipCode,
      this.isDefault, this.numOfCategories, this.numOfProducts,
      this.totalValue});


  // Serialize Class to JSON (Key,Value) for writing to Database
  Map<String, dynamic> toFireStore() =>
      {
        'DocumentID': docID,
        'Name': name ,
        'Country': country,
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
      name: documentData['Name'] ?? null,
      country: documentData['Country'] ?? null,
      address: documentData['Address'] ?? null,
      zipCode: documentData['ZipCode'] ?? null,
      isDefault: documentData['isDefault'] ?? null,
      numOfCategories: documentData['NumberOfCategories'] ?? null,
      numOfProducts: documentData['NumberOfProducts'] ?? null,
      totalValue: documentData['TotalValue'] ?? null
    );
  }






}