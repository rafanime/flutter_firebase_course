import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complex_ui/data/local/models/user.dart';

class FirestoreService {
  Firestore firestore = Firestore.instance;

  Future<User> getUser(uid) async {
    DocumentSnapshot snapshot =
        await firestore.collection('user').document(uid).get();

    return User(
      uid: uid,
      email: snapshot.data['email'],
    );
  }

  Stream<List<User>> get users =>
      firestore.collection('user').snapshots().map(_usersFromSnapshot);

  List<User> _usersFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map(
      (document) => User(
        uid: document.documentID,
        email: document.data['email'],
      ),
    );
  }

  Future<List<DocumentSnapshot>> getCollection(String collectionName) async {
    return await firestore
        .collection(collectionName)
        .getDocuments()
        .then((query) => query.documents);
  }

  void updateDocument(String collection, String id, Object data) async {
    await firestore.collection(collection).document(id).updateData(data);
  }
}
