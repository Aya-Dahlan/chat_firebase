import 'package:chat_firebase/Auth/ui/register_page.dart';
import 'package:flutter/material.dart';
import 'package:chat_firebase/Auth/ui/login_page.dart';
import 'package:provider/provider.dart';
import 'package:chat_firebase/Auth/providers/auth_provider.dart';


class AuthMainPage extends StatefulWidget {
 // const AuthMainPage({Key? key}) : super(key: key);
  static final routName='AuthMain';

  @override
  _AuthMainPageState createState() => _AuthMainPageState();
}

class _AuthMainPageState extends State<AuthMainPage> with SingleTickerProviderStateMixin{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AuthProvider>(context,listen: false).tabController =TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor:  Color(0xFFFFC539),
        title: Text("Main Page"),
        bottom: TabBar(
          controller: Provider.of<AuthProvider>(context).tabController,
          tabs: [
            Text("Register"),
            Text("Login"),


          ],

          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Colors.black,
          indicatorWeight: 0.7,



        ),
      ),
      body: TabBarView(
        controller: Provider.of<AuthProvider>(context).tabController,
        children: [

          RegisterPage(),
          LoginPage(),
        ],

      ),
    );
  }
}
