import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/screen/calcScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quick_feedback/quick_feedback.dart';
import 'multiForm.dart';
import 'screen/screen1.dart';

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

  int currentIndex = 0;
  String selectedIndex = 'TAB: 0';

  String email = "", name = "", id = "";
  TabController tabController;

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

  // _showFeedback(context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return QuickFeedback(
  //         title: 'Leave a feedback',
  //         // Title of dialog
  //         showTextBox: true,
  //         // default false
  //         textBoxHint: 'Share your feedback',
  //         // Feedback text field hint text default: Tell us more
  //         submitText: 'SUBMIT',
  //         // submit button text default: SUBMIT
  //         onSubmitCallback: (feedback) {
  //           print('$feedback'); // map { rating: 2, feedback: 'some feedback' }
  //           Navigator.of(context).pop();
  //         },
  //         askLaterText: 'ASK LATER',
  //         onAskLaterCallback: () {
  //           print('Do something on ask later click');
  //         },
  //       );
  //     },
  //   );
  // }

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
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Text(
                'BuDEE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiForm(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.games),
              title: Text('Calculator'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalcScreen1(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Feedback'),
            ),
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text('History'),
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => CalcScreen1(),
              //     ),
              //   );
              // },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
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
//       bottomNavigationBar: BottomNavyBar(
//         backgroundColor: Colors.black,
//         iconSize: 30.0,
// //        iconSize: MediaQuery.of(context).size.height * .60,
//         currentIndex: currentIndex,
//         onItemSelected: (index) {
//           setState(() {
//             currentIndex = index;
//           });
//           /*selectedIndex = 'TAB: $currentIndex';
// //            print(selectedIndex);
//           reds(selectedIndex);*/
//         },
//
//         items: [
//           BottomNavyBarItem(
//               icon: Icon(Icons.home),
//               title: Text('Home'),
//               activeColor: Color(0xFFf7d426)),
//           BottomNavyBarItem(
//               icon: Icon(Icons.view_list),
//               title: Text('List'),
//               activeColor: Color(0xFFf7d426)),
//           BottomNavyBarItem(
//               icon: Icon(Icons.person),
//               title: Text('Profile'),
//               activeColor: Color(0xFFf7d426)),
//         ],
//       ),
    );
  }

//  Action on Bottom Bar Press
/*void reds(selectedIndex) {
//    print(selectedIndex);

    switch (selectedIndex) {
      case "TAB: 0":
        {
          callToast("Tab 0");
        }
        break;

      case "TAB: 1":
        {
          callToast("Tab 1");
        }
        break;

      case "TAB: 2":
        {
          callToast("Tab 2");
        }
        break;
    }
  }

  callToast(String msg) {
    Fluttertoast.showToast(
        msg: "$msg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }*/
}
