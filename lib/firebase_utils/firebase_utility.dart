import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/ui/models/event_dm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../ui/models/user_dm.dart';

Future<void> createUserInFirestore(UserDm user) async {
  var userCollection = FirebaseFirestore.instance.collection("users");
  var document = userCollection.doc(
    user.id,
  ); //create or search for document with id
  document.set(user.toJson());
}

Future<UserDm> getUserFromFireStore(String uid) async {
  var userCollection = FirebaseFirestore.instance.collection("users");
  DocumentSnapshot snapshot = await userCollection.doc(uid).get();
  Map<String, dynamic> json = snapshot.data() as Map<String, dynamic>;
  return UserDm.fromJson(json);
}

Future<UserDm> signInWithGoogle() async {
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;
  await googleSignIn.initialize(
    serverClientId:
        "714001076404-d6uocaqglh4rcr0uhtv7ql4oj97nj68k.apps.googleusercontent.com",
  );
  final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

  final GoogleSignInAuthentication googleAuth = googleUser.authentication;

  final credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken);

  final UserCredential userCredential = await FirebaseAuth.instance
      .signInWithCredential(credential);
  UserDm user = UserDm(
    id: userCredential.user!.uid,
    name: userCredential.user!.displayName ?? "No Name",
    email: userCredential.user!.email!,
  );
  return user;
}


Future<void> createEventInFirestore(EventDm event) async {
  CollectionReference eventCollection = FirebaseFirestore.instance.collection(
    "events",
  );
  DocumentReference document = eventCollection.doc();
  event.eventID = document.id;
  await document.set(event.toJson());
}

Stream<List<EventDm>> getEventsFromFireStore() {
  CollectionReference eventCollection = FirebaseFirestore.instance.collection(
    "events",
  );
  // QuerySnapshot snapshots= await eventCollection.get();
  // List<EventDm> events =snapshots.docs.map((doc){
  //   Map<String,dynamic> json=doc.data() as Map<String,dynamic>;
  //   return EventDm.fromJson(json);
  // }).toList();
  // return events;
  Stream<QuerySnapshot> stream = eventCollection.snapshots();
  Stream<List<EventDm>> events = stream.map((snapshot) {
    return snapshot.docs.map((doc) {
      Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
      return EventDm.fromJson(json);
    }).toList();
  });
  return events;
}
void updateEventInFireStore( String eventID,CategoriesDM?categories,String? title ,String? desc,DateTime? dateTime){
  DocumentReference documentRef=FirebaseFirestore.instance.collection("events").doc(eventID);
    documentRef.update({
      "categories": {
        "icon":categories!.icon.codePoint,
        "imagePath":categories.imagePath,
        "name":categories.name,
      },
      "dateTime":dateTime,
      "title":title,
      "desc":desc,
    });

}
void removeEvent(String eventID){
  DocumentReference documentRef=FirebaseFirestore.instance.collection("events").doc(eventID);
documentRef.delete();
}

void addEventToFavourite(String eventID, UserDm user) {
  CollectionReference userCollection = FirebaseFirestore.instance.collection(
    "users",
  );
  DocumentReference userDoc = userCollection.doc(user.id);
  List<String> favouriteEvents = List.of(user.favoriteEvents);
  favouriteEvents.add(eventID);
  user.favoriteEvents = favouriteEvents;
  userDoc.update({"favorites": user.favoriteEvents});
}

void removeEventFromFavourite(String eventID, UserDm user) {
  CollectionReference userCollection = FirebaseFirestore.instance.collection(
    "users",
  );
  DocumentReference userDoc = userCollection.doc(user.id);
  user.favoriteEvents.remove(eventID);
  userDoc.update({"favorites": user.favoriteEvents});
}

Future<List<EventDm>> getFavouriteEvents() async {
  if (UserDm.currentUser!.favoriteEvents.isEmpty) return [];
  CollectionReference eventCollection = FirebaseFirestore.instance.collection(
    "events",
  );
  QuerySnapshot snapshots = await eventCollection
      .where("eventId", whereIn: UserDm.currentUser!.favoriteEvents)
      .get();
  List<EventDm> events = snapshots.docs.map((doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return EventDm.fromJson(json);
  }).toList();
  return events;
}
