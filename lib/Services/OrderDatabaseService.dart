import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iwas_port/Models/Order.dart';
import 'package:iwas_port/Services/DatabaseException.dart';

class OrderDatabaseService {
  CollectionReference collectionReference;

  OrderDatabaseService() {
    this.collectionReference = Firestore.instance.collection('Orders');
  }

  // Get Stream for Reading Data from Database
  Stream<List<Order>> get orderListOfCollection {
    try {
      return collectionReference.snapshots().map((snapshot) =>
          snapshot.documents.map((doc) => Order().orderFromFireStore(doc)).toList());
    } catch (readFromDataBaseError) {
      throw DatabaseException(readFromDataBaseError.message);
    }
  }

  // Write to Database
  Future<bool> writeToDatabase(Order order) async {
    try {
      var docReference = collectionReference.document(order.docID);
      await docReference.setData(order.toFireStore());
      return true;
    } catch (writeToDataBaseError) {
      throw DatabaseException(writeToDataBaseError.message);
    }
  }

  // Delete from Database
  Future<void> deleteFromDatabase(Order order) async {
    try {
      var docReference = collectionReference.document(order.docID);
      await docReference.delete();
    } catch (deleteFromDataBaseError) {
      throw DatabaseException(deleteFromDataBaseError.message);
    }
  }




}
