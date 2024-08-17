import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class MyGooglePay extends StatefulWidget {
  final double total;

  MyGooglePay({required this.total});

  @override
  _MyGooglePayState createState() => _MyGooglePayState();
}

class _MyGooglePayState extends State<MyGooglePay> {
  @override
  Widget build(BuildContext context) {
    return GooglePayButton(
      paymentConfiguration: PaymentConfiguration.fromJsonString(
        'assets/sample_payment_configuration.json'
      ),
      paymentItems: [
        PaymentItem(
          label: 'Total',
          amount: widget.total.toStringAsFixed(2),
          status: PaymentItemStatus.final_price,
        ),
      ],
      onPaymentResult: (paymentResult) {
        print(paymentResult);
      },
      type: GooglePayButtonType.pay,
      theme: GooglePayButtonTheme.dark,
    );
  }
}