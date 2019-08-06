import 'package:flutter/material.dart';
import 'dart:async';
import 'auth.dart';
import 'login.dart';
//import 'sign_up.dart';







class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = Duration(seconds: 5);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LogInClass(authentication: Auth(),)));
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



