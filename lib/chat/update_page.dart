import 'package:chat_firebase/Auth/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdatePage extends StatefulWidget {
  // const HomePage({Key? key}) : super(key: key);
  static final routName = "UpdatePage";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<UpdatePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFEDF2F7),
        appBar: AppBar(



            backgroundColor: Color(0xFFFFC539),

          actions: [
            IconButton(icon: Icon(Icons.done), onPressed: () {

              Provider.of<AuthProvider>(context,listen:false).updateProfile();
            }),
          ],
          title: Text("Update Profile"),
        ),
        body: Consumer<AuthProvider>(
          builder: (context, provider, x) {
            return SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                       provider.captureUpdateProfileImage();
                      },
                      child:
                      provider.upatedProfile==null?
                      CircleAvatar(
                        radius: 80,
                        foregroundColor: Color(0xFFFFC539),
                        backgroundImage: NetworkImage(
                          provider.user.imageUrl,
                        ),
                      )
                     : CircleAvatar(
                        radius: 80,
                        foregroundColor: Color(0xFFFFC539),
                        backgroundImage: FileImage(
                          provider.upatedProfile,
                        ),
                      ),
                    ),

                    ItemWidget('First Name', provider.firstNameController),
                    ItemWidget('Last Name', provider.lastNameController),
                    ItemWidget('Country Name', provider.countryController),
                    ItemWidget('City Name', provider.cituController),
                  ]),
            );
          },
        ));
  }
}

class ItemWidget extends StatelessWidget {
  String label;
  TextEditingController valueController;

  ItemWidget(this.label, this.valueController);

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
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: TextField(
                controller: valueController, style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
