import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iwas_port/Models/customer.dart';
import 'package:iwas_port/Services/DatabaseException.dart';

class CustomerDatabaseService {
  CollectionReference collectionReference;

  CustomerDatabaseService() {
    this.collectionReference = Firestore.instance.collection('Customers');
  }

  // Get Stream for Reading Data from Database
  Stream<List<Customer>> get customerListOfCollection {
    try {
      return collectionReference.snapshots().map((snapshot) =>
          snapshot.documents.map((doc) => Customer.fromFireStore(doc)).toList());
    } catch (readFromDataBaseError) {
      throw DatabaseException(readFromDataBaseError.message);
    }
  }

  // Write to Database
  Future<bool> writeToDatabase(Customer customerModel) async {
    try {
      var docReference = collectionReference.document(customerModel.docID);
      await docReference.setData(customerModel.toFireStore());
      return true;
    } catch (writeToDataBaseError) {
      throw DatabaseException(writeToDataBaseError.message);
    }
  }

  // Delete from Database
  Future<void> deleteFromDatabase(Customer customerModel) async {
    try {
      var docReference = collectionReference.document(customerModel.docID);
      await docReference.delete();
    } catch (deleteFromDataBaseError) {
      throw DatabaseException(deleteFromDataBaseError.message);
    }
  }




}
