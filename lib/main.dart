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
      color: Color.fromARGB(255, 95, 196, 98),
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
    return  const Row(
      children: [
         SizedBox(
          height: 250,
          width: 200,
          child: PawPrint(),
        ),
        Padding(
          padding:  EdgeInsets.only(left: 8.0, top: 50.0),
          child: CircleAvatar(
            radius: 80,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage("assets/images/Pet.png"),
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
        color: const Color.fromARGB(217, 229, 229, 229),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Center(child: VetCard()),
            const Padding(
              padding: EdgeInsets.only(left: 30.0, top: 30.0),
              child: Text("Daily Tasks"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.check_box_outline_blank_outlined),
                  onTap: () {
                    print("Hello");
                  },
                  title: const Text("Feed the Dog"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.check_box_outline_blank_outlined),
                  onTap: () {
                    print("Hello");
                  },
                  title: const Text("Walk the Dog"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.add_box_outlined),
                  onTap: () {
                    print("Hello");
                  },
                  title: const Opacity(
                    opacity: 0.6,
                    child: Text("Add a Task"),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class VetCard extends StatelessWidget {
  const VetCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
      child: Card(
        color: Color.fromARGB(217, 217, 217, 217),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                'Vetenarian Information',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Text(
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                    'Name:',
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: Text(
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      'Duck Creek Animal Hospital',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Text(
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                    'Number:',
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      '(302) 653-2300',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Text(
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                    'Location:',
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      'Smryna, DE',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
