import 'package:chat_firebase/chat/profile_page.dart';
import 'package:chat_firebase/chat/users_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  // const HomePage({Key? key}) : super(key: key);
  static final routName = "Home";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: TabBarView(
             children: [
              UsersPage(),
               ProfilePage(),

             ],
      )),
    );
  }
}
