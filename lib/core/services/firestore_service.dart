import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService(this._firestore);

  // Get collection reference
  CollectionReference collection(String path) {
    return _firestore.collection(path);
  }

  // Get document reference
  DocumentReference doc(String path) {
    return _firestore.doc(path);
  }

  // Add document to collection
  Future<DocumentReference> addDocument({
    required String collectionPath,
    required Map<String, dynamic> data,
  }) async {
    return await _firestore.collection(collectionPath).add(data);
  }

  // Set document data
  Future<void> setDocument({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    await _firestore.doc(path).set(data, SetOptions(merge: merge));
  }

  // Update document
  Future<void> updateDocument({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.doc(path).update(data);
  }

  // Delete document
  Future<void> deleteDocument(String path) async {
    await _firestore.doc(path).delete();
  }

  // Get document
  Future<DocumentSnapshot> getDocument(String path) async {
    return await _firestore.doc(path).get();
  }

  // Get collection
  Future<QuerySnapshot> getCollection(String path) async {
    return await _firestore.collection(path).get();
  }

  // Stream document
  Stream<DocumentSnapshot> streamDocument(String path) {
    return _firestore.doc(path).snapshots();
  }

  // Stream collection
  Stream<QuerySnapshot> streamCollection(String path) {
    return _firestore.collection(path).snapshots();
  }

  // Query collection
  Future<QuerySnapshot> queryCollection({
    required String collectionPath,
    List<QueryFilter>? filters,
    List<QueryOrder>? orderBy,
    int? limit,
  }) async {
    Query query = _firestore.collection(collectionPath);

    if (filters != null) {
      for (var filter in filters) {
        query = query.where(
          filter.field,
          isEqualTo: filter.isEqualTo,
          isNotEqualTo: filter.isNotEqualTo,
          isLessThan: filter.isLessThan,
          isLessThanOrEqualTo: filter.isLessThanOrEqualTo,
          isGreaterThan: filter.isGreaterThan,
          isGreaterThanOrEqualTo: filter.isGreaterThanOrEqualTo,
          arrayContains: filter.arrayContains,
          arrayContainsAny: filter.arrayContainsAny,
          whereIn: filter.whereIn,
          whereNotIn: filter.whereNotIn,
          isNull: filter.isNull,
        );
      }
    }

    if (orderBy != null) {
      for (var order in orderBy) {
        query = query.orderBy(order.field, descending: order.descending);
      }
    }

    if (limit != null) {
      query = query.limit(limit);
    }

    return await query.get();
  }

  // Batch write
  WriteBatch batch() {
    return _firestore.batch();
  }

  // Transaction
  Future<T> runTransaction<T>(TransactionHandler<T> transactionHandler) async {
    return await _firestore.runTransaction(transactionHandler);
  }
}

// Helper classes for queries
class QueryFilter {
  final String field;
  final dynamic isEqualTo;
  final dynamic isNotEqualTo;
  final dynamic isLessThan;
  final dynamic isLessThanOrEqualTo;
  final dynamic isGreaterThan;
  final dynamic isGreaterThanOrEqualTo;
  final dynamic arrayContains;
  final List<dynamic>? arrayContainsAny;
  final List<dynamic>? whereIn;
  final List<dynamic>? whereNotIn;
  final bool? isNull;

  QueryFilter({
    required this.field,
    this.isEqualTo,
    this.isNotEqualTo,
    this.isLessThan,
    this.isLessThanOrEqualTo,
    this.isGreaterThan,
    this.isGreaterThanOrEqualTo,
    this.arrayContains,
    this.arrayContainsAny,
    this.whereIn,
    this.whereNotIn,
    this.isNull,
  });
}

class QueryOrder {
  final String field;
  final bool descending;

  QueryOrder({required this.field, this.descending = false});
}
