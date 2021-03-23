import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:js' as js;
import 'package:timelines/timelines.dart';

class Projects extends StatelessWidget {
  List<Widget> getProjectList() {
    List<Widget> projects = new List();
    projects.add(getProjectCard(
      title: 'Mini Project in Windows System',
      description:
          'Knowledge of the C# language: organising a code based on the O.O paradigm, Generics templates, LINQ syntax. MS.NET infrastructure overview and their use in developing distributed information systems in a service oriented approach. '
          ' Understanding the principles of planning and design templates that are relevant to the development of modern information systems, code division based on areas of responsibility in a layered structure and designing a layered display based on MVC/ MVP.',
      githubUrl: 'https://github.com/ephammer/MP_csharp',
      type: 'COLLEGE',
    ));

    projects.add(getProjectCard(
      title: 'Workshop in JAVA — Team of 2 ',
      description:
          'An intensive project designed to train developers for applications running on the Android operating system, and the development of a server side at the basic level only, using the server side scripting language: PHP',
      githubUrl: 'https://github.com/ephammer/android_java_project_3_year',
      type: 'COLLEGE',
    ));

    projects.add(getProjectCard(
        title: 'Mini Project in Software Engineering',
        description:
            'During this project, we practiced the main responsibility of a software engineer - to create a coherent and well- designed software architecture toward the implementation of a large project. This responsibility require knowledge in both software and problem domains. We practiced the art of learning a new discipline, to extract an abstract model of the problem and to design an ever-evolving solution that realises it. The project is based on designing and modelling a virtual 3-dimensional graphical scene, with all the physics involved (light source, rays, reflections, refractions, color, occlusions etc.).',
        githubUrl: 'https://github.com/ephammer/MP_intro_sotware_engineering',
        type: 'COLLEGE'));

    projects.add(getProjectCard(
      title: 'BEDSHEMA Android Application',
      description:
          'Bed Shema is an app that contains the principal jewish prayers that differ from the regular Ashkenazic Tradition according to the Vilna Gaon Tradition.',
      githubUrl: 'https://github.com/ephammer/BedShema',
    ));

    projects.add(getProjectCard(
      title: 'Bumblebee Android Application',
      description:
          'Android spelling-bee game that makes use of Google’s TTS engine to speak the words and Firebase to save the users game and ranking.',
      githubUrl: 'https://github.com/ephammer/BumbleBee',
    ));

    projects.add(getProjectCard(
        title: 'Night Shema Reminder Android Application',
        description:
            'Android application that makes use of the users geolocation and an external library to calculate the time of nightfall according to jewish law and send a reminder to the user.',
        githubUrl: 'https://github.com/ephammer/MP_intro_sotware_engineering',
        type: 'PERSONAL '));
    projects.add(getProjectCard(
        title: 'Highlights Android Application ',
        description:
            'Android application that allows users to upload Kindle book highlights and browse/share them. This app is published in the Google Play Store.',
        // githubUrl: 'https://github.com/ephammer/MP_intro_sotware_engineering',
        playstoreUrl:
            'https://play.google.com/store/apps/details?id=me.ephrai.highlights',
        type: 'PERSONAL '));
    projects.add(getProjectCard(
        title: 'KosherScan',
        description:
            'KosherScan allows you to scan a product barcode and ask your Rabbi if it\'s kosher. This app is published in the Google Play Store.',
        // githubUrl: 'https://github.com/ephammer/MP_intro_sotware_engineering',
        playstoreUrl: 'https://kosherscan.app',
        type: 'PERSONAL '));
    // projects.reversed.toList();
    return projects.toList();
  }

  Widget getProjectCard({
    String title,
    String description,
    String githubUrl,
    String playstoreUrl,
    String type,
  }) {
    return TimelineTile(
      nodeAlign: TimelineNodeAlign.start,
      oppositeContents: type != null && type != ''
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(type),
            )
          : Container(),
      contents: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: ExpansionTile(
            title: Text(title),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(description),
              ),
            ],
            // isThreeLine: true,
            trailing: IconButton(
              icon: githubUrl != null
                  ? Image.asset(
                      'images/GitHub-Mark/PNG/GitHub-Mark-120px-plus.png',
                      height: 16,
                      width: 16,
                    )
                  : Icon(
                      Icons.link,
                      color: Colors.black,
                    ),
              onPressed: () {
                if (githubUrl != null)
                  js.context.callMethod("open", [githubUrl]);
                else if (playstoreUrl != null)
                  js.context.callMethod("open", [playstoreUrl]);
              },
            ),
          ),
        ),
      ),
      node: TimelineNode(
        indicator: DotIndicator(
          // child: type != null && type != '' ? Text(type) : null,
          color: type != null && type == 'COLLEGE' ? Colors.green : null,
        ),
        startConnector: SolidLineConnector(
          color: type != null && type == 'COLLEGE' ? Colors.green : null,
        ),
        endConnector: SolidLineConnector(
          color: type != null && type == 'COLLEGE' ? Colors.green : null,
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
