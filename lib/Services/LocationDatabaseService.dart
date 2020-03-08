import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:iwas_port/Models/location.dart';
import 'package:iwas_port/Services/DatabaseException.dart';

class LocationDatabaseService {
  CollectionReference collectionReference;

  LocationDatabaseService() {
    this.collectionReference = Firestore.instance.collection('Locations');
  }

  // Get Stream for Reading Data from Database
  Stream<List<Location>> get locationListOfCollection {
    try {
      return collectionReference.snapshots().map((snapshot) =>
          snapshot.documents.map((doc) => Location.fromFireStore(doc)).toList());
    } catch (readFromDataBaseError) {
      throw DatabaseException(readFromDataBaseError.message);
    }
  }

  // Write to Database
  Future<bool> writeToDatabase(Location locationModel) async {
    try {
      var docReference = collectionReference.document(locationModel.docID);
      await docReference.setData(locationModel.toFireStore());
      return true;
    } catch (writeToDataBaseError) {
      throw DatabaseException(writeToDataBaseError.message);
    }
  }

  // Delete from Database
  Future<void> deleteFromDatabase(Location locationModel) async {
    try {
      var docReference = collectionReference.document(locationModel.docID);
      await docReference.delete();
    } catch (deleteFromDataBaseError) {
      throw DatabaseException(deleteFromDataBaseError.message);
    }
  }




}
