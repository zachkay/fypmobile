import 'package:flutter/material.dart';
import 'empty_state.dart';
import 'formTemplate.dart';
import 'models/calcFormula.dart';

class MultiForm extends StatefulWidget {
  @override
  _MultiFormState createState() => _MultiFormState();
}

class _MultiFormState extends State<MultiForm> {
  List<CalcForm> details = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: .0,
        // leading: Icon(
        //   Icons.exposure,
        // ),
        title: Text('Calculator'),
        actions: <Widget>[
          // IconButton(icon: Icon(Icons.save), onPressed: onSave),
          FlatButton(
            child: Text('Save'),
            textColor: Colors.white,
            onPressed: onSave,
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
            ),
            ListTile(
              leading: Icon(Icons.games),
              title: Text('Calculator'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Feedback'),
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFD3D3D3),
              Color(0xFFFFFFFF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: details.length <= 0
            ? Center(
                child: EmptyState(
                  title: 'Nothing yet',
                  message: 'Add form by tapping add button below',
                ),
              )
            : ListView.builder(
                addAutomaticKeepAlives: true,
                itemCount: details.length,
                itemBuilder: (_, i) => details[i],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        onPressed: onAddForm,
        foregroundColor: Colors.white,
      ),
    );
  }

  ///on form user deleted
  void onDelete(Details _details) {
    setState(() {
      var find = details.firstWhere(
        (it) => it.details == _details,
        orElse: () => null,
      );
      if (find != null) details.removeAt(details.indexOf(find));
    });
  }

  ///on add form
  void onAddForm() {
    setState(() {
      var _details = Details();
      details.add(CalcForm(
        details: _details,
        onDelete: () => onDelete(_details),
      ));
    });
  }

  ///on save forms
  void onSave() {
    if (details.length > 0) {
      var allValid = true;
      details.forEach((form) => allValid = allValid && form.isValid());
      if (allValid) {
        var data = details.map((it) => it.details).toList();
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text('Result Overview'),
              ),
              body: ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, i) => ListTile(
                  // leading: CircleAvatar(
                  //   child: Text(data[i].locA.substring(0, 1)),
                  //   backgroundColor: Colors.black,
                  // ),
                  title: Text(' Location A : ' +
                      data[i].locA +
                      '\n Location B : ' +
                      data[i].locB +
                      '\n Cable Reference Type: '
                          '\n VD PVC: '
                          '\n Cable Size: '
                          '\n Cable (Core): '
                          '\n Iz: '
                          '\n Vd Calculated(lb): '
                          '\n Vd Allowed: '
                          '\n Vd Calculated Percentage: '
                          '\n Vd Allowed Percentage: '
                          '\n Cable Type: '
                          '\n Cable Quantity: '
                          '\n Cable Price(permeter)(RM): '
                          '\n Overall Cable Price(RM): '),
                  // subtitle: Text(data[i].locB),
                ),
              ),
            ),
          ),
        );
      }
    }
  }
}
