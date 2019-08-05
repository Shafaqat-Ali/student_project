import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'drawerpage.dart';


class HomePageClass extends StatefulWidget {
  final String currentuser;
  HomePageClass({@required this.currentuser});
  @override
  _HomePageClassState createState() => _HomePageClassState();
}

class _HomePageClassState extends State<HomePageClass> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page'),),
     drawer: DrawerPageClass(),

    );
  }
}
