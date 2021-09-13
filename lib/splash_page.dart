import 'package:chat_firebase/Auth/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  //const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3)).then((value) =>
        Provider.of<AuthProvider>(context, listen: false).checkLogin());
    return Scaffold(

        body: SafeArea(
          child: Stack(
            children: [
              Image.asset(
                  "images/Samsung Galaxy S10 – 6.png",
                height: double.infinity,
                width: double.infinity,
                fit:BoxFit.cover,

              ),

              Center(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "CHAT APP",
                    style: TextStyle(
                      fontSize: 30,

                      letterSpacing: 5,
                      color: Color(0xFFFFC539),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "By Aya Dahlan",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),

            ],

          ),
        ));
  }
}
