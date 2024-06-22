import 'package:flutter/material.dart';
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
    return SizedBox(
      height: 350,
      child: Container(
        color: Colors.green,
        child: const Column(
          children: [
            PrintandCircle(),
            Text("Hello World"),
          ],
        ),
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
          height: 300,
          width: 200,
          child: PawPrint(),
        ),
        Positioned(
          top: 60,
          right: 30,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: Colors.white,
            child: Icon(Icons.pets, size: 50, color: Colors.brown),
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
    return const Placeholder();
  }
}
