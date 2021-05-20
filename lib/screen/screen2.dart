import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/calcDetail.dart';
import './screen3.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:http/http.dart' as http;

class CalcForm2 extends StatefulWidget {
  final calcDetail calculationDetail;
  CalcForm2(this.calculationDetail);

  @override
  _CalcForm2State createState() => _CalcForm2State();
}

class _CalcForm2State extends State<CalcForm2> {
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  // Map<String, bool> touched = {
  //   "tfAllowedVD": false,
  // };

  final TextEditingController tfAllowedVD = TextEditingController();

  String allowedVD;
  String selectedInstType = "";
  var selectedCablePhase;
  var selectedCableIz;
  var selectedCableType;
  int cableQty;
  double calcCableVd;
  double calcCableVdPercent;
  double calcCablePrice;
  double vd;
  double price;

  // List data = List();
  Map<String, dynamic> data = new Map<String, dynamic>();
  List cPhaseData = [];
  List cTypeData = [];
  List filterCTypeData = [];
  List cSpecData = [];
  List filterCSpecData = [];

  Future getAllData() async {
    var response = await http.get("http://10.0.2.2/budee/call_data.php",
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    setState(() {
      data = jsonData;
      cPhaseData = data["cphase"];
      filterCTypeData = cTypeData = data["ctype"];
      filterCSpecData = cSpecData = data["cspec"];
    });
    // print(filterCSpecData);
  }

  filterCableType() {
    setState(() {
      selectedCableType = null;
      selectedCableIz = null;
      filterCTypeData = cTypeData
          .where((ctype) => (ctype['phase_id'] == selectedCablePhase &&
              ctype['installation_type'].contains(selectedInstType)))
          .toList();
    });
  }

  filterCableIz() {
    setState(() {
      selectedCableIz = null;
      filterCSpecData = cSpecData
          .where((ciz) => (ciz['type_id'] == selectedCableType &&
              double.parse(ciz['iz']) > widget.calculationDetail.bSize))
          .toList();
    });
  }

  String getPhase() {
    List getPhaseName = cPhaseData.where((cphase) {
      return (cphase['phase_id'] == selectedCablePhase);
    }).toList();
    return getPhaseName.length > 0 ? getPhaseName[0]['phase'] : "";
  }

  String getCable() {
    List getCablename = cTypeData.where((cname) {
      return (cname['type_id'] == selectedCableType);
    }).toList();
    return getCablename.length > 0 ? getCablename[0]['cable_name'] : "";
  }

  double getVd(typeId, izValue) {
    List filterVd = cSpecData.where((ciz) {
      return (ciz['type_id'] == typeId && (ciz['iz']) == izValue);
    }).toList();
    return filterVd.length > 0 ? double.parse(filterVd[0]['vd']) : 0;
  }

  double getPrice(typeId, izValue) {
    // function return value = 10.50
    List filterPrice = cSpecData.where((ciz) {
      return (ciz['type_id'] == typeId && (ciz['iz']) == izValue);
    }).toList();
    return filterPrice.length > 0 ? double.parse(filterPrice[0]['price']) : 0;
  }

//function multiple calculation in dropdown
  calcVd(val) {
    vd = getVd(selectedCableType, selectedCableIz);
    
    if (val == 'Ib (Current Load)') {
      calcCableVd = (vd *
              widget.calculationDetail.estDist *
              widget.calculationDetail.cLoad) /
          (1000.0 * cableQty);
      if (selectedCablePhase == '1') {
        calcCableVdPercent = (calcCableVd * 100) / 230;
      } else {
        calcCableVdPercent = (calcCableVd * 100) / 400;
      }

    } else {
      calcCableVd = (vd *
              widget.calculationDetail.estDist *
              widget.calculationDetail.bSize.toDouble()) /
          (1000.0 * cableQty);
      if (selectedCablePhase == '1') {
        calcCableVdPercent = (calcCableVd * 100) / 230;
      } else {
        calcCableVdPercent = (calcCableVd * 100) / 400;
      }
    }
    calcPrice();
    // print(calcCableVd);
    // print(calcCableVdPercent);
    // print(price);
    // print(calcCablePrice);
  }

  calcPrice() {
    price = getPrice(selectedCableType, selectedCableIz);
    calcCablePrice = price * widget.calculationDetail.estDist * cableQty;
  }

  toScreen3(context) {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      _formKey.currentState.save();
      Timer(Duration(seconds: 2), () {
        setState(() {
          loading = false;
        });
        widget.calculationDetail.cPhase = getPhase();
        widget.calculationDetail.allowedVD = double.parse(tfAllowedVD.text);
        widget.calculationDetail.instType = selectedInstType;
        widget.calculationDetail.cType = getCable();
        widget.calculationDetail.cQty = cableQty;
        widget.calculationDetail.cIz = double.parse(selectedCableIz);
        widget.calculationDetail.cVd = vd;
        widget.calculationDetail.calcVd = calcCableVd;
        widget.calculationDetail.calcVdPercent = calcCableVdPercent;
        widget.calculationDetail.cPrice = price;
        widget.calculationDetail.overallPrice = calcCablePrice;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Screen3(widget.calculationDetail),
          ),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAllData();
  }

  @override
  Widget build(BuildContext context) {
    //getAllBreaker();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Screen 2'),
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
                    items: cPhaseData.map(
                      (list) {
                        return DropdownMenuItem(
                          child: Text(list['phase']),
                          value: list['phase_id'],
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedCablePhase = (val);
                        print(selectedCablePhase);
                        filterCableType();
                      });
                    },
                    validator: (val) => val == null
                    ? 'Please select cable phase' : null,
                    // onChanged: filterCableType,
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
                    controller: tfAllowedVD,
                    // onSaved: (val) => _cardDetails.cardHolderName = val,
                    onChanged: (val) {
                      setState(() {
                        allowedVD = val;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty)
                        return "This form value must be filled";
                      return null;
                    },
                    // autovalidate: touched['tfAllowedVD'],
                    keyboardType: TextInputType.number,
                  ),
                  DropdownButtonFormField(
                    //onSaved: (val) => _cardDetails.expiryMonth = val,
                    //value: selectedBreaker,
                    decoration: InputDecoration(
                      labelText: 'Installation Type',
                      // icon: Icon(Icons.calendar_today),
                    ),
                    items: <String>[
                      'INDOOR',
                      'OUTDOOR'
                    ].map<DropdownMenuItem<String>>((String selectedInstType) {
                      return DropdownMenuItem<String>(
                        child: Text(selectedInstType),
                        value: selectedInstType,
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedInstType = val;
                        filterCableType();
                      });
                    },
                    validator: (val) => val == null
                    ? 'Please select installation type' : null,
                  ),
                  DropdownButtonFormField(
                    //onSaved: (val) => _cardDetails.expiryMonth = val,
                    value: selectedCableType,
                    decoration: InputDecoration(
                      labelText: 'Cable Type',
                      // icon: Icon(Icons.calendar_today),
                    ),
                    items: filterCTypeData.map(
                      (list) {
                        return DropdownMenuItem(
                          child: Text(list['cable_name']),
                          value: list['type_id'],
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedCableType = val;
                        filterCableIz();
                      });
                    },
                    validator: (val) => val == null
                    ? 'Please select cable type' : null,
                  ),
                  DropdownButtonFormField(
                    //onSaved: (val) => _cardDetails.expiryMonth = val,
                    value: cableQty,
                    decoration: InputDecoration(
                      labelText: 'Number of Cable',
                      // icon: Icon(Icons.calendar_today),
                    ),
                    items: <int>[1, 2, 3, 4]
                        .map<DropdownMenuItem<int>>((int cableQty) {
                      return DropdownMenuItem<int>(
                        child: Text(cableQty.toString()),
                        value: cableQty,
                      );
                    }).toList(),
                    // onChanged: (val) {},
                    onChanged: (val) {
                      setState(() {
                        cableQty = val;
                      });
                    },
                    validator: (val) => val == null
                    ? 'Please select cable No.' : null,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                      child: Text(
                        'Notes: Iz > In',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  DropdownButtonFormField(
                    //onSaved: (val) => _cardDetails.expiryMonth = val,
                    value: selectedCableIz,
                    decoration: InputDecoration(
                      labelText: 'Cable Iz',
                      // icon: Icon(Icons.calendar_today),
                    ),
                    items: filterCSpecData.map(
                      (list) {
                        return DropdownMenuItem(
                          child: Text(list['iz']),
                          value: list['iz'],
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedCableIz = val;
                      });
                    },
                    validator: (val) => val == null
                    ? 'Please select cable Iz' : null,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                      child: Text(
                        'CURRENT FOR VOLTAGE DROP CALCULATION',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  DropdownButtonFormField(
                    // value: vdCalcCurrent,
                    decoration: InputDecoration(
                      labelText: 'Voltage Drop Calculation Current (I)',
                      // icon: Icon(Icons.calendar_today),
                    ),
                    items: <String>['Ib (Current Load)', 'In (Breaker Size)']
                        .map<DropdownMenuItem<String>>((String cVd) {
                      return DropdownMenuItem<String>(
                        child: Text(cVd.toString()),
                        value: cVd,
                      );
                    }).toList(),
                    onChanged: calcVd,
                    validator: (val) => val == null
                    ? 'Please select current (I) for the vd calculation' : null,
                    // onChanged: (val) {
                    //   setState(() {
                    //     calcVd = val;
                    //   });
                    // },
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                          // tfLocA.clear();
                          // tfLocB.clear();
                          setState(() {
                            selectedCableType = null;
                            selectedCableIz = null;
                          });
                        },
                      ),
                      ElevatedButton(
                        child: loading
                            ? SpinKitWave(
                                color: Colors.black,
                                size: 20.0,
                              )
                            : Text('CALCULATE'),
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(
                              fontSize: 15.0,
                              // fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold),
                          primary: Colors.amberAccent,
                          onPrimary: Colors.black,
                          elevation: 5,
                          padding: EdgeInsets.symmetric(
                              horizontal: 35, vertical: 10),
                          shape: StadiumBorder(),
                        ),
                        onPressed: () {
                          toScreen3(context);
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
