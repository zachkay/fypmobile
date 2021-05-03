import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/CalculationDetail.dart';
import './screen3.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:http/http.dart' as http;

class CalcForm2 extends StatefulWidget {
  final CalculationDetail calculationDetail;
  CalcForm2(this.calculationDetail);

  @override
  _CalcForm2State createState() => _CalcForm2State();
}

class _CalcForm2State extends State<CalcForm2> {
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  Map<String, bool> touched = {
    "locAField": false,
  };

  final TextEditingController tfCPhase = TextEditingController();
  final TextEditingController tfAllowedVD = TextEditingController();
  final TextEditingController tfDist = TextEditingController();
  final TextEditingController tfCurrentLoad = TextEditingController();

  String selectedBreaker = "";
  // List data = List();
  Map<String, dynamic> data = new Map<String, dynamic>();
  List breakerData = [];
  List cphaseData = [];
  List ctypeData = [];
  List cizData = [];
  List cvdData = [];
  List cpriceData = [];

  Future getAllData() async {
    var response = await http.get("http://10.0.2.2/budee/call_data.php",
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    setState(() {
      data = jsonData;
      breakerData = data["breaker"];
      cphaseData = data["cphase"];
      ctypeData = data["ctype"];
      cizData = data["ciz"];
      cvdData = data["cvd"];
      cpriceData = data["cprice"];
    });

    print(jsonData);
  }
  // double estDist = dist * 0.15;
  // double dist = double.parse(tfDist.text);

  @override
  void initState() {
    super.initState();
    print(widget.calculationDetail.locA);
    getAllData();
  }

  toScreen3() {
    widget.calculationDetail.cPhase = '';
    widget.calculationDetail.allowedVD = double.parse('3');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Screen3(widget.calculationDetail),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //getAllBreaker();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Screen2'),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: <Widget>[
                  Container(
                    child: Text(
                      'CABLE TYPE SELECTION',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DropdownButtonFormField(
                    //onSaved: (val) => _cardDetails.expiryMonth = val,
                    //value: selectedBreaker,
                    decoration: InputDecoration(
                      labelText: 'Cable Phase',
                      // icon: Icon(Icons.calendar_today),
                    ),
                    items: cphaseData.map(
                      (list) {
                        return DropdownMenuItem(
                          child: Text(list['phase']),
                          value: list['phase'],
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(() {
                        //selectedBreaker = val;
                      });
                    },
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                      child: Text(
                        'VOLTAGE DROP PERCENTAGE',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Notes: Maximum voltage drop allowed based on IEEE is 8% and JKR is 4%',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Voltage Drop Allowed',
                      // icon: Icon(Icons.location_on),
                    ),
                    controller: tfLocA,
                    // onSaved: (val) => _cardDetails.cardHolderName = val,
                    onChanged: (value) {
                      setState(() {
                        touched['locAField'] = true;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty)
                        return "This form value must be filled";
                      return null;
                    },
                    autovalidate: touched['locAField'],
                  ),
                  DropdownButtonFormField(
                    //onSaved: (val) => _cardDetails.expiryMonth = val,
                    //value: selectedBreaker,
                    decoration: InputDecoration(
                      labelText: 'Installation Type',
                      // icon: Icon(Icons.calendar_today),
                    ),
                    items: <String>['INDOOR', 'OUTDOOR']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        child: Text(value),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        //selectedBreaker = val;
                      });
                    },
                  ),
                  DropdownButtonFormField(
                    //onSaved: (val) => _cardDetails.expiryMonth = val,
                    //value: selectedBreaker,
                    decoration: InputDecoration(
                      labelText: 'Cable Type',
                      // icon: Icon(Icons.calendar_today),
                    ),
                    items: cphaseData.map(
                      (list) {
                        return DropdownMenuItem(
                          child: Text(list['phase']),
                          value: list['phase'],
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(() {
                        //selectedBreaker = val;
                      });
                    },
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RaisedButton(
                            child: Text('Reset'),
                            color: Colors.amber,
                            textColor: Colors.black,
                            onPressed: () {
                              _formKey.currentState.reset();
                              tfLocA.clear();
                              tfLocB.clear();
                              tfDist.clear();
                              tfCurrentLoad.clear();
                            },
                          ),
                          RaisedButton(
                            child: loading
                                ? SpinKitWave(
                                    color: Colors.white,
                                    size: 15.0,
                                  )
                                : Text('Next'),
                            color: Colors.amber,
                            textColor: Colors.black,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                _formKey.currentState.save();
                                Timer(Duration(seconds: 1), () {
                                  setState(() {
                                    loading = false;
                                  });
                                  final snackBar =
                                      SnackBar(content: Text('Calculating...'));
                                  Scaffold.of(context).showSnackBar(snackBar);
                                  print('Saved');
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ), // we will work in here
            ],
          ),
        ),
      ),
    );
  }
}
