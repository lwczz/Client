import 'dart:convert';
import 'package:client_car_service_system/components/Navigation/BottomNavigations.dart';
import 'package:client_car_service_system/models/Account/classAccountData.dart';
import 'package:client_car_service_system/screens/Account/SignUpScreen.dart';
import 'package:client_car_service_system/screens/Booking/BookingHistoryScreen.dart';
import 'package:client_car_service_system/screens/Cars/AddCarScreen.dart';
import 'package:client_car_service_system/screens/Cars/CarScreen.dart';
import 'package:client_car_service_system/screens/Home/HomeScreen.dart';
import 'package:client_car_service_system/screens/Home/TopUpScreen.dart';
import 'package:client_car_service_system/screens/Home/TopUpScreenfulScreen.dart';
import 'package:client_car_service_system/screens/Membership/MembershipScreen.dart';
import 'package:client_car_service_system/screens/Rewards/RewardHistoryScreen.dart';
import 'package:client_car_service_system/screens/Rewards/RewardScreen.dart';
import 'package:client_car_service_system/screens/Rewards/SwiableRewards.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';


ProgressDialog pr;

class SignInScreen extends StatefulWidget {
  SignInScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>{

  bool _isLoading = false;

  Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  final TextEditingController _emailTextField = TextEditingController();
  final TextEditingController _passwordTextField = TextEditingController();

  var _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    pr = new ProgressDialog(context);
    pr.style(
        message: 'Please Waiting...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );

    return Scaffold(

        body: SingleChildScrollView(

          child: Stack(

            children: <Widget>[

              Column(
                children: <Widget>[

                  ClipPath(

                      clipper: MyClipper(),
                      child:Column(
                        children: <Widget>[

                          Container(

                            decoration: BoxDecoration(

                              gradient: LinearGradient(

                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [Colors.red, Colors.yellow]

                              ),

                            ),

                            padding: const EdgeInsets.only(left: 300.0,right: 100.0,top: 0,bottom: 200),
                          ),

                        ],
                      )

                  ),

                  Container(

                    child: Image.asset('assets/Logo/HomePageLogo.png'),


                  ),

                  Container(

                    margin:EdgeInsets.fromLTRB(30, 0, 30, 0),

                    child: Column(

                      children: <Widget>[

                        Text('Client Login',style: TextStyle(fontSize: 20),),

                        SizedBox(height: 10,),

                        Form(

                          key: _formKey,

                          child: Column(

                            children: <Widget>[

                              emailLogin(),

                              SizedBox(height: 10,),

                              passwordLogin(),

                              SizedBox(height: 10,),

                              loginButton(),

                              SizedBox(height: 10,),

                              signUpButton(),

                              SizedBox(height: 10,),

                            ],

                          ),
                        ),

                        SizedBox(height: 5,),

                        Align(

                          child: GestureDetector(

                            child: Text("Forgot Password ?",style: TextStyle(fontSize: 16,color: Colors.blue),),

                            onTap: (){

                            },

                          ),

                          alignment: Alignment.centerRight,

                        )

                      ],

                    ),

                  ),

                ],
              ),

            ],

          )
        )

    );
  }



  Widget emailLogin(){

    RegExp regex = new RegExp(pattern);

    return Theme(

      child: TextFormField(

        controller: _emailTextField,

        validator: (val){
          if(val.isEmpty)
            return 'Email Field is Empty';
          if (!(regex.hasMatch(val)))
            return "Invalid Email";
          return null;
        },

        obscureText:false,
        decoration: InputDecoration(
            border: InputBorder.none,

            enabledBorder: OutlineInputBorder(

              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.black),

            ),

            focusedBorder: OutlineInputBorder(

              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.black),

            ),

            labelText: 'Email Address',
            //LabelText

            hintText: '123456@gmail.com',
            //HintText

            prefixIcon: Icon(Icons.email)

        ),

      ),

      data: Theme.of(context).copyWith(primaryColor: Colors.orange,),
    );

  }

  Widget passwordLogin(){

    return Theme(

      child: TextFormField(

        controller: _passwordTextField,

        validator: (val){
          if(val.isEmpty)
            return 'Password Field Empty';
          return null;
        },

        maxLength: 12,

        obscureText:true,
        decoration: InputDecoration(
            border: InputBorder.none,

            enabledBorder: OutlineInputBorder(

              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.black),

            ),

            focusedBorder: OutlineInputBorder(

              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.black),

            ),

            labelText: 'Password',
            //LabelText

            hintText: 'Password',
            //HintText

            prefixIcon: Icon(Icons.lock)

        ),

      ),

      data: Theme.of(context).copyWith(primaryColor: Colors.orange,),

    );

  }

  Widget loginButton(){

    return ButtonTheme(

      minWidth: 500.0,
      height: 50.0,

      child: RaisedButton(

        textColor: Colors.white,
        color:Colors.orange,
        splashColor: Colors.orangeAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)
        ),
        child: Text('Sign In'),
        onPressed: () {

          Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=> BottomNavigations()));

        },

      ),
    );

  }



  Widget signUpButton(){

    return ButtonTheme(

      minWidth: 500.0,
      height: 50.0,

      child: RaisedButton(

        textColor: Colors.white,
        color:Colors.orange,
        splashColor: Colors.orangeAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)
        ),
        child: Text('Sign Up'),
        onPressed: () {

          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => MembershipScreen()));

        },

      ),
    );

  }

}



class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path=new Path();
    path.lineTo(0, size.height / 1.75);
    var firstControlPoint = new Offset(size.width / 4, size.height / 1.75);
    var firstEndPoint = new Offset(size.width / 2, size.height / 1.75 - 60);
    var secondControlPoint =
    new Offset(size.width - (size.width / 4), size.height / 2.75 - 65);
    var secondEndPoint = new Offset(size.width, size.height / 1.75 - 40);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}
