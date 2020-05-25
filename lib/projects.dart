import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:js' as js;

class Projects extends StatelessWidget {
  List<Widget> getProjectList() {
    List<Widget> projects = new List();
    projects.add(getProjectCard(
        'MINI PROJECT IN WINDOWS SYSTEM — COLLEGE',
        'Knowledge of the C# language: organising a code based on the O.O paradigm, Generics templates, LINQ syntax. MS.NET infrastructure overview and their use in developing distributed information systems in a service oriented approach.  '
            ' Understanding the principles of planning and design templates that are relevant to the development of modern information systems, code division based on areas of responsibility in a layered structure and designing a layered display based on MVC/ MVP.',
        'https://github.com/ephammer/MP_csharp'));

    projects.add(getProjectCard(
        'WORKSHOP IN JAVA — TEAM OF 2 — COLLEGE',
        'An intensive project designed to train developers for applications running on the Android operating system, and the development of a server side at the basic level only, using the server side scripting language: PHP',
        'https://github.com/ephammer/android_java_project_3_year'));

    projects.add(getProjectCard(
        'MINI PROJECT IN SOFTWARE ENGINEERING — COLLEGE',
        'During this project, we practiced the main responsibility of a software engineer - to create a coherent and well- designed software architecture toward the implementation of a large project. This responsibility require knowledge in both software and problem domains. We practiced the art of learning a new discipline, to extract an abstract model of the problem and to design an ever-evolving solution that realises it. The project is based on designing and modelling a virtual 3-dimensional graphical scene, with all the physics involved (light source, rays, reflections, refractions, color, occlusions etc.).',
        'https://github.com/ephammer/MP_intro_sotware_engineering'));

    projects.add(getProjectCard(
        'BEDSHEMA ANDROID APPLICATION — PERSONAL',
        'Bed Shema is an app that contains the principal jewish prayers that differ from the regular Ashkenazic Tradition according to the Vilna Gaon Tradition. This app is published in the Google Play Store .',
        'https://github.com/ephammer/BedShema'));

    projects.add(getProjectCard(
        'BUMBLEBEE ANDROID APPLICATION — PERSONAL',
        'Android spelling-bee game that makes use of Google’s TTS engine to speak the words and Firebase to save the users game and ranking.',
        'https://github.com/ephammer/BumbleBee'));

    projects.add(getProjectCard(
        'NIGHT SHEMA REMINDER ANDROID APPLICATION — PERSONAL',
        'Android application that makes use of the users geolocation and an external library to calculate the time of nightfall according to jewish law and send a reminder to the user. This app is published in the Google Play Store.',
        'https://github.com/ephammer/MP_intro_sotware_engineering'));
    projects.reversed.toList();
    return projects.reversed.toList();
  }

  Widget getProjectCard(String title, String description, String githubUrl,
      [String playStoreUrl]) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold, height: 5, fontSize: 10),
            ),
            Text(description),
            FlatButton.icon(
                onPressed: () {
                  js.context.callMethod("open", [githubUrl]);
                },
                icon: Image.asset(
                  'images/GitHub-Mark/PNG/GitHub-Mark-120px-plus.png',
                  height: 16,
                  width: 16,
                ),
                label: Text('GitHub Link')),
          ],
        ),
      ),
    );
  }

  Widget getProjectsListView() {
    return Center(
        child: SizedBox(
      width: 450,
      child: ListView.builder(
          itemCount: getProjectList().length,
          itemBuilder: (BuildContext context, int index) {
            return getProjectList()[index];
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(brightness: Brightness.light),
        child: Scaffold(
          appBar: AppBar(
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
            title: Center(
                child: Text('Projects', style: TextStyle(color: Colors.black))),
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
//            brightness: Brightness.light,
            iconTheme: IconThemeData(color: Colors.black),
//            toolbarOpacity: 0.0,
            bottomOpacity: 0,
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/blueprint.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: getProjectsListView(),
          ),
        ));
  }
}
