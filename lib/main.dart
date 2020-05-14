import 'dart:html';

import 'package:flutter/material.dart';
import 'package:portofolio_page/projects.dart';
import 'package:portofolio_page/tools/adaptive.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:js' as js;
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const _primaryColor = Colors.white;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ephraim Hammer',
      theme: ThemeData(
        primaryColor: _primaryColor,
        highlightColor: Colors.transparent,
        colorScheme: ColorScheme(
          primary: _primaryColor,
          primaryVariant: const Color(0xFF3700B3),
          secondary: Colors.black,
          secondaryVariant: const Color(0xFF018786),
          background: Colors.white,
          surface: Colors.white,
          onBackground: Colors.black,
          error: const Color(0xFFB00020),
          onError: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Colors.black,
          brightness: Brightness.light,
        ),
      ),
      home: MyHomePage(title: 'Ephraim Hammer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _getTitleWidget(String title, bool isDesktop, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: (isDesktop) ? (MediaQuery.of(context).size.width) / 4 : 4.0,
          bottom: 16.0,
          top: 16.0),
      child: Text(
        title,
        style: GoogleFonts.raleway(fontWeight: FontWeight.bold, fontSize: 34),
      ),
    );
  }

  Widget _nameWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                style: GoogleFonts.raleway(
                    fontSize: 30,color: Theme.of(context).colorScheme.secondary),
                children: [
                  TextSpan(text: "Hi, ",style: GoogleFonts.pacifico()),
                  TextSpan(text: "I am")
                ]
              ),
            ),
            Text(
              "Ephraim Hammer",
              style: GoogleFonts.raleway(
                  fontWeight: FontWeight.bold, fontSize: 34),
            ),
            ButtonBar(
              mainAxisSize: MainAxisSize.min,
              children: [
                FlatButton.icon(
                    onPressed: () {
                      js.context
                          .callMethod("open", ["https://github.com/ephammer/"]);
                    },
                    icon: Image.asset(
                      'images/GitHub-Mark/PNG/GitHub-Mark-120px-plus.png',
                      height: 16,
                      width: 16,
                    ),
                    label: Text(
                      'GitHub',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    )),
                RaisedButton(
                  onPressed: () {
                    sendEmail();
                  },
                  child: Text("Contact Me"),
                  color: Colors.white,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _profilePicWidget(bool isDesktop) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: (isDesktop) ? 300 : 100,
          width: (isDesktop) ? 300 : 100,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new AssetImage('images/profilpic.png')))),
    );
  }

  void sendEmail() async {
    const url = 'mailto:<ephraim.hammer@gmail.com>';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  List<Widget> _bodyElements(bool isDesktop) {
    List<Widget> pageElements = [];

    pageElements.add((isDesktop)
        ? Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Row(
                children: [
                  Expanded(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: _nameWidget(context))),
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: _profilePicWidget(isDesktop)),
                  ),
                ],
              ),
            ),
          )
        : Column(
            children: [
              Center(
                child: _profilePicWidget(isDesktop),
              ),
              _nameWidget(context),
            ],
          ));

    // Add Projects
    pageElements.add(_getTitleWidget("Projects", isDesktop, context));
    for (var project in Projects().getProjectList()) {
      pageElements.add(Container(
          padding: (isDesktop)
              ? EdgeInsets.symmetric(
                  horizontal: (MediaQuery.of(context).size.width) / 4)
              : null,
          child: project));
    }

    pageElements.add(_getTitleWidget("Contact", isDesktop, context));

    pageElements.add(Container(
        padding: (isDesktop)
            ? EdgeInsets.symmetric(
                horizontal: (MediaQuery.of(context).size.width) / 4)
            : null,
        child: ButtonBar(
          alignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            FlatButton(
              onPressed: () {
                sendEmail();
              },
              child: Text("Email",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary)),
            ),
            FlatButton.icon(
                onPressed: () {
                  js.context
                      .callMethod("open", ["https://github.com/ephammer/"]);
                },
                icon: Image.asset(
                  'images/GitHub-Mark/PNG/GitHub-Mark-120px-plus.png',
                  height: 16,
                  width: 16,
                ),
                label: Text(
                  'GitHub',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                )),
          ],
        )));

    pageElements.add(Center(
        child: Text(
      "by Ephraim Hammer",
      style: TextStyle(fontSize: 10, color: Colors.black38),
    )));

    return pageElements;
  }

  Widget _body(bool isDesktop, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: _bodyElements(isDesktop),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          widget.title,
          style: GoogleFonts.raleway(),
        ),
        elevation: 1,
