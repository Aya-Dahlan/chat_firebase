import 'package:flutter/material.dart';
import 'package:chat_firebase/services/routs_helper.dart';


class CustomDialog {
  CustomDialog._();
   static CustomDialog customDialog=CustomDialog._();

  showCustomDialog(String massage,[Function function]) {
    showDialog(context: RoutHelpers.routHelpers.navKey.currentContext,
        builder: (context) {
          return AlertDialog(
            content: Text(massage),
            actions: [
              TextButton(

                onPressed: () {
                  if(function==null){
                    RoutHelpers.routHelpers.back();
                  }else{
                    function();
                    RoutHelpers.routHelpers.back();

                  }

                },
                child: Text('Ok'),
              ),
            ],
          );
        });
  }
}








