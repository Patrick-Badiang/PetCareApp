import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pet_care_app/appointmentpage.dart';

import 'package:pet_care_app/homepage.dart';
import 'package:pet_care_app/models/caringModel.dart';
import 'package:pet_care_app/topWidget.dart';
import 'package:pet_care_app/utils/dialog_box.dart';

void main() async {
  //init hive
  await Hive.initFlutter();

  //open a box
  var box = await Hive.openBox('mybox');
  var appointments = await Hive.openBox('appointments');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffE5E5E5),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Colors.amber,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.calendar_month),
              icon: Icon(Icons.calendar_month),
              label: 'Appointments',
            ),
            NavigationDestination(
              icon: Badge(child: Icon(Icons.list_alt_outlined)),
              label: 'Caring for pet',
            ),
            NavigationDestination(
              icon: Badge(
                label: Text('2'),
                child: Icon(Icons.phone_callback),
              ),
              label: 'Call Vet',
            ),
          ],
        ),
        body: [
          HomePage(),
          Appointments(),
          CaringPage(),
          HomePage(),
        ][currentPageIndex]);
  }
}

class CaringPage extends StatefulWidget {
  const CaringPage({super.key});

  @override
  State<CaringPage> createState() => _CaringPageState();
}

class _CaringPageState extends State<CaringPage> {
  List vet = ["Hello", "There"];

  List likes = [
    "Playing \"Seach\"",
    "The kibble toppers as treats",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const TopWidget(subText: "", title: "Things to Know: "),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text("For the vet I need: "),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20),
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemCount: vet.length,
            itemBuilder: (context, index) {
              return CaringModel(
                name: "Hello",
                bgcolor: Color(0xffCA7676),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text("I like:"),
        ),
        Expanded(
            child: ListView.separated(
          padding: EdgeInsets.only(top: 20),
          separatorBuilder: (context, index) => SizedBox(height: 10),
          itemCount: likes.length,
          itemBuilder: (context, index) {
            return Container(
              height: 30,
              color: Color(0xffCAA376),
            );
          },
        )),
      ],
    ));
  }
}
