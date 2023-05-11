import 'package:collegeproject/View/Drawer%20Pages/setting.dart';
import 'package:collegeproject/View/upi.dart';
import 'package:collegeproject/utilities/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Drawer Pages/home.dart';
import 'Drawer Pages/profile.dart';

class Draw extends StatefulWidget {
  const Draw({Key? key}) : super(key: key);

  @override
  State<Draw> createState() => _DrawState();
}

class _DrawState extends State<Draw> {
  @override
  Widget build(BuildContext context) {
    Authorization auth = Authorization();
    final user = FirebaseAuth.instance.currentUser!;

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Padding(
              padding: EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 60,
                    child: CircleAvatar(
                        backgroundImage: NetworkImage(user.photoURL!)),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    user.displayName!,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    user.email!,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              }),
          ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
              }),
          ListTile(
              leading: Icon(Icons.settings),
              title: Text('Setting'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Setting()));
              }),
          Divider(
            height: 1,
          ),
          ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () async {
                //await auth.logout();
                final provider =
                    Provider.of<Authorization>(context, listen: false);
                provider.logout();
                //auth.logout();
                // Navigator.pop(context);
                // Navigator.pushReplacement(context,
                //     MaterialPageRoute(builder: (context) => MyHomePage()));
              }),
          Divider(
            height: 1,
          ),
          // ListTile(
          //     leading: Icon(Icons.exit_to_app),
          //     title: Text('UPI'),
          //     onTap: () async {
          //       Navigator.push(
          //           context, MaterialPageRoute(builder: (context) => Upi()));
          //     })
        ],
      ),
    );
  }
}
