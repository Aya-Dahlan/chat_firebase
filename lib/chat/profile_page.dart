import 'package:chat_firebase/Auth/providers/auth_provider.dart';
import 'package:chat_firebase/chat/update_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  // const HomePage({Key? key}) : super(key: key);
  static final routName = "Profile";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).getUserFromFireStore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFEDF2F7),
        appBar: AppBar(

          backgroundColor: Color(0xFFFFC539),
          title: Text("Profile Page"),
          actions: [
            IconButton(
                icon: Icon(Icons.edit),

                onPressed: (){
              Provider.of<AuthProvider>(context,listen: false).fillController();
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return UpdatePage();
              }));
            }),
            IconButton(icon: Icon(Icons.logout), onPressed: (){
              Provider.of<AuthProvider>(context,listen: false).logout();
            }),
          ],

        ),
        body: Consumer<AuthProvider>(
          builder: (context, provider, x) {
            return provider.user == null
                ? Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                        CircleAvatar(

                          radius: 80,
                          foregroundColor:  Color(0xFFFFC539),
                          backgroundImage: NetworkImage(

                            provider.user.imageUrl,

                          ),
                        ),
                        ItemWidget('Email', provider.user.email),
                        ItemWidget('First Name', provider.user.fName),
                        ItemWidget('Last Name', provider.user.lName),
                        ItemWidget('Country Name', provider.user.country),
                        ItemWidget('City Name', provider.user.city),
                      ]);
          },
        ));
  }
}

class ItemWidget extends StatelessWidget {
  String label;
  String value;

  ItemWidget(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(



      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Text(value, style: TextStyle(fontSize: 18)),
        ],
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(

       borderRadius: BorderRadius.circular(15),
        color: Color(0xFFFFC539).withOpacity(0.1),
      ),
    );
  }
}
