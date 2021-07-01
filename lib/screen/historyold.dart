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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Calculation History'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: FutureBuilder(
              future: getHistory(),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          List list = snapshot.data;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Card(
                              elevation: 8,
                              child: ListTile(                            
                                isThreeLine: true,
                                leading: Text(list[index]['date']),
                                subtitle: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      5.0, 10.0, 0.0, 10.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(children: <Widget>[
                                        Text("From: "),
                                        Text(
                                          list[index]['loc_a'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(children: <Widget>[
                                        Text("To: "),
                                        Text(
                                          list[index]['loc_b'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(children: <Widget>[
                                        Text("Est. Distance: "),
                                        Text(
                                          list[index]['est_dist'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(children: <Widget>[
                                        Text("Cable Type: "),
                                        Text(
                                          list[index]['c_type'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(children: <Widget>[
                                        Text("Cable VD: "),
                                        Text(
                                          list[index]['c_vd'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(children: <Widget>[
                                        Text("Cable Iz: "),
                                        Text(
                                          list[index]['c_iz'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(children: <Widget>[
                                        Text("Calculated VD: "),
                                        Text(
                                          list[index]['calc_vd'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ]),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(children: <Widget>[
                                        Text("Calculated VD %: "),
                                        Text(
                                          list[index]['calc_vd_percent'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ]),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(children: <Widget>[
                                        Text("Allowed VD: "),
                                        Text(
                                          list[index]['allowed_vd'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ]),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(children: <Widget>[
                                        Text("Cable Quantity: "),
                                        Text(
                                          list[index]['c_qty'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ]),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(children: <Widget>[
                                        Text("Cable Price: "),
                                        Text(
                                          list[index]['c_price'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ]),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(children: <Widget>[
                                        Text("Overall Price: "),
                                        Text(
                                          list[index]['o_price'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })
                    : CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}
