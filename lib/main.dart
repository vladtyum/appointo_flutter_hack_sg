import 'dart:async';
import 'package:flutter/material.dart';
import 'ui/listview_note.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';



//void main() => runApp(
//  MaterialApp(
//    title: 'ApprointO main() title',
//    home: AppointoMainPage(),
//  ),
//);


void main() => runApp(App());

/// App widget class

class App extends StatelessWidget {
  //making list of pages needed to pass in IntroViewsFlutter constructor.
  final pages = [
    PageViewModel(
        pageColor: Colors.teal,
        body: Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    "Want to make an appointment with a friend? ",
                      style: new TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    )

                  ),
                  margin: const EdgeInsets.only(top:15.0),
                )
              ],
            )
        ),
        title: Container(
            margin: const EdgeInsets.only(top: 30.0),
            child: Image.asset(
              'assets/agromelogoputih.png',
            )
        ),
        textStyle: TextStyle(
            fontFamily: 'MyFont', color: Colors.white,
            fontSize: 13.0
        ),


        mainImage: Container(
            child:Image.asset(
              'assets/calendar.jpg',
              height: 100.0,
              width: 285.0,
              alignment: Alignment.center,
            )
        )



    ),
    PageViewModel(
        pageColor: Colors.green,
        body: Container(
            child: Column(
              children: <Widget>[
                Text("Don't want to husslte through sending ✉️  with ics ?",
                    style: new TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    )
                ),
              ],
            )
        ),
        title: Container(
            margin: const EdgeInsets.only(top: 30.0),
            child: Image.asset(
              'assets/agromelogoputih.png',
            )
        ),
        textStyle: TextStyle(
            fontFamily: 'MyFont', color: Colors.white,
            fontSize: 13.0
        ),


        mainImage: Container(
            child:Image.asset(
              'assets/allemail.jpg',
              height: 100.0,
              width: 285.0,
              alignment: Alignment.center,
            )
        )



    ),
    PageViewModel(
        pageColor: Colors.blue,
        body: Container(
            child: Column(
              children: <Widget>[
                Text("Pick Name and Date in app, get the link 🌐. Send it to your friend over any messangeer",
                    style: new TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    )
                ),
              ],
            )
        ),
        title: Container(
            margin: const EdgeInsets.only(top: 30.0),
            child: Image.asset(
              'assets/apalm_phone.png',
            )
        ),
        textStyle: TextStyle(
            fontFamily: 'MyFont', color: Colors.white,
            fontSize: 13.0
        ),


        mainImage: Container(
            child:Image.asset(
              'assets/palm_phone.png',
              height: 100.0,
              width: 285.0,
              alignment: Alignment.center,
            )
        )



    ),
    PageViewModel(
        pageColor: Colors.deepPurpleAccent,
        body: Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    "Friend clicks on the link 🌐, it goes to his calendar. Simple is that 🎉",
                    style: new TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                  margin: const EdgeInsets.only(top:15.0),
                )
              ],
            )
        ),
        title: Container(
            margin: const EdgeInsets.only(top: 30.0),
            child: Image.asset(
              'assets/agromelogoputih.png',
            )
        ),
        textStyle: TextStyle(
            fontFamily: 'MyFont', color: Colors.white,
            fontSize: 13.0
        ),


        mainImage: Container(
            child:Image.asset(
              'assets/phone_cal3.png',
              height: 100.0,
              width: 285.0,
              alignment: Alignment.center,
            )
        )



    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IntroViews Flutter', //title of app

      theme: ThemeData(
          primarySwatch: Colors.blue,
          inputDecorationTheme: InputDecorationTheme(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)
              )
          )
      ), //ThemeData
      home: Builder(
        builder: (context) => IntroViewsFlutter(
          pages,
          doneText: Text("GET STARTED"),
          onTapDoneButton: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MaterialApp(
    title: 'ApprointO main() title',
    home: AppointoMainPage(),
  ),
              ), //MaterialPageRoute
            );
          },
          pageButtonTextStyles: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ), //IntroViewsFlutter
      ), //Builder
    ); //Material App
  }
}

