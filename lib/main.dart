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
        textTheme: GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme)
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
//          left: (isDesktop) ? (MediaQuery.of(context).size.width) / 4 : 4.0,
          bottom: 16.0,
          top: 16.0),
      child: Text(
        title,
        style: GoogleFonts.raleway(fontWeight: FontWeight.bold, fontSize: 34),
        textAlign: TextAlign.start,
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
                      fontSize: 30,
                      color: Theme.of(context).colorScheme.secondary),
                  children: [
                    TextSpan(text: "Hi, ", style: GoogleFonts.pacifico()),
                    TextSpan(text: "I am")
                  ]),
            ),
            Text(
              "Ephraim Hammer",
              textAlign: TextAlign.center,
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
                  image: new AssetImage('images/profilpic_transparent.png')))),
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

  List<Widget> _bodyPageElements(bool isDesktop) {
    List<Widget> pageElements = [];

    pageElements.add(Column(
          children: [
            Expanded(
              child: Container(
//            padding: EdgeInsets.symmetric(
//                horizontal: (MediaQuery.of(context).size.width) / 8),
                  height: MediaQuery.of(context).size.height-100,
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
                ),
            ),
            Align(
                alignment:Alignment.bottomCenter,child: BlinkingArrowAnimation()),
          ],
        )
    );

    // Add Projects
    pageElements.add(
        Column(
          children: [
            _getTitleWidget("Projects", isDesktop, context),
            Expanded(
              child: Container(
                  padding:EdgeInsets.symmetric(
                      horizontal: (MediaQuery.of(context).size.width) / 4),
                  child: ListView(children: Projects().getProjectList(),)),),
            Align(
                alignment:Alignment.bottomCenter,child: BlinkingArrowAnimation()),
          ],
        )
    );
//    for (var project in Projects().getProjectList()) {
//      pageElements.add(Container(
//          padding: (isDesktop)
//              ? EdgeInsets.symmetric(
//                  horizontal: (MediaQuery.of(context).size.width) / 4)
//              : null,
//          child: project));
//    }

    pageElements.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _getTitleWidget("Contact", isDesktop, context),
        Container(
            padding: EdgeInsets.symmetric(
                horizontal: (MediaQuery.of(context).size.width) / 4),
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
            )),
            Center(
                child: Text(
                  "by Ephraim Hammer",
                  style: TextStyle(fontSize: 10, color: Colors.black38),
                ))
          ],
        )
    );

    return pageElements;
  }

  List<Widget> _bodyElements(bool isDesktop) {
    List<Widget> pageElements = [];

    pageElements.add(Column(
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
      pageElements.add(project);
    }

    pageElements.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _getTitleWidget("Contact", isDesktop, context),
            ButtonBar(
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
            ),
            Center(
                child: Text(
                  "by Ephraim Hammer",
                  style: TextStyle(fontSize: 10, color: Colors.black38),
                ))
          ],
        )
    );

    return pageElements;
  }


  Widget _body(bool isDesktop, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: _bodyElements(isDesktop),
      ),
    );
  }

  Widget _bodyPage(bool isDesktop, BuildContext context){
    
    return PageView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
        itemCount: _bodyPageElements(isDesktop).length,
        itemBuilder: (BuildContext context, int itemIndex) {
          return _bodyPageElements(isDesktop)[itemIndex];
        },
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
        actions: [
          Center(child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("בס״ד",textAlign: TextAlign.center,style: GoogleFonts.rubik(),),
          )),
        ],
      ),
      body: (isDesktop)? _bodyPage(isDesktop, context):_body(isDesktop, context),
    );
  }
}

class BlinkingArrowAnimation extends StatefulWidget {
  @override
  _BlinkingAnimationState createState() => _BlinkingAnimationState();
}

class _BlinkingAnimationState extends State<BlinkingArrowAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
    new AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Icon(Icons.keyboard_arrow_down)
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}