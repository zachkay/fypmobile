import 'package:flutter/material.dart';

class About extends StatefulWidget {
  About({Key key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('About Application'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0,20.0,30.0,0.0),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'asset/img/BuDEE.png',
                width: 250,
                height: 250,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'VERSION: 1.0',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'COPYRIGHT @ 2020 | UNIKL-JKR COLLABORATION PROJECT',textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 19,
              ),
              Text(
                "BuDEE application is for the purpose to calculate the cable voltage drop & overall cost estimation."
                "\n\nVoltage drop is very important to make sure the operation running smoothly for an electric circuit."
                "\n\nVoltage drop calculation is a way of electrical diagnosis that can find a high load problem.",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
