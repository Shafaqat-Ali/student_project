import 'package:flutter/material.dart';
import 'dart:async';
import 'auth.dart';
import 'login.dart';
import 'home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';








class SplashScreen extends StatefulWidget {
  final BaseAuth authcheck ;
  SplashScreen ({@required this.authcheck});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = Duration(seconds: 5);
    return Timer(_duration, navigationPage);
  }

  Future navigationPage() async {
SharedPreferences pref = await SharedPreferences.getInstance();
final loged = pref.getBool('logedIn') ;


    if(loged == true){

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePageClass(logout: Auth(),)));
    }else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>LogInClass(authentication: Auth(),) ));

    }


  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Image.asset('datafolder/logo.png', scale: 3, ),
      ),
    );
  }
}



