import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:petcent/appointmentpage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:petcent/auth_page.dart';
import 'package:petcent/settings_page.dart';
import 'firebase_options.dart';

import 'package:petcent/homepage.dart';
import 'package:petcent/caringpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //init hive
  await Hive.initFlutter();

  //open a box
  // ignore: unused_local_variable
  var box = await Hive.openBox('mybox');

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff73BA9B)),
        useMaterial3: true,
      ),
      home: const AuthPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    final user = FirebaseAuth.instance.currentUser!;

  int currentPageIndex = 0;

  void signUserOut() async {
    
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffE5E5E5),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            // Check if the last index (sign out button) is selected
            if (index == 4) {
              // Assuming the new button is the fourth item
              signUserOut(); // Call the SignUserOut method
            } else {
              setState(() {
                currentPageIndex = index;
              });
            }
          },
          indicatorColor: Colors.amber,
          selectedIndex: currentPageIndex,

          //Bottom Navigation
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
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
            
          ],
        ),

        //Body depending on navigation bar
        body: [
          HomePage(user: user),
          Appointments(user: user),
          CaringPage(user: user),
          SettingsPage(user: user),
        ][currentPageIndex]);
  }
}
