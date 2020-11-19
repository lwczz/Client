import 'package:client_car_service_system/screens/Booking/BookingHistoryScreen.dart';
import 'package:client_car_service_system/screens/Cars/CarScreen.dart';
import 'package:client_car_service_system/screens/Home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigations extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _BottomNavigationsState();
  }
}

class _BottomNavigationsState extends State<BottomNavigations> {


  int _currentIndex = 0;
  final List<Widget> _children = [
      new HomeScreen(),
      new CarScreen(),
      new BookingHistoryScreen(),

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: new BottomNavigationBar(

        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,

        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(FontAwesomeIcons.shoppingBag),
            title: new Text('Home'),
          ),

          new BottomNavigationBarItem(
            icon: new Icon(FontAwesomeIcons.car),
            title: new Text('Car'),
          ),

          new BottomNavigationBarItem(
            icon: new Icon(FontAwesomeIcons.history),
            title: new Text('Booking'),
          ),

          new BottomNavigationBarItem(
            icon: new Icon(FontAwesomeIcons.personBooth),
            title: new Text('Profile'),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}


