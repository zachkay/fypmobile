import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'models/calcFormula.dart';

typedef OnDelete();

class CalcForm extends StatefulWidget {
  final Details details;
  final state = _CalcFormState();
  final OnDelete onDelete;

  CalcForm({Key key, this.details, this.onDelete}) : super(key: key);
  @override
  _CalcFormState createState() => state;

  bool isValid() => state.validate();
}

class _CalcFormState extends State<CalcForm> {
  final form = GlobalKey<FormState>();
  String _myActivity, _myActivity2, _myActivity3, _myActivity4, _myActivity5;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Material(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppBar(
                leading: Icon(Icons.verified_user),
                elevation: 0,
                title: Text('Input'),
                backgroundColor: Colors.black,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: widget.onDelete,
                  )
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 16),
                child: TextFormField(
                  initialValue: widget.details.locA,
                  onSaved: (val) => widget.details.locA = val,
                  validator: (val) =>
                      val.length > 1 ? null : 'Location A is invalid',
                  decoration: InputDecoration(
                    labelText: 'Location A',
                    hintText: 'Enter your starting location',
                    icon: Icon(Icons.home),
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 10),
                child: TextFormField(
                  initialValue: widget.details.locB,
                  onSaved: (val) => widget.details.locB = val,
                  validator: (val) =>
                      val.length > 1 ? null : 'Location is invalid',
                  // val.contains('@') ? null : 'Email is invalid',
                  decoration: InputDecoration(
                    labelText: 'Location B',
                    hintText: 'Enter your target location',
                    icon: Icon(Icons.business),
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: widget.details.dist,
                  onSaved: (val) => widget.details.dist = val,
                  validator: (val) =>
                      val.length > 1 ? null : 'Distance is invalid',
                  decoration: InputDecoration(
                    labelText: 'Distance(meter)',
                    hintText: 'Enter the distance between A & B',
                    helperText:
                        '15% will be multiplied to the original distance',
                    icon: Icon(Icons.gps_fixed),
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: widget.details.dist,
                  onSaved: (val) => widget.details.dist = val,
                  validator: (val) =>
                      val.length > 1 ? null : 'Current load is invalid',
                  decoration: InputDecoration(
                    labelText: 'Current Load(Ib)',
                    hintText: 'Enter the current load',
                    icon: Icon(Icons.flash_on),
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 10),
                child: DropDownFormField(
                  titleText: 'Breaker Size(In)',
                  hintText: 'Please choose greater than current load',
                  value: _myActivity,
                  onSaved: (value) {
                    setState(() {
                      _myActivity = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      _myActivity = value;
                    });
                  },
                  dataSource: [
                    {
                      "display": "20",
                      "value": "20",
                    },
                    {
                      "display": "32",
                      "value": "32",
                    },
                    {
                      "display": "40",
                      "value": "40",
                    },
                    {
                      "display": "63",
                      "value": "63",
                    },
                    {
                      "display": "80",
                      "value": "80",
                    },
                    {
                      "display": "100",
                      "value": "100",
                    },
                    {
                      "display": "125",
                      "value": "125",
                    },
                    {
                      "display": "160",
                      "value": "160",
                    },
                    {
                      "display": "200",
                      "value": "200",
                    },
                    {
                      "display": "250",
                      "value": "250",
                    },
                    {
                      "display": "320",
                      "value": "320",
                    },
                    {
                      "display": "400",
                      "value": "400",
                    },
                    {
                      "display": "500",
                      "value": "500",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 10),
                child: DropDownFormField(
                  titleText: 'Volt',
                  hintText: 'Please choose cable type',
                  value: _myActivity2,
                  onSaved: (value) {
                    setState(() {
                      _myActivity2 = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      _myActivity2 = value;
                    });
                  },
                  dataSource: [
                    {
                      "display": "SINGLE PHASE",
                      "value": "SINGLE PHASE",
                    },
                    {
                      "display": "THREE PHASE",
                      "value": "THREE PHASE",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: widget.details.acceptedVD,
                  onSaved: (val) => widget.details.acceptedVD = val,
                  validator: (val) => val.length > 1
                      ? null
                      : 'Voltage drop percentage allowed is invalid',
                  decoration: InputDecoration(
                    labelText: 'Voltage Drop Percentage Allowed',
                    hintText: 'Enter the current load',
                    icon: Icon(Icons.verified_user),
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 10),
                child: DropDownFormField(
                  titleText: 'Installation Type',
                  hintText: 'Please choose installation type',
                  value: _myActivity3,
                  onSaved: (value) {
                    setState(() {
                      _myActivity3 = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      _myActivity3 = value;
                    });
                  },
                  dataSource: [
                    {
                      "display": "INDOOR",
                      "value": "INDOOR",
                    },
                    {
                      "display": "OUTDOOR",
                      "value": "OUTDOOR",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 10),
                child: DropDownFormField(
                  titleText: 'Cable Type',
                  hintText: 'Please choose cable type',
                  value: _myActivity4,
                  onSaved: (value) {
                    setState(() {
                      _myActivity4 = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      _myActivity4 = value;
                    });
                  },
                  dataSource: [
                    {
                      "display": "PVC(INDOOR)",
                      "value": "PVC(INDOOR)",
                    },
                    {
                      "display": "XLPE(INDOOR)",
                      "value": "XLPE(INDOOR)",
                    },
                    {
                      "display": "XLPE/SWA/PVC(OUTDOOR)",
                      "value": "XLPE/SWA/PVC(OUTDOOR)",
                    },
                    {
                      "display": "PVC/SWA/PVC(OUTDOOR)",
                      "value": "PVC/SWA/PVC(OUTDOOR)",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 10),
                child: DropDownFormField(
                  titleText: 'Cable Amount',
                  hintText: 'Please choose cable amount',
                  value: _myActivity5,
                  onSaved: (value) {
                    setState(() {
                      _myActivity5 = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      _myActivity5 = value;
                    });
                  },
                  dataSource: [
                    {
                      "display": "1",
                      "value": "1",
                    },
                    {
                      "display": "2",
                      "value": "2",
                    },
                    {
                      "display": "3",
                      "value": "3",
                    },
                    {
                      "display": "4",
                      "value": "4",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///form validator
  bool validate() {
    var valid = form.currentState.validate();
    if (valid) form.currentState.save();
    return valid;
  }
}
