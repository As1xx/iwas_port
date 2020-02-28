import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:iwas_port/Models/wine.dart';

class DatabaseService{

//TODO: implement Error Handling
  CollectionReference collectionReference;

  DatabaseService(String collectionName){
   this.collectionReference =  Firestore.instance.collection(collectionName);
  }


  // Get Stream for Reading Data from Database
  Stream<List<Wine>> get wineListOfCollection {
    try {
      return collectionReference.snapshots().map((snapshot) =>
          snapshot.documents.map((doc) => Wine.fromFireStore(doc)).toList());

    }catch (readFromDataBaseError){
      print(readFromDataBaseError.toString());
      return  null;
    }
  }

  // Write to Database
  Future<bool> writeToDatabase(Wine wineModel) async {
    try{
      var docReference = collectionReference.document(wineModel.docID);
      await docReference.setData(wineModel.toFireStore());
      print('Data successfully uploaded to Cloud');
      return true;
    }catch (writeToDataBaseError){
      print(writeToDataBaseError.toString());
      return false;
    }

  }


  // Upload image to database and write download link to database Model
  Future uploadImage(File imageFile,Wine wineModel) async {
    try {
      final StorageReference storageReference = FirebaseStorage.instance.ref()
          .child("WineImages");
      final StorageUploadTask uploadTask = storageReference.child(
          wineModel.docID).putFile(imageFile);

      var imageURL = await (await uploadTask.onComplete).ref.getDownloadURL();
      var url = imageURL.toString();
      wineModel.imageURL = url;
      print('Image successfully uploaded to Cloud');

    }catch (uploadImageError){
      print(uploadImageError);
      // default image
      var imageURL = await FirebaseStorage.instance.ref().child('Defaults').child('camera_default.png').getDownloadURL();
      wineModel.imageURL = imageURL.toString();
    }
  }










}

