import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/models/order_model.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> orderList = [];
  void getOrders() async {
    List<OrderModel> newList = [];

    QuerySnapshot reviewCartValue = await FirebaseFirestore.instance
        .collection("Order")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("MyOrders")
        .get();
    reviewCartValue.docs.forEach((element) {
      OrderModel reviewCartModel = OrderModel(
          orderList: element.get("orderItems"),
          shipping: element.get("Shipping"),
          total: element.get("Total"));
      newList.add(reviewCartModel);
    });
    orderList = newList;
    notifyListeners();
  }

  List<OrderModel> get getOrderList {
    return orderList;
  }
}
