import 'package:collegeproject/View/Drawer%20Pages/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'info.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}

class Accha extends StatelessWidget {
  const Accha({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    checkFirst();
    return Container();
  }
}
