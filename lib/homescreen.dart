// import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_login/screen/calcScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screen/history.dart';
import 'screen/screen1.dart';
import 'screen/feedback.dart';
import 'screen/about.dart';
// import 'screen/screen3.dart';

class MainMenu extends StatefulWidget {
  final VoidCallback signOut;

  MainMenu(this.signOut);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  // int currentIndex = 0;
  // String selectedIndex = 'TAB: 0';

  String email = "", name = "", id = "";
  // TabController tabController;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString("id");
      email = preferences.getString("email");
      name = preferences.getString("name");
    });
    print("id: " + id);
    print("user: " + email);
    print("name: " + name);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(217, 217, 217, 1),
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Dashboard'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              signOut();
            },
            icon: Icon(Icons.logout_rounded),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              margin: EdgeInsets.only(bottom: 8.0),
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.amberAccent,
                    foregroundColor: Colors.black,
                    radius: 35.0,
                    child: Text(
                      name.length > 0 ? name[0] : "",
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Hi, " + name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    email,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            // ListTile(
            //   leading: Icon(Icons.account_circle),
            //   title: Text('Profile'),
            //   onTap: () {
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(
            //     //     builder: (context) => Screen3(),
            //     //   ),
            //     // );
            //   },
            // ),
            ListTile(
              leading: Icon(Icons.cable_rounded),
              title: Text('Calculate Voltage Drop'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalcForm1(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.history_rounded),
              title: Text('Calculation History'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => History(),
                  ),
                );
              },
            ),

            Divider(
              thickness: 1,
              indent: 15,
              endIndent: 20,
            ),

            ListTile(
              leading: Icon(Icons.feedback_rounded),
              title: Text('Give Feedback'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FeedbackForm(),
                  ),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.info_outline_rounded),
              title: Text('About Application'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => About(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            // Text(
            //   "Welcome, " + name,
            //   style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 28.0,
            //       fontWeight: FontWeight.bold),
            //   textAlign: TextAlign.start,
            // ),
            // Text(
            //   "Select an option",
            //   style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 23.0,
            //       fontWeight: FontWeight.bold),
            //   textAlign: TextAlign.start,
            // ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20.0,
                  children: <Widget>[
                    SizedBox(
                      width: 160.0,
                      height: 160.0,
                      child: Card(
                        color: Color.fromARGB(255, 21, 21, 21),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                            child: Column(
                              children: <Widget>[
                                IconButton(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  icon: Icon(Icons.cable_rounded),
                                  iconSize: 90,
                                  color: Colors.amberAccent,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CalcForm1(),
                                      ),
                                    );
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    "Calculate VD",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CalcForm1(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 160.0,
                      height: 160.0,
                      child: Card(
                        color: Color.fromARGB(255, 21, 21, 21),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                            child: Column(
                              children: <Widget>[
                                IconButton(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  icon: Icon(Icons.history_rounded),
                                  iconSize: 90,
                                  color: Colors.amberAccent,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => History(),
                                      ),
                                    );
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    "History",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => History(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 160.0,
                      height: 160.0,
                      child: Card(
                        color: Color.fromARGB(255, 21, 21, 21),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                            child: Column(
                              children: <Widget>[
                                IconButton(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                icon: Icon(Icons.info_outline_rounded),
                                iconSize: 90,
                                color: Colors.amberAccent,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => About(),
                                    ),
                                  );
                                },
                              ),
                              TextButton(
                                child: Text(
                                  "About App",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => About(),
                                    ),
                                  );
                                },
                              ),
                              ],
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 160.0,
                      height: 160.0,
                      child: Card(
                        color: Color.fromARGB(255, 21, 21, 21),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                            child: Column(
                              children: <Widget>[
                                IconButton(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                icon: Icon(Icons.feedback_rounded),
                                iconSize: 90,
                                color: Colors.amberAccent,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FeedbackForm(),
                                    ),
                                  );
                                },
                              ),
                              TextButton(
                                child: Text(
                                  "Feedback",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FeedbackForm(),
                                    ),
                                  );
                                },
                              ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            )
            // Text(
            //   'Welcome, ' + name, textAlign: TextAlign.left, textDirection: TextAlign,
            //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Card(
            //   elevation: 10,
            //   child: ListTile(
            //     // leading: Icon(Icons.calculate_rounded),
            //     title: Text('Calculator', style: TextStyle(fontSize: 30), textAlign: TextAlign.center,),
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => CalcForm1(),
            //         ),
            //       );
            //     },
            //     minVerticalPadding: 20,
            //   ),
            // ),
            // Card(
            //   elevation: 10,
            //   child: ListTile(
            //     leading: Icon(Icons.calculate_rounded),
            //     title: Text('History'),
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => CalcForm1(),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            // Card(
            //   elevation: 10,
            //   child: ListTile(
            //     leading: Icon(Icons.calculate_rounded),
            //     title: Text('Feedback'),
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => CalcForm1(),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            // Card(
            //   elevation: 10,
            //   child: ListTile(
            //     leading: Icon(Icons.calculate_rounded),
            //     title: Text('About'),
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => CalcForm1(),
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
