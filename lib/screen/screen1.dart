import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../models/CalculationDetail.dart';
import 'screen2.dart';

import 'package:http/http.dart' as http;

class CalcForm1 extends StatefulWidget {
  @override
  _CalcForm1State createState() => _CalcForm1State();
}

class _CalcForm1State extends State<CalcForm1> {
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  Map<String, bool> touched = {
    "locAField": false,
  };

  final TextEditingController tfLocA = TextEditingController();
  final TextEditingController tfLocB = TextEditingController();
  final TextEditingController tfDist = TextEditingController();
  final TextEditingController tfCurrentLoad = TextEditingController();
  final TextEditingController tfBreakerSize = TextEditingController();

  double dist = 0.0;
  double estDist = 0.0;
  String selectedBreakerSize;

  calcDist(val) {
    setState(() {
      dist = double.parse(tfDist.text);
      estDist = dist * 1.15;
    });
  }

  Map<String, dynamic> data = new Map<String, dynamic>();
  List breakerData = [];
  List filteredBData = [];

  Future getAllBreaker() async {
    var response = await http.get("http://10.0.2.2/budee/call_data.php",
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    setState(() {
      data = jsonData;
      filteredBData = breakerData = data["breaker"];
    });
    print(jsonData);
  }

  filterCLoad(val) {
    setState(() {
      filteredBData = breakerData
          .where((breaker) => int.parse(breaker['size']) > int.parse(val))
          .toList();
    });
  }

  _nextScreen(context) {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      _formKey.currentState.save();
      Timer(Duration(seconds: 1), () {
        setState(() {
          loading = false;
        });
        CalculationDetail calculationDetail = new CalculationDetail(
          locA: tfLocA.text,
          locB: tfLocB.text,
          dist: estDist,
          cLoad: double.parse(tfCurrentLoad.text),
          bSize: int.parse(selectedBreakerSize),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CalcForm2(calculationDetail),
          ),
        );
      });
    }
  }

  // double estDist = dist * 1.15;
  // double dist = double.parse(tfDist.text);

  @override
  void initState() {
    super.initState();
    getAllBreaker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Screen1'),
        // actions: <Widget>[
        //   IconButton(
        //     onPressed: () {
        //       // signOut();
        //     },
        //     icon: Icon(Icons.exit_to_app),
        //   )
        // ],
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
                      'DISTANCE SETTING (LENGTH)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'From',
                      icon: Icon(Icons.location_on),
                    ),
                    controller: tfLocA,
                    // onSaved: (val) => _cardDetails.cardHolderName = val,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        touched['locAField'] = true;
                        print(tfLocA.text);
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty)
                        return "This form value must be filled";
                      return null;
                    },
                    autovalidate: touched['locAField'],
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'To',
                      icon: Icon(Icons.location_city),
                    ),
                    controller: tfLocB,
                    // onSaved: (val) => _cardDetails.cardNumber = val,
                    validator: (value) {
                      if (value.isEmpty)
                        return "This form value must be filled";
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Distance (meter)',
                      icon: Icon(Icons.gps_fixed),
                    ),
                    controller: tfDist,
                    // onSaved: (val) => _cardDetails.securityCode = int.parse(val),
                    onChanged: calcDist,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty)
                        return "This form value must be filled";
                      return null;
                    },
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                      child: Text(
                          'Footnote: 15% will be added to the original distance as it is subjected to the Technique Reference'),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                      child: Text(
                          'Estimated Distance: ' +
                              estDist.toStringAsFixed(1) +
                              'm',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const Divider(
                    height: 20,
                    thickness: 5,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      child: Text(
                        'CURRENT FOR MD',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                      child: Text('Note: In > Imd'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Current Load (Ib)',
                      // icon: Icon(Icons.location_city),
                    ),
                    controller: tfCurrentLoad,
                    // onSaved: (val) => _cardDetails.cardNumber = val,
                    onChanged: filterCLoad,
                    validator: (value) {
                      if (value.isEmpty)
                        return "This form value must be filled";
                      return null;
                    },
                    keyboardType: TextInputType.number,
                  ),
                  DropdownButtonFormField(
                    //onSaved: (val) => _cardDetails.expiryMonth = val,
                    //value: selectedBreaker,
                    decoration: InputDecoration(
                      labelText: 'Breaker Size(In)',
                      // icon: Icon(Icons.calendar_today),
                    ),
                    items: filteredBData.map(
                      (bDataList) {
                        return DropdownMenuItem(
                          child: Text(bDataList['size']),
                          value: bDataList['size'],
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedBreakerSize = val;
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
                              _nextScreen(context);
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
