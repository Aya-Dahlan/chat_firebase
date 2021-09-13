import 'dart:io';

import 'package:chat_firebase/Auth/helpers/auth_helper.dart';
import 'package:chat_firebase/Auth/helpers/firestorage_helper.dart';
import 'package:chat_firebase/Auth/helpers/firestore_helper.dart';
import 'package:chat_firebase/Auth/models/country_model.dart';
import 'package:chat_firebase/Auth/models/register_request.dart';
import 'package:chat_firebase/Auth/models/user_model.dart';
import 'package:chat_firebase/Auth/ui/auth_main_page.dart';
import 'package:chat_firebase/chat/chat_page.dart';
import 'package:chat_firebase/chat/home_page.dart';
import 'package:chat_firebase/chat/users_page.dart';
import 'package:chat_firebase/services/custom_dialog.dart';
import 'package:chat_firebase/services/routs_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    getCountriesFromFireStore();
  }
  List<UserModel> users;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cituController = TextEditingController();
  String email;
  String password;
  TabController tabController;
  String myId;

  register() async {
    try {
      UserCredential userCredential = await AuthHelper.authHelper
          .signup(emailController.text, passwordController.text);
      String imageUrl =
          await FirebaseStorageHelper.firebaseStorageHelper.uploadImage(file);
      RegisterRequest registerRequest = RegisterRequest(
          imageUrl: imageUrl,
          id: userCredential.user.uid,
          city: selectedCity,
          country: selectedCountry.name,
          email: emailController.text,
          fName: firstNameController.text,
          lName: lastNameController.text,
          password: passwordController.text);
      await FirestoreHelper.firestoreHelper.addUserToFirestore(registerRequest);
      await AuthHelper.authHelper.verifyEmail();
      await AuthHelper.authHelper.logout();
      tabController.animateTo(1);
    } on Exception catch (e) {
      // TODO
    }
// navigate to login
    resetControllers();
  }

  //////////////////////////////////////////////////

  File file;

  selectFile() async {
    XFile imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    this.file = File(imageFile.path);
    notifyListeners();
  }

  /////////////////////////////////////////////////

  login() async {
    UserCredential userCredinial = await AuthHelper.authHelper
        .signin(emailController.text, passwordController.text);
    if (userCredinial != null) {
      FirestoreHelper.firestoreHelper
          .getUserFromFirestore(userCredinial.user.uid);
      bool isVerifiedEmail = AuthHelper.authHelper.checkEmailVertication();
      if (isVerifiedEmail) {
        RoutHelpers.routHelpers.goToPageReplacement(HomePage.routName);
      } else {
        CustomDialog.customDialog.showCustomDialog(
            'You have to verify your email, press ok to send another email',
            sendVericiation);
      }
      resetControllers();
    } else {
      print("Error");
    }
  }

  List<CountryModel> countries;
  List<dynamic> city = [];
  CountryModel selectedCountry;
  String selectedCity;

  selectCountry(CountryModel countryModel) {
    this.selectedCountry = countryModel;
    this.city = countryModel.city;
    selectCity(city.first.toString());
    notifyListeners();
  }

  selectCity(dynamic city) {
    this.selectedCity = city;
    notifyListeners();
  }

  getCountriesFromFireStore() async {
    List<CountryModel> countries =
        await FirestoreHelper.firestoreHelper.getAllCountries();
    print(countries.length);
    this.countries = countries;
    selectCountry(countries.first);
    notifyListeners();
  }

  sendVericiation() {
    AuthHelper.authHelper.verifyEmail();
    AuthHelper.authHelper.logout();
  }

  resetPassword() async {
    AuthHelper.authHelper.resetPassword(emailController.text);
    resetControllers();
  }

  resetControllers() {
    emailController.clear();
    passwordController.clear();
    firstNameController.clear();
    lastNameController.clear();
    countryController.clear();
    cituController.clear();
  }

  checkLogin() {
    bool isLogin = AuthHelper.authHelper.checkUserLogin();
    if (isLogin) {
      this.myId=AuthHelper.authHelper.getUserId();
      getAllUsers();
      RoutHelpers.routHelpers.goToPageReplacement(HomePage.routName);
    } else {
      RoutHelpers.routHelpers.goToPageReplacement(AuthMainPage.routName);
    }
  }

  UserModel user;

  getUserFromFireStore() async {
    String userId = AuthHelper.authHelper.getUserId();
    user = await FirestoreHelper.firestoreHelper.getUserFromFirestore(userId);
    notifyListeners();
  }

  logout() async {
    await AuthHelper.authHelper.logout();
    RoutHelpers.routHelpers.goToPageReplacement(AuthMainPage.routName);
  }

  fillController() async {
    emailController.text = user.email;

    firstNameController.text = user.fName;

    lastNameController.text = user.lName;

    countryController.text = user.country;

    cituController.text = user.city;
  }

  File upatedProfile;

  captureUpdateProfileImage() async {
    XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
    this.upatedProfile = File(file.path);
    notifyListeners();
  }

   sendImageToChat({String message})async{
    XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
    File file2=File(file.path);

   String imageUrl= await FirebaseStorageHelper.firebaseStorageHelper.uploadImage(file2 ,folderName: 'chats');
     FirestoreHelper.firestoreHelper.addMessageToFireStore({
       'userId':this.myId,
       'dateTime':DateTime.now(),
       'message': message ??" ",
       'imageUrl':imageUrl,


     }
     );
  }

  updateProfile() async {
    String imageUrl;
    if (upatedProfile != null) {
      imageUrl = await FirebaseStorageHelper.firebaseStorageHelper
          .uploadImage(upatedProfile);
    }

    UserModel userModel =
     UserModel(
      city: cituController.text,
      country: countryController.text,
      fName: firstNameController.text,
      lName: lastNameController.text,
      id: user.id,
       imageUrl: imageUrl==null?user.imageUrl:imageUrl,

    );


    await FirestoreHelper.firestoreHelper.updateProfile(userModel);
    getUserFromFireStore();

    Navigator.of(RoutHelpers.routHelpers.navKey.currentContext).pop();
  }

  getAllUsers()async{
    users=await FirestoreHelper.firestoreHelper.getAllUsersFromFirestore();
    users.removeWhere((element) => element.id==myId);
    notifyListeners();
  }
}
