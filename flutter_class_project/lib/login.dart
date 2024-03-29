
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth.dart';


class LogInClass extends StatefulWidget {
  final BaseAuth authentication ;
  LogInClass ({@required this.authentication});

  _LogInClassState createState() => _LogInClassState();
}

class _LogInClassState extends State<LogInClass> {
  final loginkey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  String _email, _password;
  int counter = 0;
  bool logedin = false;






  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            // Main Container
            SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:
// Main Column
            Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * .2,
              width: MediaQuery.of(context).size.width * .5,
              child: Image.asset('datafolder/logo.png'),
            ),

// Fields Container

            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.only(left: 20, right: 20, top: 5,),
             
             // height: MediaQuery.of(context).size.height * .7,
              // Card Column
              child: Form(
                key: loginkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    // Sign navigation row
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(fontSize: 18),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpClass(signupauthentication: Auth(),)),
                            );
                          },
                          child: Text(
                            'Join us',
                            style: TextStyle(
                                color: Color(0xff8BD5E1), fontSize: 22),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),

// Email Field
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelText: 'Email',
                                  hintText: 'Enter Email Here'),
                              validator: validateEmail,
                              controller: email,
                              onSaved: (value)=> _email=value ,
                            ),
                          ),

                          SizedBox(
                            height: 20,
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
                              controller: password,
                              onSaved: (value)=>_password=value, obscureText: true,
                            ),
                          ),
                        ],
                      ),
                    ),
SizedBox(height: 20,),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: RaisedButton(
                        onPressed:SignInWithEmailAndPassword,


                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          'Log in',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
SizedBox(height: 20,),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Lost Your Password?',
                            style: TextStyle(
                                color: Color(0xff8BD5E1), fontSize: 22),
                          ),
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
                                onTap: () async {
                                  String user = await widget.authentication.signInWithGoogle();
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
       HomePageClass(logout: Auth(),)));
                                },
                                child: Image.asset(
                                  'datafolder/google.png',
                                  height: 40,
                                  width: 40,
                                ),
                              ),
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


  Future<void> SignInWithEmailAndPassword() async{
    final formState = loginkey.currentState;
    if (formState.validate()){
      formState.save();
      try {
        AuthResult user = await  FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePageClass(logout: Auth(),)));
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setBool("logedIn", true);
        return user;

      } catch (e) {
        print(e.massege);
      }
    }
  }


}
