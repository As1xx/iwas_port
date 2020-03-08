import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:iwas_port/Models/wine.dart';
import 'package:iwas_port/Services/DatabaseException.dart';

class WineDatabaseService {
  CollectionReference collectionReference;

  WineDatabaseService() {
    this.collectionReference = Firestore.instance.collection('Wines');
  }

  // Get Stream for Reading Data from Database
  Stream<List<Wine>> get wineListOfCollection {
    try {
      return collectionReference.snapshots().map((snapshot) =>
          snapshot.documents.map((doc) => Wine.fromFireStore(doc)).toList());
    } catch (readFromDataBaseError) {
      throw DatabaseException(readFromDataBaseError.message);
    }
  }

  // Write to Database
  Future<bool> writeToDatabase(Wine wineModel) async {
    try {
      var docReference = collectionReference.document(wineModel.docID);
      await docReference.setData(wineModel.toFireStore());
      return true;
    } catch (writeToDataBaseError) {
      throw DatabaseException(writeToDataBaseError.message);
    }
  }

  // Delete from Database
  Future<void> deleteFromDatabase(Wine wineModel) async {
    try {
      var docReference = collectionReference.document(wineModel.docID);
      await docReference.delete();
    } catch (deleteFromDataBaseError) {
      throw DatabaseException(deleteFromDataBaseError.message);
    }
  }


  // Upload image to database and write download link to database Model
  Future uploadImage(File imageFile, Wine wineModel) async {
    try {
      final StorageReference storageReference =
          FirebaseStorage.instance.ref().child("WineImages");
      final StorageUploadTask uploadTask =
          storageReference.child(wineModel.docID).putFile(imageFile);

      var imageURL = await (await uploadTask.onComplete).ref.getDownloadURL();
      var url = imageURL.toString();
      wineModel.imageURL = url;
    } catch (uploadImageError) {
      // default image
      var imageURL = await FirebaseStorage.instance
          .ref()
          .child('Defaults')
          .child('camera_default.png')
          .getDownloadURL();
      wineModel.imageURL = imageURL.toString();
    }
  }

}
