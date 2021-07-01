import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class History extends StatefulWidget {
  History({Key key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String id = "";

  List itemExpanded = [];

  @override
  void initState() {
    super.initState();
  }

  Future getHistory() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString("id");
    var url = 'http://10.0.2.2/budee/call_history.php?id=$id';
    var response = await http.get(url);
    return json.decode(response.body);
  }

  List<ExpansionPanel> listExpansionPanel(var snapshot) {
    List<ExpansionPanel> expLst = [];
    int count = 0;
    snapshot.forEach((data) {
      itemExpanded.add(false);
      expLst.add(ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return ListTile(
            title: Text(data['date']),
          );
        },
        body: Column(
          children: [
            Divider(
              color: Colors.grey[200],
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Container(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[                
                      Text(
                        data['loc_a'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.arrow_right_alt_rounded),
                      Text(
                        data['loc_b'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
                    SizedBox(
                      height: 5,
                    ),
                    
                    Row(children: <Widget>[
                      Text("Est. Distance: "),
                      Text(
                        '${data['est_dist']}m',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
                    SizedBox(
                      height: 5,
                    ),
                    Row(children: <Widget>[
                      Text("Cable Type: "),
                      Text(
                        data['c_type'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
                    SizedBox(
                      height: 5,
                    ),
                    Row(children: <Widget>[
                      Text("Cable VD: "),
                      Text(
                        '${data['c_vd']}mV',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
                    SizedBox(
                      height: 5,
                    ),
                    Row(children: <Widget>[
                      Text("Cable Iz: "),
                      Text(
                        '${data['c_iz']}A',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
                    SizedBox(
                      height: 5,
                    ),
                    Row(children: <Widget>[
                      Text("Calculated VD: "),
                      Text(
                        '${data['calc_vd']}V',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
                    SizedBox(
                      height: 5,
                    ),
                    Row(children: <Widget>[
                      Text("Calculated VD: "),
                      Text(
                        '${data['calc_vd_percent']}%',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
                    SizedBox(
                      height: 5,
                    ),
                    Row(children: <Widget>[
                      Text("Allowed VD: "),
                      Text(
                        '${data['allowed_vd']}%',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
                    SizedBox(
                      height: 5,
                    ),
                    Row(children: <Widget>[
                      Text("Cable Quantity: "),
                      Text(
                        data['c_qty'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
                    SizedBox(
                      height: 5,
                    ),
                    Row(children: <Widget>[
                      Text("Cable Price: "),
                      Text(
                        'RM${data['c_price']}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
                    SizedBox(
                      height: 5,
                    ),
                    Row(children: <Widget>[
                      Text("Overall Price: "),
                      Text(
                        'RM${data['o_price']}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
        isExpanded: itemExpanded[count],
      ));
      count++;
    });
    return expLst;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Calculation History'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder(
            future: getHistory(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? ExpansionPanelList(
                    animationDuration: Duration(milliseconds: 750),
                    expandedHeaderPadding: EdgeInsets.only(bottom: 0),
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          itemExpanded[index] = !isExpanded;
                        });
                      },
                      children: listExpansionPanel(snapshot.data),
                    )
                  : CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
