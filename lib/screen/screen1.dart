import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../models/calcDetail.dart';
import 'screen2.dart';

import 'package:http/http.dart' as http;

class CalcForm1 extends StatefulWidget {
  @override
  _CalcForm1State createState() => _CalcForm1State();
}

class _CalcForm1State extends State<CalcForm1> {
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  // Map<String, bool> touched = {
  //   "locAField": false,
  // };

  final TextEditingController tfLocA = TextEditingController();
  final TextEditingController tfLocB = TextEditingController();
  final TextEditingController tfDist = TextEditingController();
  final TextEditingController tfCurrentLoad = TextEditingController();
  final TextEditingController tfBreakerSize = TextEditingController();

  double dist = 0.0;
  double estDist = 0.0;
  String selectedBreakerSize;
  String selectedCLoad;

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
    // print(jsonData);
  }

  filterBSize(val) {
    setState(() {
      selectedBreakerSize = null;
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
        calcDetail calculationDetail = new calcDetail(
          locA: tfLocA.text,
          locB: tfLocB.text,
          dist: dist,
          estDist: estDist,
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
                    // onChanged: (value) {
                    //   setState(() {
                    //     touched['locAField'] = true;
                    //   });
                    // },
                    validator: (value) {
                      if (value.isEmpty)
                        return "This form value must be filled";
                      return null;
                    },
                    // autovalidate: touched['locAField'],
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
                    // onChanged: filterBSize,
                    onChanged: (val) {
                      setState(() {
                        filterBSize(val);
                        selectedCLoad = val;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty)
                        return "This form value must be filled";
                      return null;
                    },
                    keyboardType: TextInputType.number,
                  ),
                  DropdownButtonFormField(
                    //onSaved: (val) => _cardDetails.expiryMonth = val,
                    value: selectedBreakerSize,
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
                    validator: (val) =>
                        val == null ? 'Please select breaker size' : null,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        child: Text('RESET'),
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(
                              fontSize: 15.0,
                              // fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold),
                          primary: Colors.amberAccent,
                          onPrimary: Colors.black,
                          elevation: 5,
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          shape: StadiumBorder(),
                        ),
                        onPressed: () {
                          _formKey.currentState.reset();
                          tfLocA.clear();
                          tfLocB.clear();
                          tfDist.clear();
                          tfCurrentLoad.clear();
                          setState(() {
                            selectedCLoad = null;
                            selectedBreakerSize = null;
                          });
                        },
                      ),
                      ElevatedButton(
                        child: loading
                            ? SpinKitWave(                            
                                color: Colors.black,
                                size: 20.0,
                              )
                            : Text('NEXT'),
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(
                              fontSize: 15.0,
                              // fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold),
                          primary: Colors.amberAccent,
                          onPrimary: Colors.black,
                          elevation: 5,
                          padding: EdgeInsets.symmetric(
                              horizontal: 55, vertical: 10),
                          shape: StadiumBorder(),
                        ),
                        onPressed: () {
                          _nextScreen(context);
                        },
                      ),
                    ],
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
