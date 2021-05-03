// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// class CalcScreen extends StatelessWidget {
//   const CalcScreen({Key key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text('CalcForms'),
//       ),
//       body: CalcForm(), // We'll add this in a bit
//     );
//   }
// }

// class CalcForm extends StatefulWidget {
//   CalcForm({Key key}) : super(key: key);
//   @override
//   _CalcFormState createState() => _CalcFormState();
// }

// class _CalcFormState extends State<CalcForm> {
//   final _formKey = GlobalKey<FormState>();
//   CardDetails _cardDetails = new CardDetails();
//   String expiryMonth;
//   String expiryYear;
//   Address _paymentAddress = new Address();
//   bool rememberInfo = false;
//   bool loading = false;

//   final List yearsList = List.generate(12, (int index) => index + 2020);
//   Map<String, bool> touched = {
//     "cardNumberField": false,
//   };
//   final _cardNumberController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Form(
//         key: _formKey,
//         child: ListView(
//           children: <Widget>[
//             Column(children: <Widget>[
//               TextFormField(
//                 controller: _cardNumberController,
//                 onSaved: (val) => _cardDetails.cardHolderName = val,
//                 onChanged: (value) {
//                   setState(() {
//                     touched['cardNumberField'] = true;
//                   });
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'Name on card',
//                   icon: Icon(Icons.account_circle),
//                 ),
//                 validator: (value) {
//                   if (value.isEmpty) return "This form value must be filled";
//                   return null;
//                 },
//                 autovalidate: touched['cardNumberField'],
//               ),
//               TextFormField(
//                 onSaved: (val) => _cardDetails.cardNumber = val,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   labelText: 'Card number',
//                   icon: Icon(Icons.credit_card),
//                 ),
//                 validator: (value) {
//                   if (value.isEmpty) return "This form value must be filled";
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 onSaved: (val) => _cardDetails.securityCode = int.parse(val),
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   labelText: 'Security Code',
//                   icon: Icon(Icons.lock_outline),
//                 ),
//                 maxLength: 4,
//                 validator: (value) {
//                   if (value.isEmpty) return "This form value must be filled";
//                   return null;
//                 },
//               ),
//               DropdownButtonFormField<String>(
//                 onSaved: (val) => _cardDetails.expiryMonth = val,
//                 value: expiryMonth,
//                 items: [
//                   'Jan',
//                   'Feb',
//                   'Mar',
//                   'Apr',
//                   'May',
//                   'Jun',
//                   'Jul',
//                   'Aug',
//                   'Sep',
//                   'Oct',
//                   'Nov',
//                   'Dec'
//                 ].map<DropdownMenuItem<String>>(
//                   (String val) {
//                     return DropdownMenuItem(
//                       child: Text(val),
//                       value: val,
//                     );
//                   },
//                 ).toList(),
//                 onChanged: (val) {
//                   setState(() {
//                     expiryMonth = val;
//                   });
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'Expiry Month',
//                   icon: Icon(Icons.calendar_today),
//                 ),
//               ),
//               DropdownButtonFormField(
//                 onSaved: (val) => _cardDetails.expiryYear = val.toString(),
//                 value: expiryYear,
//                 items: yearsList.map<DropdownMenuItem>(
//                   (val) {
//                     return DropdownMenuItem(
//                       child: Text(val.toString()),
//                       value: val.toString(),
//                     );
//                   },
//                 ).toList(),
//                 onChanged: (val) {
//                   setState(() {
//                     expiryYear = val.toString();
//                   });
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'Expiry Year',
//                   icon: Icon(Icons.calendar_today),
//                 ),
//               ),
//               TextFormField(
//                 onSaved: (val) => _paymentAddress.postCode = val,
//                 decoration: InputDecoration(
//                     labelText: 'Post Code', icon: Icon(Icons.location_on)),
//               ),
//               TextFormField(
//                 onSaved: (val) => _paymentAddress.addressLine = val,
//                 decoration: InputDecoration(
//                     labelText: 'Address Line', icon: Icon(Icons.location_city)),
//               ),
//               CheckboxListTile(
//                 value: rememberInfo,
//                 onChanged: (val) {
//                   setState(() {
//                     rememberInfo = val;
//                   });
//                 },
//                 title: Text('Remember Information'),
//               ),
//               RaisedButton(
//                 child: loading
//                     ? SpinKitWave(
//                         color: Colors.white,
//                         size: 15.0,
//                       )
//                     : Text('Process Payment'),
//                 color: Colors.amber,
//                 textColor: Colors.white,
//                 onPressed: () {
//                   if (_formKey.currentState.validate()) {
//                     setState(() {
//                       loading = true;
//                     });
//                     _formKey.currentState.save();
//                     Timer(Duration(seconds: 1), () {
//                       Payment payment = new Payment(
//                           address: _paymentAddress, cardDetails: _cardDetails);
//                       setState(() {
//                         loading = false;
//                       });
//                       final snackBar =
//                           SnackBar(content: Text('Payment Proccessed'));
//                       Scaffold.of(context).showSnackBar(snackBar);
//                       print('Saved');
//                     });
//                   }
//                 },
//               ),
//             ]), // we will work in here
//           ],
//         ),
//       ),
//     );
//   }
// }
