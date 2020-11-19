import 'package:client_car_service_system/components/Navigation/AppBarComponents.dart';
import 'package:client_car_service_system/components/Other%20Components/ConnectionMySql.dart';
import 'package:client_car_service_system/models/Account/classAccountData.dart';
import 'package:client_car_service_system/screens/Rewards/SwiableRewards.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



List<classAccountClientData> accountDataList=[];
class MembershipScreen extends StatefulWidget {
  MembershipScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MembershipScreenState createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: getMembership(),

    );
  }

  Widget getMembership(){

    return Scaffold(

      body: Column(

        children: <Widget>[

          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(

                image: DecorationImage(
                    image: AssetImage('assets/Others/Background.png'),
                    fit: BoxFit.cover
                )
            ),

            child:Column(

              children: <Widget>[
                SizedBox(height: 20,),

                Row(

                  children: <Widget>[


                    IconButton(

                      icon: Icon(
                        FontAwesomeIcons.arrowLeft,
                        color: Colors.white,
                        size: 25.0,
                      ),

                      onPressed: (){
                        Navigator.pop(context);
                      },

                    ),

                    SizedBox(width: 220,),

                    Icon(
                      FontAwesomeIcons.coins,
                      color: Colors.white,
                      size: 22.0,
                    ),

                    SizedBox(width: 10,),

                    Text("100 Point",style: TextStyle(
                        fontSize: 20,fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),),






                  ],

                ),

                Container(
                  decoration: BoxDecoration(

                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors: [
                            Colors.black.withOpacity(0),
                            Colors.black.withOpacity(0),
                          ]
                      )
                  ),

                ),

                SizedBox(width: 100,),

                Container(

                  margin: EdgeInsets.all(30.0),

                  child:  Align(
                      alignment: Alignment.centerLeft,
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Text("Membership", style: TextStyle(fontSize: 20,color: Colors.white)),
                          Text("Level 1", style: TextStyle(fontSize: 20, color: Colors.white)),

                        ],

                      )
                  ),
                ) ,

              ],

            ),
          ),


          Container(

            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(

              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topLeft: Radius.circular(10)
              ),

            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              elevation: 5,
              child: Container(
                height: 100.0,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      width: 100.0,

                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10)
                          ),

                          image: DecorationImage(

                              fit: BoxFit.cover,

                              image: NetworkImage("https://i.pinimg.com/736x/b2/45/53/b245530f3fb7c03f81cc400bee672728.jpg")

                          )
                      ),
                    ),
                    Container(

                      height: 75,
                      width: 120,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 26, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Reward",
                              style: TextStyle(fontSize: 20),
                            ),



                          ],
                        ),
                      ),
                    ),

                    Container(

                      child: Row(

                        children: [
                          Container(

                            child: Padding(
                              padding: EdgeInsets.fromLTRB(90, 24, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[

                                  IconButton(
                                    icon: Icon(Icons.chevron_right,
                                      color: Colors.grey,
                                      size: 40.0,),
                                    onPressed: (){

                                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SwipableRewards()));

                                    },

                                  ),

                                ],
                              ),
                            ),
                          ),

                        ],
                      ),

                    )
                  ],
                ),
              ),
            ),

          ),

        ],

      ),


    );

  }
}



