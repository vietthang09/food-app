import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/models/delivery_address_model.dart';
import 'package:food_app/providers/check_out_provider.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:food_app/screens/check_out/delivery_details/single_delivery_item.dart';
import 'package:food_app/screens/check_out/payment_summary/my_google_pay.dart';
import 'package:food_app/screens/check_out/payment_summary/order_item.dart';
import 'package:provider/provider.dart';

class PaymentSummary extends StatefulWidget {
  final DeliveryAddressModel deliverAddressList;
  PaymentSummary({this.deliverAddressList});

  @override
  _PaymentSummaryState createState() => _PaymentSummaryState();
}

enum AddressTypes {
  Home,
  OnlinePayment,
}

class _PaymentSummaryState extends State<PaymentSummary> {
  var myType = AddressTypes.Home;

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();

    double discount = 10;
    double discountValue = 0.0;
    double shippingChanrge = 5.0;
    double total = 0.0;
    double totalPrice = reviewCartProvider.getTotalPrice();
    if (totalPrice > 300) {
      discountValue = (totalPrice * discount) / 100;
      total = totalPrice - discountValue;
      total = (total + (total / 100) * shippingChanrge).roundToDouble();
    } else {
      total =
          (totalPrice + (totalPrice / 100.0) * shippingChanrge).roundToDouble();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment Summary",
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: ListTile(
        title: Text("Total Amount"),
        subtitle: Text(
          "\$$total",
          style: TextStyle(
            color: Colors.green[900],
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        trailing: Container(
          width: 160,
          child: MaterialButton(
            onPressed: () {
              myType == AddressTypes.OnlinePayment
                  ? Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MyGooglePay(
                          oderItemList:
                              reviewCartProvider.getReviewCartDataList,
                          shipping: shippingChanrge,
                          total: total,
                        ),
                      ),
                    )
                  : CheckoutProvider().addPlaceOderData(
                      context: context,
                      oderItemList: reviewCartProvider.getReviewCartDataList,
                      shipping: shippingChanrge,
                      subTotal: total);
            },
            child: Text(
              "Pleace Order",
              style: TextStyle(
                color: textColor,
              ),
            ),
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SingleDeliveryItem(
                  address:
                      "aera, ${widget.deliverAddressList.aera}, street, ${widget.deliverAddressList.street}, society ${widget.deliverAddressList.scoirty}, pincode ${widget.deliverAddressList.pinCode}",
                  title:
                      "${widget.deliverAddressList.firstName} ${widget.deliverAddressList.lastName}",
                  number: widget.deliverAddressList.mobileNo,
                  addressType: widget.deliverAddressList.addressType ==
                          "AddressTypes.Home"
                      ? "Home"
                      : widget.deliverAddressList.addressType ==
                              "AddressTypes.Other"
                          ? "Other"
                          : "Work",
                ),
                Divider(),
                ExpansionTile(
                  children: reviewCartProvider.getReviewCartDataList.map((e) {
                    return OrderItem(
                      e: e,
                    );
                  }).toList(),
                  title: Text(
                      "Order Items ${reviewCartProvider.getReviewCartDataList.length}"),
                ),
                Divider(),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Sub Total",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    "\$$totalPrice",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Shipping",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: Text(
                    "\$${((total / 100) * shippingChanrge).roundToDouble()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Compen Discount",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: Text(
                    "\$$discountValue",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Text("Payment Options"),
                ),
                RadioListTile(
                  value: AddressTypes.Home,
                  groupValue: myType,
                  title: Text("Home"),
                  onChanged: (AddressTypes value) {
                    setState(() {
                      myType = value;
                    });
                  },
                  secondary: Icon(
                    Icons.work,
                    color: primaryColor,
                  ),
                ),
                RadioListTile(
                  value: AddressTypes.OnlinePayment,
                  groupValue: myType,
                  title: Text("Online Payment"),
                  onChanged: (AddressTypes value) {
                    setState(() {
                      myType = value;
                    });
                  },
                  secondary: Icon(
                    Icons.devices_other,
                    color: primaryColor,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
