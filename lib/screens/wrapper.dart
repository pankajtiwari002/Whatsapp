import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp/screens/authenticate/register.dart';
import 'package:whatsapp/screens/homepage.dart';
import 'package:whatsapp/screens/authenticate/login_page.dart';
import '../screens/model/users.dart';

class Wrapper extends StatefulWidget {
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool showSignIn = true;

  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);
    if(user==null){
      if(showSignIn){
        return LoginPage(toggleView);
      }
      else{
        return Register(toggleView);
      }
    }
    else{
      return HomePage();
    }
  }
}