import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_login/models/input.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'screen2.dart';


class CalcScreen1 extends StatelessWidget {
  const CalcScreen1({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('CalcForms'),
      ),
      body: CalcForm1(), // We'll add this in a bit
    );
  }
}

class CalcForm1 extends StatefulWidget {
  CalcForm1({Key key}) : super(key: key);
  @override
  _CalcForm1State createState() => _CalcForm1State();
}

class _CalcForm1State extends State<CalcForm1> {
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
                    'DISTANCE SETTING (LENGTH)',
                    style: TextStyle(fontWeight: FontWeight.bold),
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
                    labelText: 'From',
                    icon: Icon(Icons.location_on),
                  ),
                  validator: (value) {
                    if (value.isEmpty) return "This form value must be filled";
                    return null;
                  },
                  autovalidate: touched['locAField'],
                ),
                TextFormField(
                  controller: tfLocB,
                  onSaved: (val) => _cardDetails.cardNumber = val,
                  decoration: InputDecoration(
                    labelText: 'To',
                    icon: Icon(Icons.location_city),
                  ),
                  validator: (value) {
                    if (value.isEmpty) return "This form value must be filled";
                    return null;
                  },
                ),
                TextFormField(
                  controller: tfDist,
                  onSaved: (val) => _cardDetails.securityCode = int.parse(val),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Distance (meter)',
                    icon: Icon(Icons.gps_fixed),
                  ),
                  validator: (value) {
                    if (value.isEmpty) return "This form value must be filled";
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
                    child: Text('Estimated Distance:'),
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
                  controller: tfCurrentLoad,
                  onSaved: (val) => _cardDetails.cardNumber = val,
                  decoration: InputDecoration(
                    labelText: 'Current Load (Ib)',
                    // icon: Icon(Icons.location_city),
                  ),
                  validator: (value) {
                    if (value.isEmpty) return "This form value must be filled";
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  onSaved: (val) => _cardDetails.expiryMonth = val,
                  value: expiryMonth,
                  items: [
                    '20',
                    '40',
                    '80',
                    '125',
                    '200',
                    '320',
                    '500',
                    '800',
                    '1000',
                    '1250'
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
                    labelText: 'Breaker Size (In)',
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
                            Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalcScreen2(),
                  ),
                );
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
