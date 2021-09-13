import 'package:chat_firebase/Auth/helpers/auth_helper.dart';
import 'package:chat_firebase/Auth/models/country_model.dart';
import 'package:chat_firebase/Auth/models/register_request.dart';
import 'package:chat_firebase/Auth/models/user_model.dart';
import 'package:chat_firebase/Auth/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  FirestoreHelper._();

  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    addMessageToFireStore(Map map)async{
      FirebaseFirestore.instance
          .collection('Chats')

          .add({...map,'userId':AuthHelper.authHelper.getUserId()});
    }

  addUserToFirestore(RegisterRequest registerRequest) async {
    try {
      // await firebaseFirestore.collection('Users').add(registerRequest.toMap());
      await firebaseFirestore
          .collection('Users')
          .doc(registerRequest.id)
          .set(registerRequest.toMap());
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<UserModel> getUserFromFirestore(String userId) async {
    DocumentSnapshot documentSnapshot =
        await firebaseFirestore.collection('Users').doc(userId).get();
    return UserModel.fromMap(documentSnapshot.data());
  }

  Future<List<UserModel>> getAllUsersFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firebaseFirestore.collection('Users').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<UserModel> users =
        docs.map((e) => UserModel.fromMap(e.data())).toList();
    print(users.length);
    return users;
  }

  Future<List<CountryModel>> getAllCountries() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firebaseFirestore.collection('country').get();

      List<CountryModel> countries = querySnapshot.docs.map((e) {
        Map map = e.data();
        map['id'] = e.id;

        return CountryModel.fromJason(map);
      }).toList();
      return countries;
    } on Exception catch (e) {
      // TODO
    }
  }

  updateProfile(UserModel userModel) async {
   await  firebaseFirestore
        .collection('Users')
        .doc(userModel.id).update(userModel.toMap());
  }
 Stream< QuerySnapshot<Map<String, dynamic>>> getFirestoreStream(){
      return firebaseFirestore.
           collection('Chats')
          .orderBy('dateTime')
          .snapshots();
  }
}
