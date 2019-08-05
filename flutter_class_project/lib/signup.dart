import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';

class SignUpClass extends StatefulWidget {
  SignUpClass({Key key}) : super(key: key);

  _SignUpClassState createState() => _SignUpClassState();
}

class _SignUpClassState extends State<SignUpClass> {
  final signupkey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final cnic = TextEditingController();
  final ntn = TextEditingController();
  final contact = TextEditingController();
  final confirmpassword = TextEditingController();
  String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            // Main Container
            SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
       // height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:
// Main Column
            Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(),
              height: MediaQuery.of(context).size.height * .1,
              width: MediaQuery.of(context).size.width * .5,
              child: Image.asset(
                'datafolder/logo.png',
              ),
            ),

// Fields Container
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),

              // Card Column
              child: Form(
                key: signupkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Register',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
// Name Field

                    Container(
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Name',
                            hintText: 'Enter Name Here'),

                        controller: name,
                      ),
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    // Email Field
                    Container(
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Email',
                            hintText: 'Enter Email Here'),
                        validator: validateEmail,
                        onSaved: (value) => _email = value,
                        controller: email,
                      ),
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    // CNIC Field
                    Container(
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'CNIC',
                            hintText: 'Enter CNIC Here'),

                        controller: cnic,
                      ),
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    // NTN Field
                    Container(
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'NTN',
                            hintText: 'Enter NTN Here'),


                        controller: ntn,
                      ),
                    ),

                    SizedBox(
                      height: 15,
                    ),








// Contact Field
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelText: 'Contact',
                                  hintText: 'Enter Contact Here'),
                              controller: contact,
                            ),
                          ),

                          SizedBox(
                            height: 15,
                          ),
// Password Field
                          Container(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelText: 'Password',
                                  hintText: 'Enter Password Here'),
                              validator: (value) {
                                if (value.length < 8) {
                                  return 'Password must be 8 charactors';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) => _password = value,
                              obscureText: true,
                              controller: password,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),


                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Container(
                      alignment: Alignment.bottomRight,
                      child: RaisedButton(
                        onPressed: signUpWithEmailandPassword,
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),

                    Container(
                      child: Column(
                        children: <Widget>[
// Social Media Button Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                onTap: () {},
                                child: Image.asset(
                                  'datafolder/facebook.png',
                                  height: 60,
                                  width: 60,
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Image.asset(
                                  'datafolder/google.png',
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "By Signing up, You agree to ",
                                style: TextStyle(fontSize: 13),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  'Terms',
                                  style: TextStyle(
                                      color: Color(0xff8BD5E1), fontSize: 18),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  Future<void> signUpWithEmailandPassword() async {
    final formState = signupkey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        AuthResult user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);

        if (user != null) {
          Firestore.instance.collection('user').document(user.user.uid).setData(
              {
                'Name': name.text,
                'Email': email.text,
                'Cnic': cnic.text,
                'Ntn': ntn.text,
                'Number': contact.text,
              });


          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LogInClass()));
        }} catch (e) {
        print(e.massege);
      }
    }
  }
}
