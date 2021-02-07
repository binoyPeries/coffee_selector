import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:net_ninja_coffee/models/coffee.dart';
import 'package:net_ninja_coffee/models/userData.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference coffeeCollection =
      FirebaseFirestore.instance.collection("Coffee");
  Future updateUserData(String sugar, String name, int strength) async {
    return await coffeeCollection
        .doc(uid)
        .set({'Sugars': sugar, 'Name': name, 'Strength': strength});
  }

  //coffes from databse
  List<Coffee> _coffeListfromSnapshot(QuerySnapshot qs) {
    return qs.docs.map((doc) {
      return Coffee(
          name: doc.data()['Name'] ?? '',
          sugars: doc.data()['Sugars'] ?? '0',
          strength: doc.data()['Strength'] ?? 0);
    }).toList();
  }

  //get coffees
  Stream<List<Coffee>> get getcoffees {
    return coffeeCollection.snapshots().map(_coffeListfromSnapshot);
  }

  // convert doc to a user data

  UserData _userDataSnapshot(DocumentSnapshot ds) {
    return UserData(
        uid: uid,
        sugars: ds.data()['Sugars'],
        name: ds.data()['Name'],
        strength: ds.data()['Strength']);
  }

  //get user doc
  Stream<UserData> get getUserData {
    return coffeeCollection.doc(uid).snapshots().map(_userDataSnapshot);
  }
}
