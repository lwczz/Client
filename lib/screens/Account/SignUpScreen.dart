import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

ProgressDialog pr;

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>{

  bool _isLoading = false;

  Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  final TextEditingController _fullNameField = TextEditingController();
  final TextEditingController _nriNumberField = TextEditingController();
  final TextEditingController _emailTextField = TextEditingController();
  final TextEditingController _phoneNumberField = TextEditingController();
  final TextEditingController _passwordTextField = TextEditingController();
  final TextEditingController _confirmPasswordTextField = TextEditingController();

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

      body: ,

    );

  }

  Widget fullNameField(){

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

  Widget icNumberField(){
    return Theme();
  }

  Widget emailField(){

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

  Widget phoneNumberField(){
    return Theme(

      data: Theme.of(context).copyWith(primaryColor: Colors.orange,),

    );
  }

  Widget passwordField(){
    return Theme(

      child: TextFormField(

        controller: _passwordTextField,

        validator: (val){
          if(val.isEmpty)
            return 'Confirm Password Field Empty';
          if(val != _new.text)
            return 'New Password & Confirm Password Not Match';
          return null;
        },

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

            hintText: 'Abc1234',
            //HintText

            prefixIcon: Icon(Icons.lock)

        ),

      ),

      data: Theme.of(context).copyWith(primaryColor: Colors.orange,),

    );
  }

  Widget confirmPasswordField(){
    return Theme(

      child: TextFormField(

        controller: _confirmPasswordTextField,

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

            labelText: 'Confirm Password',
            //LabelText

            hintText: 'Abc1234',
            //HintText

            prefixIcon: Icon(Icons.lock)

        ),

      ),

      data: Theme.of(context).copyWith(primaryColor: Colors.orange,),

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
