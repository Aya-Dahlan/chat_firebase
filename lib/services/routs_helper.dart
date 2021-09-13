
import 'package:flutter/cupertino.dart';

class RoutHelpers{
  RoutHelpers._();
 static RoutHelpers routHelpers=RoutHelpers._();
  GlobalKey<NavigatorState> navKey=GlobalKey<NavigatorState> ();

  goToPage(String pageName){
    navKey.currentState.pushNamed(pageName);
  }

  goToPageReplacement(String pageName){
    navKey.currentState.pushReplacementNamed(pageName);
  }

  back(){
    navKey.currentState.pop();
  }
}