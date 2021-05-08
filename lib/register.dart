import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String name, email, mobile, password;
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
      save();
    }
  }

  save() async {
    final response = await http
        .post("http://10.0.2.2/budee/api_verification.php", body: {
      "flag": 2.toString(),
      "name": name,
      "email": email,
      "mobile": mobile,
      "password": password,
      "fcm_token": "test_fcm_token"
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
      });
      print(message);
      registerToast(message);
    } else if (value == 2) {
      print(message);
      registerToast(message);
    } else {
      print(message);
      registerToast(message);
    }
  }

  registerToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
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
                      Image.asset('asset/img/BuDEE.png', width: 300, height: 300,),
                      SizedBox(
                        height: 30,
                      ),
                      // SizedBox(
                      //   height: 50,
                      //   child: Text(
                      //     "Register",
                      //     style: TextStyle(color: Colors.black, fontSize: 30.0),
                      //   ),
                      // ),

                      //card for Fullname TextFormField
                      Card(
                        elevation: 6.0,
                        child: TextFormField(
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Please insert Full Name";
                            }
                          },
                          onSaved: (e) => name = e,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 20, right: 15),
                                child: Icon(Icons.person, color: Colors.black),
                              ),
                              contentPadding: EdgeInsets.all(18),
                              labelText: "Fullname"),
                        ),
                      ),

                      //card for Email TextFormField
                      Card(
                        elevation: 6.0,
                        child: TextFormField(
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Please insert Email";
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
                                padding: EdgeInsets.only(left: 20, right: 15),
                                child: Icon(Icons.email, color: Colors.black),
                              ),
                              contentPadding: EdgeInsets.all(18),
                              labelText: "Email"),
                        ),
                      ),

                      //card for Mobile TextFormField
                      Card(
                        elevation: 6.0,
                        child: TextFormField(
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Please insert Mobile Number";
                            }
                          },
                          onSaved: (e) => mobile = e,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 20, right: 15),
                              child: Icon(Icons.phone, color: Colors.black),
                            ),
                            contentPadding: EdgeInsets.all(18),
                            labelText: "Mobile",
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),

                      //card for Password TextFormField
                      Card(
                        elevation: 6.0,
                        child: TextFormField(
                          obscureText: _secureText,
                          onSaved: (e) => password = e,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: showHide,
                                icon: Icon(_secureText
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 20, right: 15),
                                child: Icon(Icons.phonelink_lock,
                                    color: Colors.black),
                              ),
                              contentPadding: EdgeInsets.all(18),
                              labelText: "Password"),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(12.0),
                      ),

                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[

                          SizedBox(
                            height: 44.0,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Text(
                                  "Login Page",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                textColor: Colors.black,
                                color: Color(0xFFf7d426),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 44.0,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Text(
                                  "Register",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                textColor: Colors.black,
                                color: Color(0xFFf7d426),
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
  }
}
