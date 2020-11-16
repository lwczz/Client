import 'package:client_car_service_system/WebServices/MailServices.dart';
import 'package:client_car_service_system/components/Navigation/AppBarComponents.dart';
import 'package:client_car_service_system/components/Other%20Components/ConnectionMySql.dart';
import 'package:client_car_service_system/components/Other%20Components/RandomCharacter.dart';
import 'package:client_car_service_system/models/Account/classAccountData.dart';
import 'package:client_car_service_system/models/classSendEmail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



List<classAccountClientData> accountDataList=[];
class AddCarScreen extends StatefulWidget {
  AddCarScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AddCarScreenState createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen>{

  final TextEditingController _emailTextField = TextEditingController();

  var _formKey=GlobalKey<FormState>();

  Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  var db = new Mysql();






  @override
  Widget build(BuildContext context) {

    AppBarData _appBarData=new AppBarData('Forgot Password',null);

    return Scaffold(

      appBar:AppBarTitle(_appBarData),
      body: Container(

        margin:EdgeInsets.fromLTRB(30, 20, 30, 0),

        child: Column(

          children: <Widget>[

            Form(

              key: _formKey,

              child: Column(

                children: <Widget>[



                ],

              ),

            )

          ],

        ),

      ),

    );
  }

  WidgetcarPlateNumber(){
  }
  Widget selectMakeDropDown(){
  }
  Widget carModel(){
  }
  Widget selectYearDropDown(){
  },
  Widget selectCCDropDown(){
  }
  Widget continueButton(){
  }

}



List   getWidgeteEmail(List<classAccountClientData> list){

  List _list =[];
  for(int i=0;i<list.length;i++){
    _list.add({

      'Account_Email':'${list[i].clientEmail}',

    });
  }
  return _list;
}