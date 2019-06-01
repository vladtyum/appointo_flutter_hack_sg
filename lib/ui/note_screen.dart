import 'package:flutter/material.dart';
import '../model/appointo.dart';
import '../utils/database_helper.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';

class ApntoScreen extends StatefulWidget {
  final Apppointo apnt;
  ApntoScreen(this.apnt);

  @override
  State<StatefulWidget> createState() => new _ApntoScreenState();
}

class _ApntoScreenState extends State<ApntoScreen> {
  DatabaseHelper db = new DatabaseHelper();

  TextEditingController _nameController;
  TextEditingController __dateController;


  @override
  void initState() {
    super.initState();

    _nameController = new TextEditingController(text: widget.apnt.name);
    __dateController = new TextEditingController(text: widget.apnt.date);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('AppointO Detal'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Builder(
        builder: (context) => Container(
          margin: EdgeInsets.all(15.0),
//        alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              Padding(padding: new EdgeInsets.all(5.0)),
              Text(
                widget.apnt.name,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(padding: new EdgeInsets.all(5.0)),Padding(padding: new EdgeInsets.all(10.0)),
              Text(
                "Date: 2018-Jul-01",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              Padding(padding: new EdgeInsets.all(10.0)),
              Text(
                "Link: https://appoitno.bla/${widget.apnt.date}",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),

              Padding(padding: new EdgeInsets.all(5.0)),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 0, right: 0.0),
                      child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.deepOrange,
                          child: Icon(Icons.link),
                          onPressed: (){
                            final snackBar = SnackBar(
                              content: Text('Link to event has been copied to your clipboard'),
                              action: SnackBarAction(
                                label: 'Home',
                                onPressed: () {
                                  // Some code to undo the change!
                                },
                              ),
                            );
                            // Find the Scaffold in the Widget tree and use it to show a SnackBar!
                            Scaffold.of(context).showSnackBar(snackBar);
                            SystemChannels.platform.invokeMethod<void>(
                              'Clipboard.setData',
                              <String, dynamic>{
                                "text": "http://127.0.0.1:5000/invtn/${widget.apnt.name}",
                              },
                            );
                          },
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0, right: 0.0),
                      child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.black87,
                          child: Icon(Icons.share),
                          onPressed: () {
                            Share.share('check out my website https://example.com');
                          },
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0, right: 0.0),
                      child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.red[800],
                          child: Icon(Icons.delete_forever),
                          onPressed: () {},
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))),
                    ),

                  ],
                ),
              ),


//            RaisedButton(
//              child: (widget.apnt.id != null) ? Text('Update') : Text('Add'),
//              onPressed: () {
//                if (widget.apnt.id != null) {
//                  db.updateApnt(Apppointo.fromMap({
//                    'id': widget.apnt.id,
//                    'name': _nameController.text,
//                    'date': __dateController.text
//                  })).then((_) {
//                    Navigator.pop(context, 'update');
//                  });
//                }else {
//                  db.saveApnt(Apppointo(_nameController.text, __dateController.text)).then((_) {
//                    Navigator.pop(context, 'save');
//                  });
//                }
//              },
//            ),
            ],
          ),
        ),
      ),
    );
  }
}
