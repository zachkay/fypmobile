import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/calcDetail.dart';
import '../widgets/pdf.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// import 'screen2.dart';

class Screen3 extends StatefulWidget {
  final calcDetail calculationDetail;
  Screen3(this.calculationDetail);

  @override
  _ResultPage createState() => _ResultPage();
}

class _ResultPage extends State<Screen3> {
  // final _formKey = GlobalKey<FormState>();
  saveToast(String toast) {
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
        await http.post("http://10.0.2.2/budee/save_data.php", body: {
      "userid": preferences.getString("id").toString(),
      "locA": widget.calculationDetail.locA,
      "locB": widget.calculationDetail.locB,
      "estDist": widget.calculationDetail.estDist.toString(),
      "cType": widget.calculationDetail.cType,
      "cVd": widget.calculationDetail.cVd.toString(),
      "cIz": widget.calculationDetail.cIz.toString(),
      "calcVd": widget.calculationDetail.calcVd.toString(),
      "calcVdPercent": widget.calculationDetail.calcVdPercent.toString(),
      "allowedVd": widget.calculationDetail.allowedVD.toString(),
      "cQty": widget.calculationDetail.cQty.toString(),
      "cPrice": widget.calculationDetail.cPrice.toString(),
      "oPrice": widget.calculationDetail.overallPrice.toString(),
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
      });
      print(message);
      saveToast(message);
    } else if (value == 2) {
      print(message);
      saveToast(message);
    } else {
      print(message);
      saveToast(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            title: Center(child: Text('Result Screen')),
          ),
          body: SingleChildScrollView(
            child:
                // Text(
                //   'CABLE DETAILS',
                //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                // ),
                Column(
              children: <Widget>[
                // Center(
                //   child: Container(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: <Widget>[
                //         Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Text(
                //             "CALCULATION SUMMARY",
                //             style: TextStyle(
                //               fontSize: 16.0,
                //               fontWeight: FontWeight.bold,
                //               //fontFamily: "Courier",
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 25,
                ),
                Card(
                  color: Colors.white,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    child: DataTable(
                      columnSpacing: 50,
                      columns: <DataColumn>[
                        DataColumn(
                          label: Text(
                            'ITEM',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'DETAILS',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                      rows: <DataRow>[
                        // DataRow(
                        //   cells: <DataCell>[
                        //     DataCell(Text('Time :',
                        //         style:
                        //             TextStyle(fontWeight: FontWeight.bold))),
                        //     DataCell(
                        //       Text(
                        //         DateFormat('dd/MM/yyyy|hh:mm')
                        //             .format(DateTime.now()),
                        //         style:
                        //             TextStyle(fontWeight: FontWeight.normal),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('From:',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text('${widget.calculationDetail.locA}',
                                style: TextStyle(fontStyle: FontStyle.italic))),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('To:',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text('${widget.calculationDetail.locB}',
                                style: TextStyle(fontStyle: FontStyle.italic))),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Estimated Distance:',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text(
                                '${widget.calculationDetail.estDist.toStringAsFixed(1)}m',
                                style: TextStyle(fontStyle: FontStyle.italic))),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Cable Type:',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text('${widget.calculationDetail.cType}',
                                style: TextStyle(fontStyle: FontStyle.italic))),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Cable Vd :',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text('${widget.calculationDetail.cVd}V',
                                style: TextStyle(fontStyle: FontStyle.italic))),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Cable Iz :',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text('${widget.calculationDetail.cIz}A',
                                style: TextStyle(fontStyle: FontStyle.italic))),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Calculated Vd:',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text(
                                '${widget.calculationDetail.calcVd.toStringAsFixed(2)}A',
                                style: TextStyle(fontStyle: FontStyle.italic))),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Calculated Vd Percentage:',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text(
                                '${widget.calculationDetail.calcVdPercent.toStringAsFixed(2)}%',
                                style: TextStyle(fontStyle: FontStyle.italic))),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Allowed Vd :',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text(
                                '${widget.calculationDetail.allowedVD}%',
                                style: TextStyle(fontStyle: FontStyle.italic))),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Cable Quantity :',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text('${widget.calculationDetail.cQty}',
                                style: TextStyle(fontStyle: FontStyle.italic))),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Cable Price :',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text(
                                'RM${widget.calculationDetail.cPrice.toStringAsFixed(2)}',
                                style: TextStyle(fontStyle: FontStyle.italic))),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Overall Cable Price :',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text(
                                'RM${widget.calculationDetail.overallPrice.toStringAsFixed(2)}',
                                style: TextStyle(fontStyle: FontStyle.italic))),
                          ],
                        ),
                      ],
                    ),
                    //style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(13.0)),
                        child: Text("SAVE"),
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
                          save();
                        }),
                    ElevatedButton(
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(13.0)),
                      child: Text("PRINT"),
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                            fontSize: 15.0,
                            // fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold),
                        primary: Colors.amberAccent,
                        onPrimary: Colors.black,
                        elevation: 5,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                        shape: StadiumBorder(),
                      ),
                      onPressed: () async {
                        final pdfFile = await PdfApi.generateTable(widget.calculationDetail);
                        PdfApi.openFile(pdfFile);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )),
    );
  }
}
