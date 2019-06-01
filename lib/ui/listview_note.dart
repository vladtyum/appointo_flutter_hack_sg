import 'new_apnt_screen.dart';
import 'package:flutter/material.dart';
import '../model/appointo.dart';
import '../utils/database_helper.dart';
import 'note_screen.dart';

class AppointoMainPage extends StatefulWidget {
  @override
  _MainPageListState createState() => new _MainPageListState();
}

class _MainPageListState extends State<AppointoMainPage> {
  List< Apppointo > items = new List();
  DatabaseHelper db = new DatabaseHelper();

  @override
  void initState() {
    super.initState();

    db.getAllApnts().then((apnts) {
      setState(() {
        apnts.forEach((apnt) {
          items.add(Apppointo.fromMap(apnt));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSA ListView Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('AppointO app'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                    Divider(height: 10.0),
                    ListTile(
                      title: Text(
                        '${items[position].name}',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      subtitle: Text(
                        '${items[position].date}',
                        style: new TextStyle(
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
//                      leading: Column(
//                        children: <Widget>[
//                          Padding(padding: EdgeInsets.all(10.0)),
//                          CircleAvatar(
//                            backgroundColor: Colors.blueAccent,
//                            radius: 8.0,
//                            child: Text(
//                              '${items[position].id}',
//                              style: TextStyle(
//                                fontSize: 12.0,
//                                color: Colors.white,
//                              ),
//                            ),
//                          ),
//                          IconButton(
//                              icon: const Icon(Icons.remove_circle_outline),
//                              onPressed: () => _deleteNote(context, items[position], position)),
//                        ],
//                      ),
                      onTap: () => _navigateToNote(context, items[position]),
                    ),
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrange,
          child: Icon(Icons.add),
          onPressed: () => _createNewApnto(context),
        ),
      ),
    );
  }

  void _deleteApnto(BuildContext context, Apppointo apnt, int position) async {
    db.deleteApnt(apnt.id).then((apnts) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToNote(BuildContext context, Apppointo apnt) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ApntoScreen(apnt)),
    );

    if (result == 'update') {
      db.getAllApnts().then((apnts) {
        setState(() {
          items.clear();
          apnts.forEach((note) {
            items.add(Apppointo.fromMap(note));
          });
        });
      });
    }
  }

  void _createNewApnto(BuildContext context)  {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewApntoScreen()),
    );

  }
}
