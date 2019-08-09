import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_class_project/modelclasses/usermodel.dart';
import 'auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'modelclasses/usermodel.dart';



class HomePageClass extends StatefulWidget {
  final BaseAuth logout ;
  HomePageClass ({@required this.logout});



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

      body: Container(child: Column(
        children: <Widget>[
          StreamBuilder(
              stream: getData(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                } else {
                  return Column(
                    children: <Widget>[
                      Text('${snapshot.data['Name']}'),
                      Text('${snapshot.data['Email']}'),
                      Text('${snapshot.data['Cnic']}'),
                      Text('${snapshot.data['Ntn']}'),
                      Text('${snapshot.data['Number']}'),
                    ],
                  );
                }
              })
        ],
      )),

      );




  }



  Stream getData(user) {
    Stream stream1 = Firestore.instance
        .collection('user')
        .document(User.userData.userId)
        .snapshots();
    return stream1;
  }

}
