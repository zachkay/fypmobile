import 'package:flutter/material.dart';  
import '../models/CalculationDetail.dart';

class Screen3 extends StatefulWidget {  
  final CalculationDetail calculationDetail;
  Screen3(this.calculationDetail);

  @override  
  _DataTableExample createState() => _DataTableExample();  
}  
  
class _DataTableExample extends State<Screen3> {  
  @override  
  Widget build(BuildContext context) {  
    return MaterialApp(  
      home: Scaffold(  
          appBar: AppBar(  
            title: Text('Flutter DataTable Example'),  
          ),  
          body: ListView(children: <Widget>[  
            Center(  
                child: Text(  
                  'People-Chart',  
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),  
                )),  
            DataTable( 
              columnSpacing: 0.5, 
              columns: [  
                DataColumn(label: Text(  
                    'ID',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)  
                )),  
                DataColumn(label: Text(  
                    'Name',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)  
                )),  
                DataColumn(label: Text(  
                    'Profession',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)  
                )),  
              ],  
              rows: [  
                DataRow(cells: [  
                  DataCell(Text('1')),  
                  DataCell(Text('Stephen')),  
                  DataCell(Text('Actor')),  
                ]),  
                DataRow(cells: [  
                  DataCell(Text('5')),  
                  DataCell(Text('John')),  
                  DataCell(Text('Student')),  
                ]),  
                DataRow(cells: [  
                  DataCell(Text('10')),  
                  DataCell(Text('Harry')),  
                  DataCell(Text('Leader')),  
                ]),  
                DataRow(cells: [  
                  DataCell(Text('15')),  
                  DataCell(Text('Peter')),  
                  DataCell(Text('Scientist')),  
                ]),  
              ],  
            ),  
          ])  
      ),  
    );  
  }  
}  