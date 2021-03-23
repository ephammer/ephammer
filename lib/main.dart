import 'dart:html';

import 'package:flutter/material.dart';
import 'package:portofolio_page/projects.dart';
import 'package:portofolio_page/tools/adaptive.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portofolio_page/tools/utils.dart';
import 'dart:js' as js;
import 'package:url_launcher/url_launcher.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:delayed_display/delayed_display.dart';

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
          textTheme: GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme)),
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
  PageController _pageController;
  final Duration initialDelay = Duration(seconds: 1);

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
            DelayedDisplay(
              delay: initialDelay,
              child: RichText(
                text: TextSpan(
                    style: GoogleFonts.raleway(
                        fontSize: 30,
                        color: Theme.of(context).colorScheme.secondary),
                    children: [
                      TextSpan(text: "Hi, ", style: GoogleFonts.pacifico()),
                      TextSpan(text: "I am")
                    ]),
              ),
            ),
            DelayedDisplay(
              delay: Duration(seconds: initialDelay.inSeconds + 1),
              child: Text(
                "Ephraim Hammer",
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                    fontWeight: FontWeight.bold, fontSize: 34),
              ),
            ),
            DelayedDisplay(
              delay: Duration(seconds: initialDelay.inSeconds + 2),
              child: Container(
                height: 70,
                width: 240,
                child: RotateAnimatedTextKit(
                    repeatForever: true,
                    onTap: () {
                      print("Tap Event");
                    },
                    text: [
                      "Developer",
                      "Ultra-runner",
                      "Designer",
                      'Explorer',
                    ],
                    textStyle: GoogleFonts.raleway(
                      fontSize: 26,
                      // fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center),
              ),
            ),
            DelayedDisplay(
              delay: Duration(seconds: initialDelay.inSeconds + 3),
              child: ButtonBar(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FlatButton.icon(
                      onPressed: () {
                        js.context.callMethod(
                            "open", ["https://github.com/ephammer/"]);
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    onPressed: () {
                      sendEmail();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Contact Me"),
                    ),
                    color: Colors.blue,
                  )
                ],
              ),
            ),
            DelayedDisplay(
              delay: Duration(seconds: initialDelay.inSeconds + 4),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 200,
                  child: RaisedButton(
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    onPressed: () {
                      js.context.callMethod("open", ["https://kosherscan.app"]);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "My Latest Project",
                          style: TextStyle(color: Colors.white),
                        ),
//                      Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Icon(Icons.arrow_forward_ios,color: Colors.black45,),
//                      ),
                      ],
                    ),
//              color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profilePicWidget(bool isDesktop) {
    return DelayedDisplay(
      delay: Duration(
          seconds:
              isDesktop ? initialDelay.inSeconds + 5 : initialDelay.inSeconds),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
            height: (isDesktop) ? 300 : 100,
            width: (isDesktop) ? 300 : 100,
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.cover,
                    image:
                        new AssetImage('images/profilpic_transparent.png')))),
      ),
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

    // First Page
    pageElements.add(Column(
      children: [
        Expanded(
          child: Container(
//            padding: EdgeInsets.symmetric(
//                horizontal: (MediaQuery.of(context).size.width) / 8),
            height: MediaQuery.of(context).size.height - 100,
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
            alignment: Alignment.bottomCenter,
            child: IconButton(
                icon: BlinkingArrowAnimation(),
                onPressed: () {
                  _pageController.animateToPage(1,
                      curve: Curves.easeIn,
                      duration: Duration(milliseconds: 500));
                })),
      ],
    ));

    // Add Projects
    pageElements.add(Column(
      children: [
        Align(
            alignment: Alignment.topCenter,
            child: IconButton(
                icon: BlinkingArrowAnimation(
                  direction: 0,
                ),
                onPressed: () {
                  _pageController.animateToPage(0,
                      curve: Curves.easeIn,
                      duration: Duration(milliseconds: 500));
                })),
        _getTitleWidget("Projects", isDesktop, context),
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(
                horizontal: (MediaQuery.of(context).size.width) / 4),
            // child: ListView(
            //   children: Projects().getProjectList(),
            // ),
            child: LiveList(
              showItemInterval: Duration(milliseconds: 150),
              showItemDuration: Duration(milliseconds: 350),
              padding: EdgeInsets.all(0),
              reAnimateOnVisibility: true,
              scrollDirection: Axis.vertical,
              itemCount: Projects().getProjectList().length,
              itemBuilder: animationItemBuilder(
                (index) => Projects().getProjectList()[index],
                // padding: EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: IconButton(
                icon: BlinkingArrowAnimation(),
                onPressed: () {
                  _pageController.animateToPage(2,
                      curve: Curves.easeIn,
                      duration: Duration(milliseconds: 500));
                })),
      ],
    ));
//    for (var project in Projects().getProjectList()) {
//      pageElements.add(Container(
//          padding: (isDesktop)
//              ? EdgeInsets.symmetric(
//                  horizontal: (MediaQuery.of(context).size.width) / 4)
//              : null,
//          child: project));
//    }

    pageElements.add(Column(
      children: [
        Align(
            alignment: Alignment.topCenter,
            child: IconButton(
                icon: BlinkingArrowAnimation(
                  direction: 0,
                ),
                onPressed: () {
                  _pageController.animateToPage(1,
                      curve: Curves.easeIn,
                      duration: Duration(milliseconds: 500));
                })),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // _getTitleWidget("Contact", isDesktop, context),
              SizedBox(
                width: 250.0,
                child: TypewriterAnimatedTextKit(
                  // repeatForever: false,
                  // totalRepeatCount: 1,
                  speed: Duration(milliseconds: 240),
                  pause: Duration(milliseconds: 2000),
                  // onTap: () {
                  //   print("Tap Event");
                  // },
                  text: ['Contact'],
                  textStyle: TextStyle(fontSize: 30.0, fontFamily: "Agne"),
                  textAlign: TextAlign.center,
                ),
              ),
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
                                color:
                                    Theme.of(context).colorScheme.secondary)),
                      ),
                      FlatButton.icon(
                          onPressed: () {
                            js.context.callMethod(
                                "open", ["https://github.com/ephammer/"]);
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
                    ],
                  )),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "by Ephraim Hammer",
              style: TextStyle(fontSize: 10, color: Colors.black38),
            ),
          ),
        )
      ],
    ));

    return pageElements;
  }

  List<Widget> _bodyElements(bool isDesktop) {
    List<Widget> pageElements = [];

    pageElements.add(
      Column(
        children: [
          Center(
            child: _profilePicWidget(isDesktop),
          ),
          _nameWidget(context),
        ],
      ),
    );
    // Add Projects
    pageElements.add(_getTitleWidget("Projects", isDesktop, context));

    for (var project in Projects().getProjectList()) {
      pageElements.add(project);
    }

    pageElements.add(Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // _getTitleWidget("Contact", isDesktop, context),
        SizedBox(
          width: 250.0,
          child: TypewriterAnimatedTextKit(
            // repeatForever: false,
            // totalRepeatCount: 1,
            speed: Duration(milliseconds: 240),
            pause: Duration(milliseconds: 2000),
            // onTap: () {
            //   print("Tap Event");
            // },
            text: ['Contact'],
            textStyle: TextStyle(fontSize: 30.0, fontFamily: "Agne"),
            textAlign: TextAlign.center,
          ),
        ),
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
    ));

    return pageElements;
  }

  Widget _body(bool isDesktop, BuildContext context) {
    var list = _bodyElements(isDesktop);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: list,
      ),
      // child: LiveList(
      //   showItemInterval: Duration(milliseconds: 150),
      //   showItemDuration: Duration(milliseconds: 350),
      //   padding: EdgeInsets.all(0),
      //   reAnimateOnVisibility: true,
      //   scrollDirection: Axis.vertical,
      //   itemCount: list.length,
      //   itemBuilder: animationItemBuilder(
      //     (index) => list[index],
      //     // padding: EdgeInsets.symmetric(vertical: 8),
      //   ),
      // ),
    );
  }

  Widget _bodyPage(bool isDesktop, BuildContext context) {
    _pageController = PageController();
    return Row(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: _bodyPageElements(isDesktop).length,
            itemBuilder: (BuildContext context, int itemIndex) {
              return _bodyPageElements(isDesktop)[itemIndex];
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SmoothPageIndicator(
            axisDirection: Axis.vertical,
            controller: _pageController,
            count: _bodyPageElements(isDesktop).length,
            effect: WormEffect(
              activeDotColor: Colors.red[800],
              radius: 8,
              dotHeight: 8,
              dotWidth: 8,
            ),
            onDotClicked: (index) {
              _pageController.jumpToPage(index);
            },
          ),
        ),
      ],
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
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "בס״ד",
                textAlign: TextAlign.center,
                style: GoogleFonts.rubik(),
              ),
            ),
          ),
        ],
      ),
      body: (isDesktop)
          ? _bodyPage(isDesktop, context)
          : _body(isDesktop, context),
    );
  }
}

class BlinkingArrowAnimation extends StatefulWidget {
  final int ARROW_UP = 0;
  final int ARROW_DOWN = 1;
  bool arrowUp;

  BlinkingArrowAnimation({int direction = 1}) {
    switch (direction) {
      case 0:
        arrowUp = true;
        break;
      case 1:
        arrowUp = false;
        break;
    }
  }

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
        child: Icon((widget.arrowUp)
            ? Icons.keyboard_arrow_up
            : Icons.keyboard_arrow_down));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
