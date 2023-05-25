import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/models/order_model.dart';
import 'package:food_app/providers/order_provider.dart';
import 'package:provider/provider.dart';

class MyOrder extends StatefulWidget {
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  OrderProvider orderProvider;

  showAlertDialog(BuildContext context, OrderModel data) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Order details"),
      content: ListView.builder(
          itemCount: data.orderList.length,
          itemBuilder: (context, index) {
            var orderImage = data.orderList[index]['orderImage'];
            var orderName = data.orderList[index]['orderName'];
            var orderPrice = data.orderList[index]['orderPrice'];
            var orderQuantity = data.orderList[index]['orderQuantity'];
            return Row(
              children: [
                Expanded(
                    child: Container(
                  height: 90,
                  child: Center(child: Image.network(orderImage)),
                )),
                Expanded(
                    child: Container(
                  height: 90,
                  child: Column(
                    children: [
                      Text(
                        orderName,
                        style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        "${orderPrice}\$",
                        style: TextStyle(
                            color: textColor, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${orderQuantity}\$",
                        style: TextStyle(
                            color: textColor, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ))
              ],
            );
          }),
      actions: [
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    orderProvider = Provider.of(context);
    orderProvider.getOrders();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Orders",
          style: TextStyle(color: textColor, fontSize: 18),
        ),
      ),
      body: ListView.builder(
        itemCount: orderProvider.getOrderList.length,
        itemBuilder: (context, index) {
          OrderModel data = orderProvider.getOrderList[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$${data.total.toString()}"),
                    Text(DateTime.fromMillisecondsSinceEpoch(
                            data.orderList[0]['orderTime'].seconds * 1000)
                        .toString()),
                    MaterialButton(
                      onPressed: () {
                        showAlertDialog(context, data);
                      },
                      child: Text(
                        "View",
                        style: TextStyle(color: textColor),
                      ),
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
