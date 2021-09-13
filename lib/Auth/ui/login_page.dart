import 'package:chat_firebase/Auth/providers/auth_provider.dart';
import 'package:chat_firebase/Auth/ui/widgets/custom_textField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_firebase/widgets/custom_button.dart';
import 'package:chat_firebase/services/routs_helper.dart';
import 'package:chat_firebase/Auth/ui/reset_password_page.dart';


class LoginPage extends StatelessWidget {
  //const RegisterPage({Key? key}) : super(key: key);
  static final routName='LoginPage';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFEDF2F7),

     body: SingleChildScrollView(
       child: Consumer<AuthProvider>(
         builder: (context,provider,x){
           return  Column(
             children: [

               CustomTextField("Email", provider.emailController),
               CustomTextField("Password", provider.passwordController,isObscure: true),
               CustomButton(provider.login,"Login"),
               SizedBox(height: 20,),

               Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text("Forget Password ?",

                   ),

                   GestureDetector(
                     onTap: (){
                       RoutHelpers.routHelpers.goToPage(ResetPassword.routName);
                     },



                     child: Container(
                       margin: EdgeInsets.symmetric(horizontal: 10),
                       alignment: Alignment.center,
                       child: Text(
                         " Click here",
                         textAlign: TextAlign.center,
                         style: TextStyle(color: Colors.blue,

                             decoration: TextDecoration.underline
                         ),
                       ),
                     ),
                   ),
                 ],
               )



             ],
           );
         }
       ),
     ),
    );
  }
}
