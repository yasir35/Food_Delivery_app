import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/models/delivery_address_model.dart';
import 'package:food_app/providers/check_out_provider.dart';
import 'package:food_app/screens/check_out/add_delivery_address/add_delivery_address.dart';
import 'package:food_app/screens/check_out/delivery_details/single_delivery_item.dart';
import 'package:food_app/screens/check_out/payment_summary/payment_summary.dart';
import 'package:provider/provider.dart';

class DeliveryDetails extends StatefulWidget {
  @override
  _DeliveryDetailsState createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  DeliveryAddressModel? selectedAddress;

  @override
  Widget build(BuildContext context) {
    CheckoutProvider deliveryAddressProvider = Provider.of(context);
    deliveryAddressProvider.getDeliveryAddressData();

    var deliveryAddressList = deliveryAddressProvider.getDeliveryAddressList;

    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Details"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddDeliverAddress(),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 48,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: MaterialButton(
          child: deliveryAddressList.isEmpty
              ? Text("Add new Address")
              : Text("Payment Summary"),
          onPressed: () {
            deliveryAddressList.isEmpty
                ? Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddDeliverAddress(),
                    ),
                  )
                : Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PaymentSummary(
                        deliverAddressList: selectedAddress!,
                      ),
                    ),
                  );
          },
          color: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Deliver To"),
          ),
          Divider(height: 1),
          deliveryAddressList.isEmpty
              ? Center(
                  child: Container(
                    child: Center(
                      child: Text("No Data"),
                    ),
                  ),
                )
              : Column(
                  children: deliveryAddressList.map<Widget>((e) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAddress = e;
                        });
                      },
                      child: SingleDeliveryItem(
                        address:
                            "aera, ${e.aera}, street, ${e.street}, society ${e.scoirty}, pincode ${e.pinCode}",
                        title: "${e.firstName} ${e.lastName}",
                        number: e.mobileNo,
                        addressType: e.addressType == "AddressTypes.Home"
                            ? "Home"
                            : e.addressType == "AddressTypes.Other"
                                ? "Other"
                                : "Work",
                      ),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }
}
