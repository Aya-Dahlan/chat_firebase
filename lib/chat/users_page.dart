

import 'package:chat_firebase/Auth/providers/auth_provider.dart';
import 'package:chat_firebase/chat/chat_page.dart';
import 'package:chat_firebase/services/routs_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_firebase/Auth/helpers/firestore_helper.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatelessWidget {
  // const HomePage({Key? key}) : super(key: key);
  static final routName="Users";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDF2F7),
      appBar:AppBar(
        backgroundColor: Color(0xFFFFC539),
        title:Text("All Users"),
        actions: [
          IconButton(icon: Icon(Icons.chat), onPressed: (){
            RoutHelpers.routHelpers.goToPage(ChatPage.routName);
          })
        ],
      ),
      body: Center(
        child: Consumer<AuthProvider>(
          builder: (context,provider, x){
            if(provider.users==null){
              return Center(child: CircularProgressIndicator(),);
            }
            else{
              return ListView.builder(
                  itemCount:provider.users.length,
                  itemBuilder: (context,index){
                    return Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(15),



                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFFFFC539).withOpacity(0.1),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          CircleAvatar(

                            radius:40,
                            backgroundImage: NetworkImage(provider.users[index].imageUrl),

                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(provider.users[index].fName+" "+provider.users[index].lName),
                              Text(provider.users[index].email),
                              Text(provider.users[index].country+" - "+provider.users[index].city),
                            ],
                          )
                        ],
                      ),
                    );
                  });
            }
          },
          
        )
      ),

    );
  }
}
