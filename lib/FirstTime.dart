import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'View/MainPage.dart';
import 'View/info.dart';

class FirstTime extends StatefulWidget {
  const FirstTime({Key? key}) : super(key: key);

  @override
  _FirstTimeState createState() => _FirstTimeState();
}

class _FirstTimeState extends State<FirstTime> {


  Future checkFirst() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    if (_seen) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MainPage()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Info()));
    }
  }

  @override
  Widget build(BuildContext context) {
    checkFirst();
    return Container();
  }
}
