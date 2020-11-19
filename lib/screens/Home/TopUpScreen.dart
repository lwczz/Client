import 'package:client_car_service_system/components/Other%20Components/ConnectionMySql.dart';
import 'package:client_car_service_system/models/Account/classAccountData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

import 'HomeScreen.dart';
import 'PalpayScreen.dart';



List<classAccountClientData> accountDataList=[];
class TopUpScreen extends StatefulWidget {
  TopUpScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TopUpScreenState createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen>{



  double _currentValue=0;

  var _formKey=GlobalKey<FormState>();

  TextEditingController _topUpValueController=new TextEditingController();

  classAccountEwalletData _topUpValue=new classAccountEwalletData();

  var db = new Mysql();

  String sessionId="";

  void _getCurrentValue(){

    db.getConnection().then((conn) {

      String sqlQuery = "SELECT EWallet FROM Customers WHERE Customers_Id='CSM1' ";

      conn.query(sqlQuery).then((results) {
        print('${results}');
        for(var row in results){

          _currentValue=row[0];

        }

      });
      conn.close();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getCurrentValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:Form(
        key: _formKey,
        child: TopUp(),

      )

    );
  }

  Widget TopUp(){

    return Scaffold(


        body:SingleChildScrollView(

          child: Column(

            children: <Widget>[


              Container(

                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10)
                  ),

                ),

                child:  Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  elevation: 5,
                  child: Container(
                      height: 280.0,
                      child: Container(

                        margin:EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Column(

                          children: <Widget>[

                            Row(

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

                                          image: NetworkImage("https://i0.wp.com/www.ecommerce-nation.com/wp-content/uploads/2018/01/paypal.png")

                                      )
                                  ),
                                ),


                              ],

                            ),

                            Align(

                              child: Text('RM',style: TextStyle(fontSize: 20),),
                              alignment: Alignment.centerLeft,),

                            TextFormField(
                              controller: _topUpValueController,

                              validator: (val){
                                if(val.isEmpty)
                                  return 'Top Up Field Empty';
                                return null;
                              },

                              keyboardType: TextInputType.number,

                            ),

                            Align(

                              child: Text('Min. RM 20',style: TextStyle(fontSize: 14),),
                              alignment: Alignment.centerLeft,),

                            SizedBox(height: 20,),

                            ButtonTheme(

                              minWidth: 500.0,
                              height: 50.0,

                              child: RaisedButton(

                                textColor: Colors.white,
                                color:Colors.orange,
                                splashColor: Colors.orangeAccent,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)
                                ),
                                child: Text('Continue'),
                                onPressed: () {

                                  if(_formKey.currentState.validate()){

                                    _topUpValue.eWallet=_topUpValueController.text;
                                    Navigator.push(context,MaterialPageRoute(builder: (context) => PalpayScreen(),settings: RouteSettings(arguments: _topUpValue,
                                    ),),);

                                  }else{

                                    final snackBar = SnackBar(
                                      content: Text('Password Unchanged'),
                                      action: SnackBarAction(
                                        label: 'Undo',
                                        onPressed: () {
                                          // Some code to undo the change.
                                        },
                                      ),

                                    );
                                    Scaffold.of(context).showSnackBar(snackBar);
                                  }

                                },

                              ),
                            ),
                          ],

                        ),

                      )
                  ),
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

                child:  Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  elevation: 5,


                  child: Container(
                      height: 120.0,


                      child: Container(

                        margin:EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Column(

                          children: <Widget>[
                            SizedBox(height: 25,),
                            Align(

                              child: Text('Current Balance',style: TextStyle(fontSize: 16),),
                              alignment: Alignment.centerLeft,),

                            SizedBox(height: 20,),

                            Align(

                              child: Text('RM ${_currentValue}',style: TextStyle(fontSize: 20),),
                              alignment: Alignment.centerLeft,),




                          ],

                        ),

                      )
                  ),
                ),

              ),



            ],

          ),

        )





    );

  }
}



