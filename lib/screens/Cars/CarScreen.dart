
import 'dart:math';

import 'package:client_car_service_system/components/Navigation/AppBarComponents.dart';
import 'package:client_car_service_system/components/Other%20Components/ConnectionMySql.dart';
import 'package:client_car_service_system/models/Car/classCarData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'AddCarScreen.dart';


List<classCarData> carDataList=[];
class CarScreen extends StatefulWidget {
  CarScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CarScreenState createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen>{

  List<String> companies;
  GlobalKey<RefreshIndicatorState> refreshKey;

  Random r;

  final TextEditingController _emailTextField = TextEditingController();

  var _formKey=GlobalKey<FormState>();

  var db = new Mysql();

  void _getCars() {

    carDataList.clear();
    db.getConnection().then((conn) {
      String sqlQuery = "SELECT CR.Cars_Id,CR.PlateNumber,CR.Cars_Model,CR.Cars_Transmission FROM Cars CR,Customers CSM WHERE CR.Customers_Id=CSM.Customers_Id AND CR.Customers_Id='CSM1' ";

      conn.query(sqlQuery).then((results) {
        print('${results}');
        for(var row in results){
          classCarData cr=new classCarData();
          cr.carId=row[0];
          cr.carPlateNumber=row[1];
          cr.carModel=row[2];
          carDataList.add(cr);

        }
        setState(() {
          carList();
        });

      });
      conn.close();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCars();
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    _getCars();
    return null;
  }

  @override
  Widget build(BuildContext context) {

    AppBarData _appBarData=new AppBarData('Car',null);

    return Scaffold(

      appBar:AppBarTitle(_appBarData),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {
          await refreshList();
        },
        child: carList(),
      ),

    );
  }

  Widget carList(){

    return Scaffold(

      body: ListView.builder(itemCount:  carDataList.length,

          itemBuilder: (context,index){

            return Slidable(

              actionPane: SlidableStrechActionPane(),
              actionExtentRatio: 0.3,

              child: Container(
                margin:EdgeInsets.fromLTRB(0, 20, 0, 0),

                decoration: BoxDecoration(

                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10)
                  ),

                ),

                child: GestureDetector(
                  onTap: () => print(carDataList[index]),
                  child: Card(
                    elevation: 5,
                    child: Container(

                      margin:EdgeInsets.fromLTRB(10, 0, 10, 0),

                      height: 150.0,
                      child: Row(
                        children: <Widget>[

                          Container(
                            height: 100.0,
                            width: 100.0,
                            margin:EdgeInsets.fromLTRB(0, 0, 10, 0),
                            decoration: BoxDecoration(

                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10)
                                ),

                                image: DecorationImage(

                                    fit: BoxFit.cover,

                                    image: NetworkImage("https://images.unsplash.com/photo-1552519507-da3b142c6e3d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80")

                                )
                            ),
                          ),

                          Container(
                            height: 120.0,
                            width: 230.0,
                            padding: const EdgeInsets.only(left: 0,right: 0,top: 25,bottom: 10),
                            decoration: BoxDecoration(

                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  topLeft: Radius.circular(10)
                              ),

                            ),

                            child: Column(

                              children: <Widget>[

                                Align(


                                  child: Text('Plate Number      : ${getWidgetCar(carDataList)[index]["Car_PlateNumber"]}',style: TextStyle(fontSize: 16),),
                                  alignment: Alignment.centerLeft,

                                ),

                                Align(


                                  child:Text('Model                    : ${getWidgetCar(carDataList)[index]["Car_Model"]}',style: TextStyle(fontSize: 16)) ,
                                  alignment: Alignment.centerLeft,

                                ),

                                Align(


                                  child:Text('Car Transmission : ${getWidgetCar(carDataList)[index]["Car_Transmission"]}',style: TextStyle(fontSize: 16)),
                                  alignment: Alignment.centerLeft,

                                ),

                                Align(


                                  child:Text('Road Tax Exp        : ',style: TextStyle(fontSize: 15)),
                                  alignment: Alignment.centerLeft,

                                ),

                              ],
                            ),

                          ),

                        ],
                      ),

                    ),
                  ),

                ),

              ),

              secondaryActions:<Widget>[

                IconSlideAction(

                  caption: 'Delete',
                  color: Colors.red,
                  icon: FontAwesomeIcons.trash,

                  onTap: (){

                  },

                ),

              ],


            );

          }),

      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => AddCarScreen()));

        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
      ), // This trai

    );

  }




  Widget continueButton(){

    return Theme(

        data: Theme.of(context).copyWith(primaryColor: Colors.orange,)

    );
  }

}

List getWidgetCar(List<classCarData> list){

  List _list =[];
  for(int i=0;i<list.length;i++){
    _list.add({

      'Car_Id':'${list[i].carId}',
      'Car_PlateNumber':'${list[i].carPlateNumber}',
      'Car_Model':'${list[i].carModel}',
      'Car_Transmission':'${list[i].carTransmission}',


    });
  }
  return _list;
}



