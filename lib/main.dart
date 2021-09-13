import 'package:chat_firebase/Auth/providers/auth_provider.dart';
import 'package:chat_firebase/Auth/ui/register_page.dart';
import 'package:chat_firebase/Auth/ui/login_page.dart';
import 'package:chat_firebase/Auth/ui/reset_password_page.dart';
import 'package:chat_firebase/chat/chat_page.dart';
import 'package:chat_firebase/chat/profile_page.dart';
import 'package:chat_firebase/chat/update_page.dart';
import 'package:chat_firebase/chat/users_page.dart';
import 'package:chat_firebase/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_firebase/Auth/ui/auth_main_page.dart';
import 'package:chat_firebase/services/routs_helper.dart';
import 'package:chat_firebase/chat/home_page.dart';

void main() {
  runApp(ChangeNotifierProvider<AuthProvider>(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        navigatorKey: RoutHelpers.routHelpers.navKey,
          debugShowCheckedModeBanner: false,
          home: FirebaseConfigration(),
        routes: {
          LoginPage.routName:(context)=>LoginPage(),
          RegisterPage.routName:(context)=>RegisterPage(),
          ResetPassword.routName:(context)=>ResetPassword(),
          HomePage.routName:(context)=>HomePage(),
          AuthMainPage.routName:(context)=>AuthMainPage(),
          ProfilePage.routName:(context)=>ProfilePage(),
          UsersPage.routName:(context)=>UsersPage(),
          ChatPage.routName:(context)=>ChatPage(),

        },

      )

  ));
}

class FirebaseConfigration extends StatelessWidget {
//  const FirebaseConfigration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(),
        builder: (context, AsyncSnapshot<FirebaseApp> dataSnapShot) {
          if (dataSnapShot.hasError) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: Text(
                  dataSnapShot.error.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }

          if (dataSnapShot.connectionState == ConnectionState.done) {
            return SplashScreen();
          }

          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
