

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  //  const CustomButton({Key? key}) : super(key: key);
  Function function;
  String label;
  CustomButton(this.function,this.label);


  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: RaisedButton(
        color: Color(0xFFFFC539),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),

        ),
        onPressed: (){
         function();
        },
        child: Text(label),
      ),
    );
  }
}
