import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:pet_care_app/homepage.dart';
import 'package:pet_care_app/topWidget.dart';
import 'package:pet_care_app/utils/dialog_box.dart';

void main() {
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

  //Text controller
  final _controller = TextEditingController();

  int currentPageIndex = 0;

  void _addTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(controller: _controller,);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.small(
          shape: CircleBorder(),
          backgroundColor: Colors.green,
          onPressed: () {
            _addTask();
          },
          child: Icon(Icons.add),
        ),
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
          HomePage(),
          HomePage(),
          HomePage(),

          // const Column(
          //   children: <Widget>[
          //     TopWidget(subText: "These are", title: "My Appointments"),
          //     Appointments()
          //   ],
          // ),
          // const Column(
          //   children: <Widget>[
          //     TopWidget(subText: "", title: "Things to Know"),
          //   ],
          // ),
          // const Text("Call Vet Page"),
        ][currentPageIndex]);
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
