
import 'dart:math';

import 'package:client_car_service_system/components/Navigation/AppBarComponents.dart';
import 'package:client_car_service_system/components/Other%20Components/ConnectionMySql.dart';
import 'package:client_car_service_system/models/Reward/classRewardData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



List<classRewardData> rewardHistoryDataList=[];
class RewardHistoryScreen extends StatefulWidget {
  RewardHistoryScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RewardHistoryScreenState createState() => _RewardHistoryScreenState();
}

class _RewardHistoryScreenState extends State<RewardHistoryScreen> {

  List<String> companies;
  GlobalKey<RefreshIndicatorState> refreshKey;

  Random r;


  var db = new Mysql();

  void _getRewards() {
    rewardHistoryDataList.clear();
    db.getConnection().then((conn) {
      String sqlQuery = "SELECT Rewards_Name,Redeem_Code,Redeem_Date,Redeem_Status,Expired_Date FROM Rewards,Reward_Detail WHERE Rewards.Rewards_Id=Reward_Detail.Rewards_Id AND Reward_Detail.Customers_Id='CSM1' AND Expired_Date> CURRENT_DATE()";

      conn.query(sqlQuery).then((results) {
        print('${results}');
        for (var row in results) {
          classRewardData rw = new classRewardData();

          rw.rewardsName = row[0];
          rw.redeemCode = row[1];
          rw.redeemDate = row[2];
          rw.redeemStatus = row[3];
          rw.expiryDate = row[4];

          rewardHistoryDataList.add(rw);
        }
        setState(() {
          rewardList();
        });
      });
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

  Widget rewardList() {
    return Scaffold(

      body: ListView.builder(itemCount: rewardHistoryDataList.length,

          itemBuilder: (context, index) {
            return Slidable(

              actionPane: SlidableStrechActionPane(),
              actionExtentRatio: 0.3,

              child: Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),

                decoration: BoxDecoration(

                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10)
                  ),

                ),

                child: GestureDetector(
                  onTap: () => print(rewardHistoryDataList[index]),
                  child: Card(
                    elevation: 5,
                    child: Container(

                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),

                      height: 150.0,
                      child: Row(
                        children: <Widget>[

                          Container(
                            height: 100.0,
                            width: 100.0,
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            decoration: BoxDecoration(

                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10)
                                ),

                                image: DecorationImage(

                                    fit: BoxFit.cover,

                                    image: NetworkImage(
                                        "https://img.freepik.com/free-vector/christmas-new-year-s-day-red-gift-box-white-background-illustration_164911-157.jpg?size=626&ext=jpg")

                                )
                            ),
                          ),

                          Container(
                            height: 120.0,
                            width: 230.0,
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 10, bottom: 10),
                            decoration: BoxDecoration(

                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  topLeft: Radius.circular(10)
                              ),

                            ),

                            child: Column(

                              children: <Widget>[

                                Align(


                                  child: Text(
                                    'Reward Name   : ${getWidgetRewardHistory(rewardHistoryDataList)[index]["Rewards_Name"]}',
                                    style: TextStyle(fontSize: 16),),
                                  alignment: Alignment.centerLeft,

                                ),

                                SizedBox(height: 5,),

                                Align(


                                  child: Text(
                                      'Redeem Point   : ${getWidgetRewardHistory(rewardHistoryDataList)[index]["Redeem_Date"].toString().substring(0,10)}',
                                      style: TextStyle(fontSize: 16)),
                                  alignment: Alignment.centerLeft,

                                ),

                                SizedBox(height: 5,),

                                Align(


                                  child: Text(
                                      'Redeem Status   : ${getWidgetRewardHistory(rewardHistoryDataList)[index]["Redeem_Status"]}',
                                      style: TextStyle(fontSize: 16)),
                                  alignment: Alignment.centerLeft,

                                ),

                                SizedBox(height: 5,),

                                Align(


                                  child: Text(
                                      'Expired_Date       : ${getWidgetRewardHistory(rewardHistoryDataList)[index]["Expired_Date"].toString().substring(0,10)}',
                                      style: TextStyle(fontSize: 16)),
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

              secondaryActions: <Widget>[

                IconSlideAction(

                  caption: 'CODE ${getWidgetRewardHistory(rewardHistoryDataList)[index]["Redeem_Code"]}',
                  color: Colors.green,
                  icon: FontAwesomeIcons.code,

                ),

              ],


            );
          }),

    );
  }
}


List getWidgetRewardHistory(List<classRewardData> list){

  List _list =[];
  for(int i=0;i<list.length;i++){
    _list.add({


      'Rewards_Name':'${list[i].rewardsName}',
      'Redeem_Code':'${list[i].redeemCode}',
      'Redeem_Date':'${list[i].redeemDate}',
      'Redeem_Status':'${list[i].redeemStatus}',
      'Expired_Date':'${list[i].expiryDate}',

    });
  }
  return _list;
}



