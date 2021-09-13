import 'package:chat_firebase/Auth/providers/auth_provider.dart';
import 'package:chat_firebase/Auth/ui/widgets/custom_textField.dart';
import 'package:chat_firebase/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatelessWidget {
  static final routName='ResetPasswordPage';

  //const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDF2F7),
      appBar: AppBar(
        backgroundColor:  Color(0xFFFFC539),
        title: Text("Reset Password"),
      ),
      body: Consumer<AuthProvider>(builder: (context, provider, x) {
        return Column(
          children: [
            CustomTextField("Email", provider.emailController),
            CustomButton(provider.resetPassword, "Reset Password"),
          ],
        );
      },
      ),
    );
  }
}
