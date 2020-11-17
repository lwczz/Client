import 'package:client_car_service_system/components/Navigation/AppBarComponents.dart';
import 'package:client_car_service_system/components/Other%20Components/ConnectionMySql.dart';
import 'package:client_car_service_system/models/Account/classAccountData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CarScreen.dart';


final makeTypes = ["Hyundai","Honda", "Audi", "Ford","Proton"];
final years = ["2020","2019", "2018", "2017","2016"];
final ccTypes = ["1","1.1","1.2","1.3","1.4"];

var currentMakeSelectedValue;
var currentYearsSelectedValue;
var currentCCSelectedValue;

List<classAccountClientData> accountDataList=[];
class AddCarScreen extends StatefulWidget {
  AddCarScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AddCarScreenState createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen>{

  final TextEditingController _plateNumberController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();

  var _formKey=GlobalKey<FormState>();

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

                  Container(

                    margin:EdgeInsets.fromLTRB(5, 10, 5, 0),

                    child: Column(

                      children: <Widget>[

                        carPlateNumber(),

                        SizedBox(height: 20,),

                        selectMakeDropDown(),

                        SizedBox(height: 20,),

                        carModel(),

                        SizedBox(height: 20,),

                        selectYearsDropDown(),

                        SizedBox(height: 20,),

                        selectCCDropDown(),

                        SizedBox(height: 20,),

                        continueButton(),

                      ],

                    ),

                  ),


                ],

              ),

            )

          ],

        ),

      ),

    );
  }

  Widget carPlateNumber(){

    return Theme(

        child: TextFormField(

          controller: _plateNumberController,

          validator: (val){
            if(val.isEmpty)
              return 'Password Field Empty';
            return null;
          },

          maxLength: 9,

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

              labelText: 'Plate Number',
              //LabelText

              hintText: 'ABCX1234',
              //HintText

              prefixIcon: Icon(Icons.lock)

          ),

        ),

      data: Theme.of(context).copyWith(primaryColor: Colors.orange,)

    );

  }
  Widget selectMakeDropDown(){

    return Theme(

        child: FormField<String>(
          builder: (FormFieldState<String> state){
            return InputDecorator(

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
                  prefixIcon: Icon(Icons.branding_watermark)
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text("Select Make"),
                  value:currentMakeSelectedValue,
                  isDense: true,
                  onChanged: (newValue){
                    setState(() {
                      currentMakeSelectedValue=newValue;
                    });
                  },
                  items: makeTypes.map((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),

        data: Theme.of(context).copyWith(primaryColor: Colors.orange,)

    );

  }
  Widget carModel(){

    return Theme(

        child: TextFormField(

          controller: _modelController,

          validator: (val){
            if(val.isEmpty)
              return 'Password Field Empty';
            return null;
          },

          maxLength: 9,

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

              labelText: 'Model',
              //LabelText

              hintText: '',
              //HintText

              prefixIcon: Icon(Icons.lock)

          ),

        ),

        data: Theme.of(context).copyWith(primaryColor: Colors.orange,)

    );

  }
  Widget selectYearsDropDown(){

    return Theme(

        child: FormField<String>(
          builder: (FormFieldState<String> state){
            return InputDecorator(

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
                  prefixIcon: Icon(Icons.date_range)
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text("Select Year"),
                  value:currentYearsSelectedValue,
                  isDense: true,
                  onChanged: (newValue){
                    setState(() {
                      currentYearsSelectedValue=newValue;
                    });
                  },
                  items: years.map((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),

        data: Theme.of(context).copyWith(primaryColor: Colors.orange,)

    );

  }
  Widget selectCCDropDown(){

    return Theme(

        child: FormField<String>(

          builder: (FormFieldState<String> state){

            return InputDecorator(


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
                  prefixIcon: Icon(Icons.cached)
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text("Select CC"),
                  value:currentCCSelectedValue,
                  isDense: true,
                  onChanged: (newValue){
                    setState(() {
                      currentCCSelectedValue=newValue;
                    });
                  },
                  items: ccTypes.map((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),

        data: Theme.of(context).copyWith(primaryColor: Colors.orange,)

    );

  }
  Widget continueButton(){

   return ButtonTheme(

      minWidth: 500.0,
      height: 60.0,

      child: RaisedButton(

        textColor: Colors.white,
        color:Colors.orange,
        splashColor: Colors.orangeAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)
        ),
        child: Text('Continue'),
        onPressed: () {

          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => CarScreen()));

        },

      ),
    );

  }

}



