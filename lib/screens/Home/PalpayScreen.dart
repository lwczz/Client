import 'dart:core';


import 'package:client_car_service_system/WebServices/PayPalServices.dart';
import 'package:client_car_service_system/components/Other%20Components/ConnectionMySql.dart';
import 'package:client_car_service_system/models/Account/classAccountData.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// Import webview package
import 'package:webview_flutter/webview_flutter.dart';

import 'TopUpScreenfulScreen.dart';
// Import a custom interface call class



class PalpayScreen extends StatefulWidget {
  // Jump to the transfer parameter of the current payment page, this parameter is a callback method after the current page is closed after a successful payment
  final Function onFinish;

  // The construction method is convenient to pass the parameters of the onFinish method above
  PalpayScreen({this.onFinish});

  @override
  State<StatefulWidget> createState() {
    return PalpayScreenState();
  }
}

class PalpayScreenState extends State<PalpayScreen> {

  var db = new Mysql();

  void update(String topUpValue){

    db.getConnection().then((conn) {

      String sqlQuery = "UPDATE FYP_TEST.Customers SET EWallet=EWallet+${double.parse(topUpValue)} WHERE Customers_Id='CSM1'";

      conn.query(sqlQuery);

      conn.close();
    });

  }

  // The key of the global ScaffoldState, it is convenient to call the showSnackBar method to display the prompt information later
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // This is the checkoutUrl obtained by paypal, which is the address of the user authorized payment page.
  // ill be displayed in the webview to allow users to operate and agree to authorize payment
  String checkoutUrl;

  // The dynamic address that is returned after the order is successfully created to perform the real deduction
  String executeUrl;

  // The outh2 password accessToken of this paypal (backend calls can not be used here)
  String accessToken;

  // Initialize the service class that calls the (backend) interface
  PalpayServices services = new PalpayServices();

