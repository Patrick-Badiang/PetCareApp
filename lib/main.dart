import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pet_care_app/appointmentpage.dart';

import 'package:pet_care_app/homepage.dart';
import 'package:pet_care_app/caringpage.dart';
import 'package:pet_care_app/topWidget.dart';
import 'package:pet_care_app/utils/my_sign_in_button.dart';
import 'package:pet_care_app/utils/styled_text_field.dart';

void main() async {
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
      home: const MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final controller = TextEditingController();

  void signUserIn(){
    print("Sign In Tapped");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Login  Icon
              const SizedBox(height: 25),
              Image.asset("assets/images/Login/LoginPhoto.png"),

              //Welcome back text
              const SizedBox(height: 50),
              const Text(
                "Welcome Back",
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),

              //Email and Password TextFields
              const SizedBox(height: 25),
              StyledTextField(
                controller: controller,
                hintText: 'Enter your Email',
                obscureText: false,
              ),
              const SizedBox(
                height: 15,
              ),
              StyledTextField(
                controller: controller,
                hintText: 'Enter your Password',
                obscureText: true,
              ),

              //Forgot password?
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: Text("Forgot Password?"),
                  )
                ],
              ),

              //Sign in  Button
              const SizedBox(height: 25,),
              MySignInButton(
                onTap: signUserIn,
              ),
          

              //Continue with
              const  SizedBox(height: 25,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(child: Divider( thickness: 5,)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text("Or Continue With"),
                    ),
                    Expanded(child: Divider( thickness: 5,)),
                  ],
                ),
              )

              //Google and Facebook Icons
              
            ],
          ),
        ),
      ),
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
        backgroundColor: const Color(0xffE5E5E5),
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
          const HomePage(),
          const Appointments(),
          const CaringPage(),
          const HomePage(),
        ][currentPageIndex]);
  }
}
