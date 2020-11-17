import 'dart:convert';
import 'package:client_car_service_system/components/Navigation/AppBarComponents.dart';
import 'package:client_car_service_system/components/Other%20Components/ConnectionMySql.dart';
import 'package:client_car_service_system/screens/Account/SignInScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:progress_dialog/progress_dialog.dart';

ProgressDialog pr;

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>{

  FocusNode myFocusNode = new FocusNode();

  bool _isLoading = false;

  Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  final TextEditingController _fullNameField = TextEditingController();
  final TextEditingController _nricNumberField = TextEditingController();
  final TextEditingController _emailTextField = TextEditingController();
  final TextEditingController _phoneNumberField = TextEditingController();
  final TextEditingController _passwordTextField = TextEditingController();
  final TextEditingController _confirmPasswordTextField = TextEditingController();

  var db = new Mysql();

  var _formKey=GlobalKey<FormState>();

  void _signUpData(){

    db.getConnection().then((conn) {

      conn.query("insert into Peoples (Peoples_Id, Peoples_Name,Peoples_Image,Peoples_Password,Peoples_Email,Peoples_NRIC,Peoples_Phone_Number) values (?,?,?,?,?,?,?)",['PPL2',_fullNameField.text,'',_passwordTextField,_emailTextField.text,_nricNumberField.text,_phoneNumberField.text]);

      conn.query("insert into Customers (Customers_Id, Membership_Point,EWallet,Status,Peoples_Id) values (?,?,?,?,?)",['CSM3',2,0,0,'PPL2']);

      conn.close();

    });

  }

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

    AppBarData _appBarData=new AppBarData('Sign Up',null);

    return Scaffold(

      appBar:AppBarTitle(_appBarData),

      body: SingleChildScrollView(

        child: Container(

          margin:EdgeInsets.fromLTRB(30, 20, 30, 0),

          child: Column(

            children: <Widget>[

              fullNameField(),

              SizedBox(height: 10,),

              icNumberField(),

              SizedBox(height: 10,),

              emailField(),

              SizedBox(height: 10,),

              phoneNumberField(),

              SizedBox(height: 10,),

              passwordField(),

              SizedBox(height: 10,),

              confirmPasswordField(),

              SizedBox(height: 10,),

              Text('By registering, you are agreering to the YSMD Terms and Conditions, User Agreement and Privacy Policy'),

              SizedBox(height: 10,),

              signUpButton(),

            ],

          ),

        ),

      ),

    );

  }

  Widget fullNameField(){

    return Theme(

      child: TextFormField(

        controller:_fullNameField,

        validator: (val){
          if(val.isEmpty)
            return 'Full Name Field Empty';
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
    return Theme(

      child: TextFormField(

        controller: _nricNumberField,

        validator: (val){
          if(val.isEmpty)
            return 'NRIC Field Empty';
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

  Widget emailField(){

    return Theme(

      child: TextFormField(

        controller: _emailTextField,

        validator: (val){
          if(val.isEmpty)
            return 'Email Field Empty';
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

      child: IntlPhoneField(
        controller: _phoneNumberField,

        validator: (val){
          if(val.isEmpty)
            return 'Phone Field Empty';
          return null;
        },

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

          labelText: 'Contact Number',
          //LabelText

          labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Colors.orange : Colors.black
          ),

          hintText: 'xxxxxxx',
          //HintText

          //Icon


        ),
        initialCountryCode: 'MY',
        onChanged: (phone) {
          print(phone.completeNumber);
        },
      ),

      data: Theme.of(context).copyWith(primaryColor: Colors.orange,),

    );
  }

  Widget passwordField(){
    return Theme(

      child: TextFormField(

        controller: _passwordTextField,

        validator: (val){
          if(val.isEmpty)
            return 'Password Field Empty';
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

        validator: (val){
          if(val.isEmpty)
            return 'Confirm Password Field Empty';
          if(val != _confirmPasswordTextField.text)
            return 'Password & Confirm Password Not Match';
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
          onPressed:(){

            if(_formKey.currentState.validate()){

              pr.show();
              Future.delayed(Duration(seconds: 3)).then((value) {
                pr.hide().whenComplete(() {
                  _signUpData();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => SignInScreen()));
                });
              }
              );

            }else{

              final snackBar = SnackBar(
                content: Text('Invalid Email or Password'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),

              );
              Scaffold.of(context).showSnackBar(snackBar);

            }



          }

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
