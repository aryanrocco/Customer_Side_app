import 'package:collegeproject/View/Drawer.dart';
import 'package:collegeproject/View/dropdown/hospital.dart';
import 'package:collegeproject/View/dropdown/shop.dart';
import 'package:collegeproject/View/dropdown/welcome.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dropdown/restaurant.dart';
import '../info.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future checkFirst() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    if (_seen) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Home()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Info()));
    }
  }

  bool state = false;
  String dropdownvalue = "Please Select an Option";

  @override
  Widget build(BuildContext context) {
    //checkFirst();
    var W = context.safePercentWidth;
    var H = context.safePercentHeight;

    return Scaffold(
      appBar: AppBar(
        title: "Home".text.make(),
      ),
      drawer: Draw(),
      body: Container(
        padding: EdgeInsets.all(H * 2),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              value: dropdownvalue,
              isExpanded: true,
              items: <String>['Please Select an Option', 'Hospitals', 'Shops','Restaurants']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, textAlign: TextAlign.center),
                );
              }).toList(),
              //hint: "Please Choose an Option".text.bold.make(),
              onChanged: (String? value) {
                setState(() {
                  dropdownvalue = value!;
                });
              },
            ),
            if (dropdownvalue == "Shops")
              Shop()
            else if (dropdownvalue == "Hospitals")
              Hospital()
            else if (dropdownvalue == 'Restaurants')
              Restaurant()
            else
              Welcome()
            //shop
          ],
        ),
      ),
    );
  }
}
