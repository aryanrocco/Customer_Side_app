import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../upi.dart';

class Restaurant extends StatefulWidget {
  const Restaurant({Key? key}) : super(key: key);

  @override
  State<Restaurant> createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
  String city = " ";
  bool state = false;
  String pinCode = " ";
  TextEditingController amountController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      city = prefs.getString('city')!;
      pinCode = prefs.getString('pinCode')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    var W = context.safePercentWidth;
    var H = context.safePercentHeight;
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Restaurant')
              .where(
                'city',
                isEqualTo: city,
              )
              .where('pincode', isEqualTo: pinCode)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              print("ha mai chlra huuu");
              final respDocs = snapshot.data!.docs;

              return ListView.builder(
                  itemCount: respDocs.length,
                  itemBuilder: (context, index) {
                    Future<void> openMap(
                        double latitude, double longitude) async {
                      String googleUrl =
                          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

                      await launch(googleUrl);
                    }

                    Future<void> _makePhoneCall(String url) async {
                      await launch(url);
                    }

                    var k = respDocs[index]['phoneno'];
                    bool ok = respDocs[index]['status'];
                    return Card(
                      elevation: 5,
                      //color: Colors.grey,
                      //margin: EdgeInsets.all(10),
                      child: Container(
                        padding: EdgeInsets.all(W * 2),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(respDocs[index]['name'])
                                          .text
                                          .xl2
                                          .bold
                                          .make(),
                                      Row(
                                        children: [
                                          "Available Tables : ".text.make(),
                                          Text(respDocs[index]['tables'])
                                              .text
                                              .green400
                                              .make(),
                                        ],
                                      ),
                                      HeightBox(20),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                openMap(
                                                    respDocs[index]['latitude'],
                                                    respDocs[index]
                                                        ['longitude']);
                                              },
                                              icon: Icon(Icons.directions)),
                                          IconButton(
                                              onPressed: () {
                                                _makePhoneCall('tel:+91$k');
                                              },
                                              icon: Icon(Icons.phone)),
                                          IconButton(
                                              onPressed: () {
                                                respDocs[index]['upi'] != ""
                                                    ? showDialog<void>(
                                                        context: context,
                                                        barrierDismissible:
                                                            true, // user must tap button!
                                                        builder: (BuildContext
                                                            context) {
                                                          return Form(
                                                            key: formKey,
                                                            child: AlertDialog(
                                                              title: const Text(
                                                                  'Enter Amount'),
                                                              content:
                                                                  TextFormField(
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return 'Please enter amount';
                                                                  } else if (value ==
                                                                      "0") {
                                                                    return " please enter amount other than 0";
                                                                  }
                                                                  return null;
                                                                },
                                                                controller:
                                                                    amountController,
                                                              ),
                                                              actions: <Widget>[
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () async {
                                                                    if (formKey
                                                                        .currentState!
                                                                        .validate()) {
                                                                      await Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => Upi(
                                                                                    name: respDocs[index]['name'],
                                                                                    upiId: respDocs[index]['upi'],
                                                                                    amount: double.parse(amountController.text),
                                                                                  )));
                                                                      amountController
                                                                          .clear();
                                                                      Navigator.pop(
                                                                          context);
                                                                    }
                                                                  },
                                                                  child: const Text(
                                                                      'Submit'),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      )
                                                    : showDialog<void>(
                                                        context: context,
                                                        barrierDismissible:
                                                            true, // user must tap button!
                                                        builder: (BuildContext
                                                            context) {
                                                          return Form(
                                                            key: formKey,
                                                            child: AlertDialog(
                                                              title: const Text(
                                                                  'This merchant has not updated his upi id'),
                                                            ),
                                                          );
                                                        },
                                                      );
                                              },
                                              icon: Icon(Icons.currency_rupee)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        "Status : ".text.make(),
                                        if (state == ok)
                                          "Off".text.red400.bold.make()
                                        else
                                          "On".text.green400.bold.make()
                                      ],
                                    ),
                                    HeightBox(10),
                                    respDocs[index]['piclink'] != null
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            child: Image.network(
                                              respDocs[index]['piclink'],
                                              scale: 2,
                                              height: H * 20,
                                              width: W * 20,
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            child: Image.asset(
                                              "assets/logos/download.jfif",
                                              scale: 2,
                                              height: H * 20,
                                              width: W * 20,
                                            ),
                                          ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
