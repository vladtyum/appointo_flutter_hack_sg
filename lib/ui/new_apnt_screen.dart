import 'package:flutter/material.dart';
import '../model/appointo.dart';
import '../utils/database_helper.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import "dart:convert";


class NewApntoScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _NewApntoScreenState();
}

class _AppointmentData {
  String invtn_name = 'New Invite';
  DateTime invtn_time = DateTime.now();
}

class _NewApntoScreenState extends State<NewApntoScreen> {

  DatabaseHelper db = new DatabaseHelper();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  _AppointmentData _data = new _AppointmentData();

  @override
  void initState() {
    super.initState();

  }


  String _validateInvtnName(String value) {
    if(value== null){
      return 'insert name for invitation';
    }
    if(value.length < 4){
      return 'Invitation name should be at least 4 charachters long.';
    }
    return null;
  }


  String dateHuman(DateTime date){
    String dateSlug = "${date.year.toString()}-${date.month.toString().padLeft(2,'0')}-${date.day.toString().padLeft(2,'0')}";
    String timeSlug = "${date.hour.toString().padLeft(2,'0')}:${date.minute.toString().padLeft(2,'0')}";
    return "$dateSlug  at  $timeSlug";
  }

  String date_iso(DateTime date){
    String dateSlug = "${date.year.toString()}-${date.month.toString().padLeft(2,'0')}-${date.day.toString().padLeft(2,'0')}";
    String timeSlug = "T${date.hour.toString().padLeft(2,'0')}:${date.minute.toString().padLeft(2,'0')}";
    // print("$dateSlug$timeSlug +08:00");
    return "$dateSlug$timeSlug";
  }


  void submit() async {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.
      print('Printing Invtn info.');
      print('M_NAME: ${_data.invtn_name}');
      print('M_TIME: ${_data.invtn_time}');

//      Future <Apppointo> newApnt
      Future<String> postJson() async {
        // String apiUrl = 'https://jsonplaceholder.typicode.com/posts';
        String apiUrl = 'http://127.0.0.1:5000/create_invtn';
        Map invtn_data = {
          'm_name': '${_data.invtn_name}',
          'm_time': '${date_iso(_data.invtn_time)}'};
        String payload = JsonEncoder.withIndent("    ").convert(invtn_data);
        print("Payload>>$payload");
        http.Response response = await http.post(
            apiUrl,body:payload,headers: {'Content-type': 'application/json; charset=utf-8'});
        print("response.body");
        return response.body;
      }

      String answer = await postJson();
      Map invId = jsonDecode(answer);

//      Apppointo newApnt = Apppointo(_data.invtn_name, _data.invtn_time.toIso8601String());
      Apppointo newApnt = Apppointo(_data.invtn_name, invId['inv_id']);
      print(newApnt.date);

      int savedApnt = await db.saveApnt(newApnt);
      print(savedApnt);


    }
  }




  @override
  Widget build(BuildContext context) {
    print('${dateHuman(this._data.invtn_time)}');
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: Text('New AppointO'),
          backgroundColor: Colors.deepPurple,
      ),

      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Form(
          key:this._formKey,
          child: new ListView(
            children: <Widget>[
              // Invitation Name
              new TextFormField(
                decoration: new InputDecoration(
                    hintText: 'Sarah and James coffee',
                    labelText: 'Invitation name'
                ),
                validator: this._validateInvtnName,
                onSaved: (String value){
                  this._data.invtn_name = value;
                },
              ),
              // DateTime picker
              new FlatButton(
                  onPressed: () {
                    DatePicker.showDateTimePicker(context, showTitleActions: true,
                        onChanged: (value) {
                          setState(() {
                            this._data.invtn_time = value;
                          });
                        },
                        onConfirm: (value) {
                          setState(() {
                            this._data.invtn_time = value;
                          });
                        },
                        currentTime: DateTime.now());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Date and Time",
                        textScaleFactor: 1.1,
                        // textAlign: TextAlign.left
                      ),
                      Text(
                        '${dateHuman(this._data.invtn_time)}',
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
              ),
              //Submit Button
              new Container(
                width: screenSize.width,
                child: new RaisedButton(
                  child: new Text(
                    'Get Link',
                    style: new TextStyle(
                        color: Colors.white
                    ),
                  ),
                  color: Colors.deepOrange,
                  onPressed: this.submit,
                ),
                margin: new EdgeInsets.only(
                    top: 20.0
                ),
              ),
            ], // endOf Widgets

          )
        ),
      ),

    );
  }
}
