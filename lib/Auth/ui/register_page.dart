import 'package:chat_firebase/Auth/models/country_model.dart';
import 'package:chat_firebase/Auth/providers/auth_provider.dart';
import 'package:chat_firebase/Auth/ui/widgets/custom_textField.dart';
import 'package:chat_firebase/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  //const RegisterPage({Key? key}) : super(key: key);
  static final routName = 'RegisterPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFEDF2F7),
        body: Consumer<AuthProvider>(builder: (context, provider, x) {
          return SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap:(){
                    provider.selectFile();
                  },
                  child: Container(

                    height: 150,

                    decoration: BoxDecoration(
                      shape: BoxShape.circle ,
                      color:Colors.grey,
                    ),

                    child:provider.file==null? Container():Image.file(provider.file,fit: BoxFit.cover),



                  ),
                ),
                CustomTextField('FirstName', provider.firstNameController),
                CustomTextField('LastName', provider.lastNameController),
                CustomTextField('Email', provider.emailController),
                CustomTextField('Password', provider.passwordController),
                provider.countries == null
                    ? Container()
                    : Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        child: DropdownButton<CountryModel>(
                          isExpanded: true,
                          underline: Container(),
                          value: provider.selectedCountry,
                          onChanged: (x) {
                            provider.selectCountry(x);
                          },
                          items: provider.countries.map((e) {
                            return DropdownMenuItem<CountryModel>(
                              child: Text(e.name),
                              value: e,
                            );
                          }).toList(),
                        ),
                      ),
                provider.countries == null
                    ? Container()
                    : Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        child: DropdownButton<dynamic>(
                          isExpanded: true,
                          underline: Container(),
                          value: provider.selectedCity,
                          onChanged: (x) {
                            provider.selectCity(x);
                          },
                          items: provider.city.map((e) {
                            return DropdownMenuItem<dynamic>(
                              child: Text(e),
                              value: e,
                            );
                          }).toList(),
                        ),
                      ),
                CustomButton(provider.register, 'Register'),
              ],
            ),
          );
        }));
  }
}
