import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/models/coffee.dart';
import 'package:coffee_app/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});
  final CollectionReference coffeeCollection =
      FirebaseFirestore.instance.collection('coffeeapp');

  Future updateUserData(String sugars, int strength, String name) async {
    return await coffeeCollection
        .doc(uid)
        .set({'sugars': sugars, 'strength': strength, 'name': name});
  }

  Stream<List<Coffee>> get coffee {
    return coffeeCollection.snapshots().map(_coffeeListFromSnapshot);
  }

  List<Coffee> _coffeeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Coffee(
          name: doc.data()['name'] ?? '',
          strength: doc.data()['strength'] ?? 0,
          sugars: doc.data()['sugars'] ?? '0');
    }).toList();
  }

  // userdata from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data()['name'],
        sugars: snapshot.data()['sugars'],
        strength: snapshot.data()['strength']);
  }

  // get user doc stream
  Stream<UserData> get userdata {
    return coffeeCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
