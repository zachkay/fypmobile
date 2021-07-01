import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'register.dart';
import 'homescreen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginState extends State<Login> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String email, password;
  final _key = new GlobalKey<FormState>();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      login();
    }
  }

  login() async {
    // localhost = 10.0.2.2
    final response =
        await http.post("http://10.0.2.2/budee/api_verification.php", body: {
      "flag": 1.toString(),
      "email": email,
      "password": password,
      "fcm_token": "test_fcm_token"
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    String emailAPI = data['email'];
    String nameAPI = data['name'];
    String id = data['id'];

    if (value == 1) {
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value, emailAPI, nameAPI, id);
      });
      print(message);
      loginToast(message);
    } else {
      print(message);
      loginToast(message);
    }
  }

  loginToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white);
  }

  savePref(int value, String email, String name, String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("name", name);
      preferences.setString("email", email);
      preferences.setString("id", id);
      // ignore: deprecated_member_use
      preferences.commit();
    });
  }

  var value;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.setString("name", null);
      preferences.setString("email", null);
      preferences.setString("id", null);

      // ignore: deprecated_member_use
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          backgroundColor: Color.fromRGBO(217, 217, 217, 1),
          body: Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(15.0),
              children: <Widget>[
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _key,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'asset/img/BuDEE.png',
                            width: 300,
                            height: 300,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(0,20,0,0),
                          //   child: SizedBox(
                          //     height: 50,
                          //     child: Text(
                          //       "Login",
                          //       style: TextStyle(
                          //           color: Colors.black, fontSize: 30.0, fontFamily: 'OpenSans'),
                          //     ),
                          //   ),
                          // ),

                          //card for Email TextFormField
                          Card(
                            elevation: 6.0,
                            child: TextFormField(
                              validator: (e) {
                                if (e.isEmpty) {
                                  return "Please Insert Email";
                                }
                              },
                              onSaved: (e) => email = e,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 15),
                                    child: Icon(Icons.person_rounded,
                                        color: Colors.black),
                                  ),
                                  contentPadding: EdgeInsets.all(18),
                                  labelText: "Email / Mobile No."),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          // Card for password TextFormField
                          Card(
                            elevation: 6.0,
                            child: TextFormField(
                              validator: (e) {
                                if (e.isEmpty) {
                                  return "Password Can't be Empty";
                                }
                              },
                              obscureText: _secureText,
                              onSaved: (e) => password = e,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                labelText: "Password",
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 20, right: 15),
                                  child: Icon(Icons.lock_rounded,
                                      color: Colors.black),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: showHide,
                                  icon: Icon(_secureText
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                                contentPadding: EdgeInsets.all(18),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 50,
                          ),

                          // FlatButton(
                          //   onPressed: null,
                          //   child: Text(
                          //     "Forgot Password?",
                          //     style: TextStyle(
                          //         color: Colors.black,
                          //         fontWeight: FontWeight.bold),
                          //   ),
                          // ),

                          // Padding(
                          //   padding: EdgeInsets.all(14.0),
                          // ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    child: Text(
                                      "SIGN UP",
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      textStyle: TextStyle(
                                          fontSize: 15.0,
                                          // fontFamily: 'OpenSans',
                                          fontWeight: FontWeight.bold),
                                      primary: Colors.amberAccent,
                                      onPrimary: Colors.black,
                                      elevation: 5,
                                      shape: StadiumBorder(),
                                      // minimumSize: Size(160, 40),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Register()),
                                      );
                                    }),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                    child: Text(
                                      "LOGIN",
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      textStyle: TextStyle(
                                          fontSize: 15.0,
                                          // fontFamily: 'OpenSans',
                                          fontWeight: FontWeight.bold),
                                      primary: Colors.amberAccent,
                                      onPrimary: Colors.black,
                                      elevation: 5,
                                      shape: StadiumBorder(),
                                      // minimumSize: Size(160, 40),
                                    ),
                                    onPressed: () {
                                      check();
                                    }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        break;

      case LoginStatus.signIn:
        return MainMenu(signOut);
//        return ProfilePage(signOut);
        break;
    }
  }
}
