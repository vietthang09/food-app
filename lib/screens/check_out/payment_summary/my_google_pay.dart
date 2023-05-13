import 'package:flutter/material.dart';
import 'package:food_app/providers/check_out_provider.dart';
import 'package:pay/pay.dart';

class MyGooglePay extends StatefulWidget {
  final total;
  final oderItemList;
  final shipping;
  MyGooglePay({this.oderItemList, this.shipping, this.total});
  @override
  _MyGooglePayState createState() => _MyGooglePayState();
}

const String defaultGooglePayConfigString = '''
  {
    "provider": "google_pay",
    "data": {
      "environment": "TEST",
      "apiVersion": 2,
      "apiVersionMinor": 0,
      "allowedPaymentMethods": [{
        "type": "CARD",
        "tokenizationSpecification": {
          "type": "PAYMENT_GATEWAY",
          "parameters": {
            "gateway": "example",
            "gatewayMerchantId": "gatewayMerchantId"
          }
        },
        "parameters": {
          "allowedCardNetworks": ["VISA", "MASTERCARD"],
          "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
          "billingAddressRequired": true,
          "billingAddressParameters": {
            "format": "FULL",
            "phoneNumberRequired": true
          }
        }
      }],
      "merchantInfo": {
        "merchantId": "BCR2DN4TZKT4DND5",
        "merchantName": "Deli Creations."
      },
      "transactionInfo": {
        "countryCode": "US",
        "currencyCode": "USD"
      }
    }
  }
''';

class _MyGooglePayState extends State<MyGooglePay> {
// In your Widget build() method

// In your Stateless Widget class or State
  void onGooglePayResult(paymentResult) {
    CheckoutProvider().addPlaceOderData(
        context: context,
        oderItemList: widget.oderItemList,
        shipping: widget.shipping,
        subTotal: widget.total);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GooglePayButton(
            paymentConfiguration: PaymentConfiguration.fromJsonString(
                defaultGooglePayConfigString),
            paymentItems: [
              PaymentItem(
                label: 'Total',
                amount: '${widget.total}',
                status: PaymentItemStatus.final_price,
              )
            ],
            type: GooglePayButtonType.pay,
            margin: const EdgeInsets.only(top: 15.0),
            onPaymentResult: onGooglePayResult,
            loadingIndicator: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    ));
  }
}
