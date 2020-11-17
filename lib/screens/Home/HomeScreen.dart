
import 'package:client_car_service_system/components/Navigation/AppBarComponents.dart';
import 'package:client_car_service_system/components/Other%20Components/ConnectionMySql.dart';
import 'package:client_car_service_system/models/Account/classAccountData.dart';
import 'package:client_car_service_system/models/Car/classCarData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  final TextEditingController _emailTextField = TextEditingController();

  var _formKey=GlobalKey<FormState>();

  var db = new Mysql();


  @override
  Widget build(BuildContext context) {

    AppBarData _appBarData=new AppBarData('Home',null);

    return Scaffold(

      appBar:AppBarTitle(_appBarData),
      body: Container(

        margin:EdgeInsets.fromLTRB(0, 20, 0, 0),

        child: Column(

          children: <Widget>[

            Form(

              key: _formKey,

              child: Column(

                children: <Widget>[

                  topTitle(),


                ],

              ),

            )

          ],

        ),

      ),

    );
  }

  Widget topTitle(){

    return Card(

      elevation: 5,
      child: Container(

        decoration:BoxDecoration(

          border: Border.all(
            width: 2.0,
            color:  Colors.white24,
          ),
        ),

        child: Row(
          children: <Widget>[

            SizedBox(width: 10,),

            ClipOval(

                child: Container(

                  height: 90.0,
                  width: 90.0,

                  decoration: BoxDecoration(

                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        topLeft: Radius.circular(50),

                      ),

                      image: DecorationImage(

                          fit: BoxFit.cover,

                          image: AssetImage('assets/Home/Steve Harvey.png')

                      )
                  ),

                )
            ),

            Container(

              height: 100,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Hello Steve Harvey',
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                      child: Container(
                          width: 260,

                          child: Row(
                            children: [

                              Icon(
                                FontAwesomeIcons.shieldVirus,
                                color: Colors.orange,
                                size: 25.0,
                              ),

                              SizedBox(width: 10,),

                              Text("Platinum",style: TextStyle(
                                  fontSize: 15,fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 48, 48, 54,)
                              ),),

                              SizedBox(width: 10,),

                              Icon(
                                FontAwesomeIcons.coins,
                                color: Colors.orange,
                                size: 25.0,
                              ),

                              SizedBox(width: 10,),

                              Text("100 Point",style: TextStyle(
                                  fontSize: 15,fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 48, 48, 54)
                              ),),


                              new IconButton(
                                icon: Icon(Icons.chevron_right,
                                  color: Colors.grey,
                                  size: 30.0,),
                                onPressed: (){

                                },

                              ),

                            ],
                          )

                      ),
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

  }



}




