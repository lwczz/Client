import 'package:client_car_service_system/screens/Account/Logout.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(


      title: 'Log Me In',
      home: Scaffold(

        body:SignInScreen(),
      ),
    );
  }
}
