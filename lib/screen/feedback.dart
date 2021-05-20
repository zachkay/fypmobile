import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<FeedbackForm> {
  final _key = new GlobalKey<FormState>();

  final TextEditingController tfSubject = TextEditingController();
  final TextEditingController tfFeedback = TextEditingController();

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      save();
    }
  }

  feedbackToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white);
  }

  save() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response =
        await http.post("http://10.0.2.2/budee/save_feedback.php", headers: {
      "Accept": "application/json"
    }, body: {
      "name": preferences.getString("name"),
      "email": preferences.getString("email"),
      "subject": tfSubject.text,
      "feedback": tfFeedback.text,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
      });
      feedbackToast(message);
    } else {
      feedbackToast(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Feedback Form'),
      ),
      backgroundColor: Color.fromRGBO(217, 217, 217, 1),
      body: Form(
        key: _key,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              Card(
                elevation: 6.0,
                child: TextFormField(
                  controller: tfSubject,
                  // validator: (e) {
                  //   if (e.isEmpty) {
                  //     return "Please insert Subject";
                  //   }
                  // },
                  // onSaved: (e) => subject = e,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                      // prefixIcon: Padding(
                      //   padding: EdgeInsets.only(left: 20, right: 15),
                      //   child: Icon(Icons.person, color: Colors.black),
                      // ),
                      contentPadding: EdgeInsets.all(18),
                      labelText: "Subject"),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              //card for Email TextFormField
              Card(
                elevation: 6.0,
                child: TextFormField(
                  controller: tfFeedback,
                  maxLines: 10,
                  // validator: (e) {
                  //   if (e.isEmpty) {
                  //     return "Please insert Feedback";
                  //   }
                  // },
                  // onSaved: (e) => feedback = e,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                      hintText: "Enter your feedback...",
                      // prefixIcon: Padding(
                      //   padding: EdgeInsets.only(left: 20, right: 15),
                      //   child: Icon(Icons.email_rounded,
                      //       color: Colors.black),
                      // ),
                      contentPadding: EdgeInsets.all(18)),
                  keyboardType: TextInputType.multiline,
                ),
              ),

              // Padding(
              //   padding: EdgeInsets.all(12.0),
              // ),

              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  child: Text("SUBMIT"),
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(
                        fontSize: 15.0,
                        // fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold),
                    primary: Colors.amberAccent,
                    onPrimary: Colors.black,
                    elevation: 5,
                    shape: StadiumBorder(),
                  ),
                  onPressed: () {
                    save();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