//        actions: [
//          FlatButton(
//            onPressed: () {},
//            child: Text("Home"),
//          ),
//          FlatButton(
//            onPressed: () {},
//            child: Text("About"),
//          ),
//          FlatButton(
//            onPressed: () {},
//            child: Text("Projects"),
//          ),
//        ],
      ),
      body: _body(isDesktop, context),
//      Container(
//        decoration: BoxDecoration(
//          image: DecorationImage(
//            image: AssetImage("images/blueprint.jpg"),
//            fit: BoxFit.cover,
//          ),
//        ),
//        child: Center(
//          // Center is a layout widget. It takes a single child and positions it
//          // in the middle of the parent.
//          child: ListView(
//            // Column is also a layout widget. It takes a list of children and
//            // arranges them vertically. By default, it sizes itself to fit its
//            // children horizontally, and tries to be as tall as its parent.
//            //
//            // Invoke "debug painting" (press "p" in the console, choose the
//            // "Toggle Debug Paint" action from the Flutter Inspector in Android
//            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//            // to see the wireframe for each widget.
//            //
//            // Column has various properties to control how it sizes itself and
//            // how it positions its children. Here we use mainAxisAlignment to
//            // center the children vertically; the main axis here is the vertical
//            // axis because Columns are vertical (the cross axis would be
//            // horizontal).
//            children: <Widget>[
//              Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: Center(
//                  child: Container(
//                      height: 150,
//                      width: 150,
//                      decoration: new BoxDecoration(
//                          shape: BoxShape.circle,
//                          image: new DecorationImage(
//                              fit: BoxFit.cover,
//                              image: new AssetImage('images/profilpic.png')))),
//                ),
//              ),
//              Center(
//                child: Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Text(
//                    'Ephraim Hammer',
//                    textAlign: TextAlign.center,
//                    style: TextStyle(
//                      fontFamily: 'Gilberto',
//                      fontSize: 65,
//                      fontWeight: FontWeight.bold,
//                    ),
//                  ),
//                ),
//              ),
//              Center(
//                child: Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Text(
//                      'I design and code beautifully simple things, and I love what I do.'),
//                ),
//              ),
//              SizedBox(
//                height: 50,
//              ),
//              Row(
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Center(
//                      child: FlatButton.icon(
//                        icon: Image.asset(
//                          'images/projects.png',
//                          height: 32,
//                        ),
//                        onPressed: () {
//                          Navigator.push(context,
//                              MaterialPageRoute(builder: (context) => Projects()));
//                        },
////                color: Colors.white,
//                        label: Text(
//                          'Projects',
//                          style: TextStyle(
//                            fontWeight: FontWeight.bold,
//                          ),
//                        ),
//                      ),
//                    ),
//                    Center(
//                      child: FlatButton.icon(
//                        icon: Image.asset(
//                          'images/GitHub-Mark/PNG/GitHub-Mark-Light-32px.png',
//                          height: 32,
//                        ),
//                        onPressed: () {
//                          Navigator.push(context,
//                              MaterialPageRoute(builder: (context) => Projects()));
//                        },
////                color: Colors.white,
//                        label: Text(
//                          'GitHub',
//                          style: TextStyle(
//                            fontWeight: FontWeight.bold,
//                          ),
//                        ),
//                      ),
//                    ),
//                    Center(
//                      child: FlatButton.icon(
//                        icon: Image.asset(
//                          'images/cv.png',
//                          height: 32,
//                        ),
//                        onPressed: () {
//                          Navigator.push(context,
//                              MaterialPageRoute(builder: (context) => Projects()));
//                        },
////                color: Colors.white,
//                        label: Text(
//                          'Resume',
//                          style: TextStyle(
//                            fontWeight: FontWeight.bold,
//                          ),
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//            ],
//          ),
//        ),
//      ),
    );
  }
}
