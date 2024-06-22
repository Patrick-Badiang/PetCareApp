import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

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
            selectedIcon: Icon(Icons.calendar_month),
            icon: Icon(Icons.home_outlined),
            label: 'Appointments',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.list_alt_outlined)),
            label: 'Taking Care of Pet',
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
      body: const Column(
        children: <Widget>[
          TopWidget(),
          Expanded(
            child: CenterWidget(),
          )
        ],
      ),
    );
  }
}

class TopWidget extends StatelessWidget {
  const TopWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: const Column(
        children: [
          PrintandCircle(),
          Text(
            style: TextStyle(
              fontSize: 30,
            ),
            textAlign: TextAlign.center,
            "My name is:",
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 15.0),
            child: Text(
              style: TextStyle(
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
              "Kuber Badiang",
            ),
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
        SizedBox(
          height: 250,
          width: 200,
          child: PawPrint(),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.0, top: 50.0),
          child: CircleAvatar(
            radius: 80,
            backgroundColor: Colors.white,
            child: Icon(Icons.pets, size: 100, color: Colors.brown),
          ),
        ),
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

class CenterWidget extends StatelessWidget {
  const CenterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
        color: const Color.fromARGB(217, 217, 217, 217),
        child: const Column(
          children: <Widget>[
            Card(
              child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60.0),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Vetenarian Information',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        'Name',
                        
                      ),
                      
                    ),
                    
                    
                  ],
                ),
              ),
              
            
            
          ],
        ));
  }
}
