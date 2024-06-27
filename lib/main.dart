import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:pet_care_app/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  String homeSubText = "My name is:";
  String homeTitle = "Kuber Badiang";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: const <Widget>[
          Column(
            children: <Widget>[
              TopWidget(subText: "My name is:", title: "Kuber Badiang"),
              HomePage(),
            ],
          ),
          Column(
            children: <Widget>[
              TopWidget(subText: "These are", title: "My Appointments"),
              Appointments()
            ],
          ),
          Column(
            children: <Widget>[
              TopWidget(subText: "", title: "Things to Know"),
            ],
          ),
          Text("Call Vet Page"),
        ][currentPageIndex]);
  }
}

class TopWidget extends StatelessWidget {
  final String subText;
  final String title;
  const TopWidget({required this.subText, required this.title, super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 95, 196, 98),
      child: Column(
        children: [
          const PrintandCircle(),
          Text(
            style: const TextStyle(
              fontSize: 30,
            ),
            textAlign: TextAlign.center,
            subText,
          ),
          Text(
            style: const TextStyle(
              fontSize: 40,
            ),
            textAlign: TextAlign.center,
            title,
          ),
        ],
      ),
    );
  }
}

class PrintandCircle extends StatelessWidget {
  const PrintandCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Flexible(
          flex: 1,
          child: SizedBox(
            height: 250,
            width: 200,
            child: PawPrint(),
          ),
        ),
        Flexible(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(left: 8.0, top: 50.0),
            child: CircleAvatar(
              radius: 80,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("assets/images/Pet.png"),
            ),
          ),
        )
      ],
    );
  }
}

class PawPrint extends StatelessWidget {
  const PawPrint({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: const BoxDecoration(
            color: Colors.brown,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(500),
            ),
          ),
        ),
        Positioned(
          top: 150,
          left: 20,
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
                color: Colors.brown, shape: BoxShape.circle),
          ),
        ),
        Positioned(
          top: 110,
          left: 95,
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
                color: Colors.brown, shape: BoxShape.circle),
          ),
        ),
        Positioned(
          top: 50,
          left: 140,
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
                color: Colors.brown, shape: BoxShape.circle),
          ),
        ),
      ],
    );
  }
}

class Appointments extends StatelessWidget {
  const Appointments({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      child: Column(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: FlutterLogo(
                size: 56.0,
              ),
              title: Text(
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  'Rabbies Shot TBD'),
            ),
          ),
          Card(
            child: ListTile(
              leading: FlutterLogo(),
              title: Text('Nail Clippings'),
            ),
          ),
          Card(
            child: ListTile(
              leading: FlutterLogo(),
              title: Opacity(
                opacity: 0.6,
                child: Text('Add an Appointment'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
