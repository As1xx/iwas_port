import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iwas_port/Models/supplier.dart';
import 'package:iwas_port/Services/DatabaseException.dart';

class SupplierDatabaseService {
  CollectionReference collectionReference;

  SupplierDatabaseService() {
    this.collectionReference = Firestore.instance.collection('Suppliers');
  }

  // Get Stream for Reading Data from Database
  Stream<List<Supplier>> get supplierListOfCollection {
    try {
      return collectionReference.snapshots().map((snapshot) =>
          snapshot.documents.map((doc) => Supplier.fromFireStore(doc)).toList());
    } catch (readFromDataBaseError) {
      throw DatabaseException(readFromDataBaseError.message);
    }
  }

  // Write to Database
  Future<bool> writeToDatabase(Supplier supplierModel) async {
    try {
      var docReference = collectionReference.document(supplierModel.docID);
      await docReference.setData(supplierModel.toFireStore());
      return true;
    } catch (writeToDataBaseError) {
      throw DatabaseException(writeToDataBaseError.message);
    }
  }

  // Delete from Database
  Future<void> deleteFromDatabase(Supplier supplierModel) async {
    try {
      var docReference = collectionReference.document(supplierModel.docID);
      await docReference.delete();
    } catch (deleteFromDataBaseError) {
      throw DatabaseException(deleteFromDataBaseError.message);
    }
  }




}
