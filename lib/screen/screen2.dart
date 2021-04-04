import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_login/models/input.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CalcScreen2 extends StatelessWidget {
  const CalcScreen2({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('CalcForms'),
      ),
      body: CalcForm2(), // We'll add this in a bit
    );
  }
}

class CalcForm2 extends StatefulWidget {
  CalcForm2({Key key}) : super(key: key);
  @override
  _CalcForm2State createState() => _CalcForm2State();
}

class _CalcForm2State extends State<CalcForm2> {
  final _formKey = GlobalKey<FormState>();

  CardDetails _cardDetails = new CardDetails();
  String expiryMonth;
  String expiryYear;
  Address _paymentAddress = new Address();

  bool loading = false;

  final List yearsList = List.generate(12, (int index) => index + 2020);
  Map<String, bool> touched = {
    "locAField": false,
  };

  final TextEditingController tfLocA = TextEditingController();
  final TextEditingController tfLocB = TextEditingController();
  final TextEditingController tfDist = TextEditingController();
  final TextEditingController tfCurrentLoad = TextEditingController();

  
  // double estDist = dist * 0.15;
  // double dist = double.parse(tfDist.text);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                DropdownButtonFormField<String>(
                  onSaved: (val) => _cardDetails.expiryMonth = val,
                  value: expiryMonth,
                  items: [
                    'SINGLE PHASE',
                    'THREE PHASE'
                  ].map<DropdownMenuItem<String>>(
                    (String val) {
                      return DropdownMenuItem(
                        child: Text(val),
                        value: val,
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(() {
                      expiryMonth = val;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Voltage',
                    // icon: Icon(Icons.calendar_today),
                  ),
                ),
                Container(
                  child:
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0,20.0,0.0,20.0),
                        child: Text(
                          'VOLTAGE DROP PERCENTAGE',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),                  
                ),
                Container(
                  child:
                      Text(
                        'Notes: Maximum voltage drop allowed based on IEEE is 8% and JKR is 4%',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                  ),
                TextFormField(
                  controller: tfLocA,
                  onSaved: (val) => _cardDetails.cardHolderName = val,
                  onChanged: (value) {
                    setState(() {
                      touched['locAField'] = true;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Voltage Drop Allowed',
                    // icon: Icon(Icons.location_on),
                  ),
                  validator: (value) {
                    if (value.isEmpty) return "This form value must be filled";
                    return null;
                  },
                  autovalidate: touched['locAField'],
                ),
                DropdownButtonFormField<String>(
                  onSaved: (val) => _cardDetails.expiryMonth = val,
                  value: expiryMonth,
                  items: [
                    'INDOOR',
                    'OUTDOOR'
                  ].map<DropdownMenuItem<String>>(
                    (String val) {
                      return DropdownMenuItem(
                        child: Text(val),
                        value: val,
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(() {
                      expiryMonth = val;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Installation Type',
                    // icon: Icon(Icons.calendar_today),
                  ),
                ),
                DropdownButtonFormField<String>(
                  onSaved: (val) => _cardDetails.expiryMonth = val,
                  value: expiryMonth,
                  items: [
                    'PVC(Indoor)',
                    'XLPE(Indoor)',
                    'XLPE/SWA/PVC(Outdoor)',
                    'PVC/SWA/PVC(Outdoor)'
                  ].map<DropdownMenuItem<String>>(
                    (String val) {
                      return DropdownMenuItem(
                        child: Text(val),
                        value: val,
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(() {
                      expiryMonth = val;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Cable Type',
                    // icon: Icon(Icons.calendar_today),
                  ),
                ),
                DropdownButtonFormField<String>(
                  onSaved: (val) => _cardDetails.expiryMonth = val,
                  value: expiryMonth,
                  items: [
                    '1',
                    '2',
                    '3',
                    '4'
                  ].map<DropdownMenuItem<String>>(
                    (String val) {
                      return DropdownMenuItem(
                        child: Text(val),
                        value: val,
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(() {
                      expiryMonth = val;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Cable Quantity',
                    // icon: Icon(Icons.calendar_today),
                  ),
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
                                Payment payment = new Payment(
                                    address: _paymentAddress,
                                    cardDetails: _cardDetails);
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
    );
  }
}
