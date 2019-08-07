import 'package:flutter/material.dart';
import 'auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';


class HomePageClass extends StatefulWidget {
  final BaseAuth logout ;
  HomePageClass ({@required this.logout});

  /*final String currentuser;
  HomePageClass({@required this.currentuser});*/

  @override
  _HomePageClassState createState() => _HomePageClassState();
}

class _HomePageClassState extends State<HomePageClass> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page'), centerTitle: true,),
drawer: Drawer(
  child: ListView(
    children: <Widget>[

      DrawerHeader(child: ListView(children: <Widget>[
        CircleAvatar(child: Icon(Icons.person),),
      ],),),

FlatButton(onPressed: () async {
  String user = await widget.logout.signOut().toString();
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setBool("logedIn", false);
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>LogInClass(authentication: Auth(),) ));

}, child: Text('Log Out'))
    ],
  ),
),

    );
  }
}
