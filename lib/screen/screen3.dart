import 'package:flutter/material.dart';
import '../models/CalculationDetail.dart';
// import 'screen2.dart';

class Screen3 extends StatefulWidget {
  final CalculationDetail calculationDetail;
  Screen3(this.calculationDetail);

  @override
  _ResultPage createState() => _ResultPage();
}

class _ResultPage extends State<Screen3> {
  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Center(child: Text('RESULT SCREEN')),
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
                SizedBox(height: 25,),
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
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(13.0)),
                        child: Text(
                          "Confirm",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        textColor: Colors.black,
                        color: Colors.amber,
                        onPressed: () {
                          // save();
                        }),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
