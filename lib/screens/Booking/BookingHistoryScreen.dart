
import 'dart:math';

import 'package:client_car_service_system/components/Navigation/AppBarComponents.dart';
import 'package:client_car_service_system/components/Other%20Components/ConnectionMySql.dart';
import 'package:client_car_service_system/models/Booking/classBookingData.dart';
import 'package:client_car_service_system/models/Reward/classRewardData.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



List<classBookingData> bookingHistoryDataList=[];
class BookingHistoryScreen extends StatefulWidget {
  BookingHistoryScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BookingHistoryScreenState createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {

  List<String> companies;
  GlobalKey<RefreshIndicatorState> refreshKey;

  Random r;


  var db = new Mysql();

  void _getBooking() {
    bookingHistoryDataList.clear();
    db.getConnection().then((conn) {
      String sqlQuery = "SELECT BK.Booking_Id FROM Customers CSM, Booking BK WHERE CSM.Customers_Id=BK.Customers_Id AND CSM.Customers_Id='CSM1'";

      conn.query(sqlQuery).then((results) {
        print('${results}');
        for (var row in results) {
          classBookingData bk = new classBookingData();

          bk.bookingId = row[0];

          bookingHistoryDataList.add(bk);
        }
        setState(() {
          bookingHistoryList();
        });
      });
      conn.close();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBooking();
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    _getBooking();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    AppBarData _appBarData = new AppBarData('Reward History', null);

    return Scaffold(

      appBar: AppBarTitle(_appBarData),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {
          await refreshList();
        },
        child: bookingHistoryList(),
      ),

    );
  }

  Widget bookingHistoryList() {
    return Scaffold(


      body: ExpandableTheme(
        data:
        const ExpandableThemeData(
          iconColor: Colors.orange,
          useInkWell: true,
        ),


        child:  ListView.builder(itemCount:bookingHistoryDataList.length,

            itemBuilder: (context, index) {

              return ExpandableNotifier(

                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Card(

                      elevation: 5,

                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 100,
                            child: Container(

                              child: Row(
                                children: <Widget>[

                                  Container(
                                    width: 250,
                                    height: 100,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(20, 2, 0, 0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: <Widget>[

                                          SizedBox(height: 8,),

                                          Text(
                                            "fds ",
                                            style: TextStyle(fontSize: 20),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 6, 0, 2),
                                            child: Container(

                                              child: Text(
                                                "dfs",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 48, 48, 54)
                                                ),),

                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 0, 2),
                                            child: Container(

                                              child: Text(
                                                "dsf ",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 48, 48, 54)
                                                ),),

                                            ),
                                          ),

                                        ],

                                      ),
                                    ),
                                  ),

                                  Container(

                                    child: Row(

                                      children: [
                                        Container(
                                          width: 80,
                                          height: 50,
                                          decoration: BoxDecoration(

                                              border: Border.all(color: Colors.orange,width: 2),
                                              borderRadius: BorderRadius.all(Radius.circular(5))
                                          ),
                                          child: Align(

                                            child: ButtonTheme(

                                              minWidth: 500.0,
                                              height: 50.0,

                                              child: RaisedButton(

                                                textColor: Colors.black,
                                                color:Colors.white,
                                                splashColor: Colors.orangeAccent,

                                                child: Text('Pay'),
                                                onPressed: () {


                                                },

                                              ),
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
                          ScrollOnExpand(
                            scrollOnExpand: true,
                            scrollOnCollapse: false,
                            child: ExpandablePanel(
                              theme: const ExpandableThemeData(
                                headerAlignment: ExpandablePanelHeaderAlignment.center,
                                tapBodyToCollapse: true,
                              ),
                              header: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "Payment Details",
                                    style: Theme.of(context).textTheme.body2,
                                  )),
                              collapsed: RichText(

                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,

                                text: TextSpan(
                                  // Note: Styles for TextSpans must be explicitly defined.
                                  // Child text spans will inherit styles from parent
                                  style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(text: 'Total ',style: TextStyle(fontWeight: FontWeight.bold),),
                                    TextSpan(text: '(incl. VAT)                                             ', ),
                                    TextSpan(text: 'RM sfd', style:  TextStyle(fontWeight: FontWeight.bold)),
                                  ],


                                ),
                              ),
                              expanded: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[



                                  Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Row(

                                        children: <Widget>[

                                          Text(
                                            'd',
                                            softWrap: true,
                                            overflow: TextOverflow.fade,
                                          ),

                                          SizedBox(width: 190,),
                                          Container(

                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child:  Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[

                                                    Text("RM 10000.00"),


                                                  ],

                                                )
                                            ),

                                          ),


                                        ],

                                      )

                                  ),

                                  RichText(

                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,

                                    text: TextSpan(
                                      // Note: Styles for TextSpans must be explicitly defined.
                                      // Child text spans will inherit styles from parent
                                      style: new TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(text: 'Total ',style: TextStyle(fontWeight: FontWeight.bold),),
                                        TextSpan(text: '(incl. VAT)                                             ', ),
                                        TextSpan(text: 'RM fds', style:  TextStyle(fontWeight: FontWeight.bold)),
                                      ],


                                    ),
                                  ),

                                ],
                              ),
                              builder: (_, collapsed, expanded) {
                                return Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                  child: Expandable(
                                    collapsed: collapsed,
                                    expanded: expanded,
                                    theme: const ExpandableThemeData(crossFadePoint: 0),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              );

            }),
      ),
    );
  }
}


List getWidgetBookingHistory(List<classBookingData> list){

  List _list =[];
  for(int i=0;i<list.length;i++){
    _list.add({


      'Booking_Id':'${list[i].bookingId}',
    });
  }
  return _list;
}



