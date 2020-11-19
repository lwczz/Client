
import 'dart:math';
import 'package:client_car_service_system/components/Other%20Components/ConnectionMySql.dart';
import 'package:client_car_service_system/models/Reward/classRewardData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



List<classRewardData> rewardDataList=[];
class RewardScreen extends StatefulWidget {
  RewardScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RewardScreenState createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen>{

  GlobalKey<RefreshIndicatorState> refreshKey;

  Random r;

  var db = new Mysql();

  void _getRewards() {

    rewardDataList.clear();
    db.getConnection().then((conn) {
      String sqlQuery = "SELECT * FROM Rewards WHERE Rewards_Balance > 1 ";

      conn.query(sqlQuery).then((results) {
        print('${results}');
        for(var row in results){
          classRewardData rw=new classRewardData();

          rw.rewardsId=row[0];
          rw.rewardsName=row[1];
          rw.rewardsPoint=row[2];
          rw.rewardsBalance=row[3];

          rewardDataList.add(rw);

        }
        setState(() {
          rewardList() ;
        });

      });
      conn.close();
    });
  }



  void _updateRewards(String _getRewardId) {

    db.getConnection().then((conn) {
      String sqlQuery = "UPDATE Rewards SET Rewards_Balance=Rewards_Balance-1 WHERE Rewards_Id='${_getRewardId}' ";

      conn.query(sqlQuery);

      conn.close();
    });
  }

  void _updateCustomerPoint(int _getRewardPoint) {

    db.getConnection().then((conn) {
      String sqlQuery = "UPDATE Customers SET Membership_Point=Membership_Point-${_getRewardPoint} WHERE Customers_Id='CSM1' ";

      conn.query(sqlQuery);

      conn.close();
    });
  }

  void _insertRewards(String _getRewardId) {

    db.getConnection().then((conn) {
      String sqlQuery = "INSERT INTO FYP_TEST.Reward_Detail VALUES ('${_getRewardId}','CSM1',LPAD(FLOOR(RAND() * 999999.99), 6, '0'),NOW(),'ACTIVATED',NOW()+INTERVAL 60 DAY) ";

      conn.query(sqlQuery);

      conn.close();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getRewards();
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    _getRewards();
    return null;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {
          await refreshList();
        },
        child: rewardList(),
      ),

    );
  }

  Widget rewardList(){

    return Scaffold(

      body: ListView.builder(itemCount:  rewardDataList.length,

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
                  onTap: () => print(rewardDataList[index]),
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

                                    image: NetworkImage("https://img.freepik.com/free-vector/christmas-new-year-s-day-red-gift-box-white-background-illustration_164911-157.jpg?size=626&ext=jpg")

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


                                  child: Text('Reward Name   : ${getWidgetReward(rewardDataList)[index]["Reward_Name"]}',style: TextStyle(fontSize: 16),),
                                  alignment: Alignment.centerLeft,

                                ),

                                SizedBox(height: 10,),

                                Align(


                                  child:Text('Redeem Point   : ${getWidgetReward(rewardDataList)[index]["Reward_Point"]}',style: TextStyle(fontSize: 16)) ,
                                  alignment: Alignment.centerLeft,

                                ),

                                SizedBox(height: 10,),

                                Align(


                                  child:Text('Stock                  : ${getWidgetReward(rewardDataList)[index]["Reward_Balance"]}',style: TextStyle(fontSize: 16)),
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

                  caption: 'Redeem',
                  color: Colors.green,
                  icon: FontAwesomeIcons.gift,

                  onTap: (){
                    _updateRewards(getWidgetReward(rewardDataList)[index]["Reward_Id"]);
                    _insertRewards(getWidgetReward(rewardDataList)[index]["Reward_Id"]);
                    _updateCustomerPoint(getWidgetReward(rewardDataList)[index]["Reward_Point"]);
                    final snackBar = SnackBar(

                      content: Text('${getWidgetReward(rewardDataList)[index]["Reward_Name"]} Successful Redeem.Pls check the Rewards History'),
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: (){

                          setState(() {
                            _getRewards();
                          });

                        },
                      ),

                    );
                    Scaffold.of(context).showSnackBar(snackBar);



                  },

                ),

              ],


            );

          }),

    );

  }




  Widget continueButton(){

    return Theme(

        data: Theme.of(context).copyWith(primaryColor: Colors.orange,)

    );
  }

}

List getWidgetReward(List<classRewardData> list){

  List _list =[];
  for(int i=0;i<list.length;i++){
    _list.add({

      'Reward_Id':'${list[i].rewardsId}',
      'Reward_Name':'${list[i].rewardsName}',
      'Reward_Point':'${list[i].rewardsPoint}',
      'Reward_Balance':'${list[i].rewardsBalance}',

    });
  }
  return _list;
}