  // Define a default currency type, you can modify it according to your needs
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "MYR ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "MYR"
  };

  // Whether to support mailing, if false, the mailing address parameter will not be passed
  bool isEnableShipping = false;
  bool isEnableAddress = false;

  // Define a return address after the user authorizes the payment, you can write it here,
  // paypal will redirect to the changed address after the user carries the PayerID to the address after unified payment,
  // We are only used to capture the address in the webview to get the PayerID
  String returnURL = 'return.paypal.lyscms.com';
  // The address returned after the user canceled the authorization payment on the authorization page (checkoutUrl address page)
  String cancelURL = 'cancel.paypal.lyscms.com';

  String _getTopUpValue="";

  @override
  void initState() {
    super.initState();

    // After entering the page, initialize the asynchronous call (back-end) interface
    Future.delayed(Duration.zero, () async {

      try {

        final classAccountEwalletData _classAccountEwalletData = ModalRoute.of(context).settings.arguments;
          _getTopUpValue=_classAccountEwalletData.eWallet;
        // 1. Calling the (backend) interface to get the accessToken is actually calling the paypal interface：/v1/oauth2/token?grant_type=client_credentials
        accessToken = await services.getAccessToken();
        if (accessToken != null) {
          // 2. Ready to create the parameter data of the paypal payment order interface, call the (backend) interface to create the paypal payment order,
          // Actually call the paypal interface: /v1/payments/payment


          final transactions = getOrderParams(_classAccountEwalletData.eWallet);
          final res = await services.createPaypalPayment(transactions, accessToken);
          // 3. After the payment order is created successfully, it will return to the page address that agrees to authorize the payment approvalUrl
          // Assign value to the checkoutUrl parameter defined above and the payment address executeUrl that performs the deduction
          if (res != null) {
            setState(() {
              checkoutUrl = res["approvalUrl"];
              executeUrl = res["executeUrl"];
            });
          }
        } else {
          // Prompt to get AccessToken failed, and close the current payment page and return to the previous page (enter the previous page of the current page)
          print('Get an access token fail: $accessToken');
          Fluttertoast.showToast(msg: 'Get an access token fail: $accessToken')
              .then((value) => Navigator.of(context).pop());
        }
      } catch (e) {
        // Prompt message after an exception occurs when obtaining AccessToken or creating an order
        print('exception: ' + e.toString());

        // SnackBar prompt at the bottom
        final snackBar = SnackBar(
          content: Text(e.toString()),

          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Click to confirm the failure message and return to the previous page
              Navigator.pop(context);
            },
          ),
        );
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    });
  }

  // The name, price, and quantity of the simulated payment product item (modified to your official product parameters)





  // 定义上面第2步调用的创建订单的准备参数
  Map<String, dynamic> getOrderParams(String topUpValue) {

    String itemName = 'Top Up';
    String itemPrice =topUpValue.toString();
    int quantity = 1;

    // 商品列表项，这里就模拟一个，正式的时候自行修改为多个动态传参数(可以是你的购物车列表数据)
    List items = [
      {"name": itemName, "quantity": quantity, "price": itemPrice, "currency": defaultCurrency["currency"]}
    ];


    // Simulation defines the detailed information data of the order parameter creation,
    // paypal official website has more details
    // Total price
    String totalAmount = topUpValue.toString();
    // Subtotal
    String subTotalAmount = topUpValue.toString();
    // Shipping Fee
    String shippingCost = '0';
    // Shipping Discount Fee
    int shippingDiscountCost = 0;
    // UserName
    String userFirstName = 'Gulshan';
    String userLastName = 'Yadav';

    // Prepare data for simulated mailing address information
    String addressCity = 'Delhi';
    String addressStreet = 'Mathura Road';
    String addressZipCode = '110014';
    String addressCountry = 'India';
    String addressState = 'Delhi';
    String addressPhoneNumber = '+919990119091';

    // Simulate definition to create the order map parameter object data, which can be modified according to the interface parameter description
    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount,
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": subTotalAmount,
              "shipping": shippingCost,
              "shipping_discount": ((-1.0) * shippingDiscountCost).toString()
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {"allowed_payment_method": "INSTANT_FUNDING_SOURCE"},
          "item_list": {
            "items": items,
            if (isEnableShipping && isEnableAddress)
              "shipping_address": {
                "recipient_name": userFirstName + " " + userLastName,
                "line1": addressStreet,
                "line2": "",
                "city": addressCity,
                "country_code": addressCountry,
                "postal_code": addressZipCode,
                "phone": addressPhoneNumber,
                "state": addressState
              },
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  @override
  Widget build(BuildContext context) {



    // Determine whether the return authorization page address is empty after the successful creation of the order in step 2 asynchronously. If it is not empty, the creation is successful.
    // 4. Use webview to open this checkoutUrl authorization page to show the user to agree to the payment operation
    if (checkoutUrl != null) {
      return Scaffold(

        // 设置顶部appbar参数
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context),
          ),
        ),
        // The content part is directly a webview Widget widget
        body: WebView(
          // The authorization payment page address obtained asynchronously in the previous initialization method
          initialUrl: checkoutUrl,
          // Set JavascriptMode to unrestricted
          javascriptMode: JavascriptMode.unrestricted,
          // Route jump delegation (proxy interception), in fact, it will enter this method when the webview currently has an address redirection jump
          navigationDelegate: (NavigationRequest request) {
            classAccountEwalletData _topUpValue=new classAccountEwalletData();
            _topUpValue.eWallet=_getTopUpValue;


            // Here to determine if the jump address is defined when we created the order earlier
            // The return address that agrees to authorize payment indicates that the user has agreed to authorize
            if (request.url.contains(returnURL)) {
              final uri = Uri.parse(request.url);
              final payerID = uri.queryParameters['PayerID'];
              if (payerID != null) {
                // We can get the PayerID of the request parameter of the return address that jumped back,
                // And get the execution deduction executeUrl after successfully creating the order before
                // 5. Call the (backend) interface address to perform deduction
                services.executePayment(executeUrl, payerID, accessToken)
                    .then((id) {
                  // Call back the construction method of this page, pass the parameter payment id, return to the previous page for subsequent processing,
                  // Such as: call the back-end interface to modify our order status to be paid and show that the payment is successful
                  widget.onFinish(id);
                  Navigator.push(context,MaterialPageRoute(builder: (context) => TopUpSuccessfulScreen(),settings: RouteSettings(arguments: _topUpValue)),);

                });
              } else {
                // Return to the previous page if payment fails
                Navigator.push(context,MaterialPageRoute(builder: (context) => TopUpSuccessfulScreen(),settings: RouteSettings(arguments: _topUpValue)),);
              }
              // Return to the previous page if payment fails
              Navigator.push(context,MaterialPageRoute(builder: (context) => TopUpSuccessfulScreen(),settings: RouteSettings(arguments: _topUpValue)),);
              update(_getTopUpValue);
            }
            // 跳转地址是我们之前创建订单定义的取消地址则直接返回上一个页面并显示支付失败
            if (request.url.contains(cancelURL)) {
              Navigator.of(context).pop();
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    } else {
      // The initialization method is before loading is complete (checkoutUrl is empty) and return to loading
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: Center(child: Container(child: CircularProgressIndicator())),
      );
    }
  }
}