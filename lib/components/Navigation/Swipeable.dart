import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SwipeableData{

  String appBarTitle;
  String tab1;
  String tab2;
  Widget firstPage;
  Widget secondPage;

  SwipeableData(this.appBarTitle,this.tab1,this.tab2,this.firstPage,this.secondPage);

}

Widget Swipeable(SwipeableData SwipealeData,BuildContext context){


  return MaterialApp(

    home: DefaultTabController(

      length: 2,
      child: Scaffold(

        appBar: AppBar(

          backgroundColor: Colors.orange,

          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),

              onPressed: (){

                Navigator.pop(context);

              },
              //back button

          ),

          bottom: TabBar(
            physics: NeverScrollableScrollPhysics(),
            dragStartBehavior: DragStartBehavior.down,

            tabs: [

              Tab(text: SwipealeData.tab1),
              Tab(text: SwipealeData.tab2),

            ],
            labelColor: Colors.white,
            indicatorColor: Colors.white,

          ),
          title: Text(SwipealeData.appBarTitle),

        ),
        body: TabBarView(
          children: [

            SwipealeData.firstPage,
            SwipealeData.secondPage

          ],
        ),
      ),
    ),

  );
}