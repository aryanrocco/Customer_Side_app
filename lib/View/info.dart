import 'package:collegeproject/main.dart';
import 'package:collegeproject/utilities/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Drawer Pages/home.dart';
import 'MainPage.dart';

class Info extends StatefulWidget {
  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  TextEditingController City = TextEditingController();
  TextEditingController PinCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //TextField
            SizedBox(
              height: 16,
            ), //SizedBox
            TextField(
              controller: City,
              decoration: InputDecoration(
                  hintText: "City",
                  //labelText: "City",
                  labelStyle:
                      TextStyle(fontSize: 24, color: Colors.black), //TextSytyle
                  border: OutlineInputBorder()), //InputDecoration
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: PinCode,
              decoration: InputDecoration(
                  hintText: "Pin Code",
                  //labelText: "Pin Code",
                  labelStyle:
                      TextStyle(fontSize: 24, color: Colors.black), //TextSytyle
                  border: OutlineInputBorder()), //InputDecoration
            ),
            SizedBox(
              height: 16,
            ),
            MaterialButton(
                color: Colors.red,
                child: Text("Save"),
                onPressed: () async{

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('city', City.text);
                    prefs.setString('pinCode', PinCode.text);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                }),

            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
