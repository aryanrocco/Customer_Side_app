// ignore_for_file: import_of_legacy_library_into_null_safe, unused_field

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Drawer.dart';

// import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  void initState() {
    getData();
  }

  String city=" ";
  String pinCode=" ";

  getData()async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      city = prefs.getString('city')!;
      pinCode = prefs.getString('pinCode')!;
    });
  }

  final user = FirebaseAuth.instance.currentUser!;
  late File _image;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _getHeader(),
              SizedBox(
                height: 10,
              ),
              _profileName(user.displayName!),
              SizedBox(
                height: 14,
              ),
              _heading('Personal Details'),
              SizedBox(
                height: 6,
              ),
              _detailsCard(),
            ],
          )),
    );
  }

  Widget _getHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(user.photoURL!),
                )),
          ),
        ),
      ],
    );
  }

  Widget _profileName(String name) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80,
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _heading(String heading) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80,
      child: Text(
        heading,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _detailsCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            // row for each details
            ListTile(
              leading: Icon(
                Icons.email,
                color: Colors.blueAccent,
              ),
              title: Text(user.email!),
            ),

            Divider(
              height: 0.2,
              color: Colors.black,
            ),
            ListTile(
              leading: Icon(
                Icons.location_city,
                color: Colors.blueAccent,
              ),
              title: Text(city),
            ),
            Divider(
              height: 0.2,
              color: Colors.black,
            ),

            ListTile(
              leading: Icon(
                Icons.pin,
                color: Colors.blueAccent,
              ),
              title: Text(pinCode),
            ),
          ],
        ),
      ),
    );}
}


