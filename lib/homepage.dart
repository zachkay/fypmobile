// import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_login/screen/calcScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screen/screen1.dart';
import 'screen/feedback.dart';
// import 'screen/screen2.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.black,
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
                    backgroundColor: Colors.lightBlueAccent,
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
                  Text("Hi, " +
                    name,
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
              leading: Icon(Icons.calculate_rounded),
              title: Text('Calculator'),
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
              title: Text('History'),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => CalcForm1(),
                //   ),
                // );
              },
            ),

            Divider(
              thickness: 1,
              indent: 15,
              endIndent: 20,
            ),

            ListTile(
              leading: Icon(Icons.feedback_rounded),
              title: Text('Feedback'),
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
              title: Text('About'),
              onTap: () {},
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => _showFeedback(context),
              //     ),
              //   );
              // },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Text(
            "Aplikasi ini bertujuan sebagai kalkulator kepada pengiraan saiz kabel dan susut voltan."
            "Saiz kabel adalah penting bagi memastikan operasi yang betul bagi sesebuah litar elektrik."
            "Pengiraan susut voltan pula adalah suatu cara diagnosis elektrikal yang mampu mencari masalah beban tinggi",
            style: TextStyle(fontSize: 25.0, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
