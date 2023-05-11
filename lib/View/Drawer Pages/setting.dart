import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final user = FirebaseAuth.instance.currentUser!;
  TextEditingController Cuty = TextEditingController();
  TextEditingController PinCude = TextEditingController();

  @override
  void initState() {
    gitData();
  }

  String city = " ";
  String pinCode = " ";

  gitData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      city = prefs.getString('city')!;
      pinCode = prefs.getString('pinCode')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageProfile(),
            Text(
              user.displayName!,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: Cuty,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueAccent,
                    width: 2,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.location_city,
                  color: Colors.blue,
                ),
                labelText: city,
                // helperText: "Write Your Current Location",
                //hintText: 'Mumbai',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: PinCude,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueAccent,
                    width: 2,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.pin,
                  color: Colors.blue,
                ),
                labelText: pinCode,
                // helperText: "Pincode",
                // hintText: '440035',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {},
                  child: Text(
                    'CANCEL',
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 2.2,
                      color: Colors.black,
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: () async {
                    setState(() async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('city', Cuty.text);
                      prefs.setString('pinCode', PinCude.text);
                    });
                  },
                  color: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                        fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(user.photoURL!),
          )),
    );
  }

  Widget pincodeTextField() {
    return TextFormField(
      controller: PinCude,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blueAccent,
            width: 2,
          ),
        ),
        prefixIcon: Icon(
          Icons.pin,
          color: Colors.blue,
        ),
        labelText: pinCode,
        // helperText: "Pincode",
        // hintText: '440035',
      ),
    );
  }

  Widget locationTextField() {
    return TextFormField(
      controller: Cuty,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blueAccent,
            width: 2,
          ),
        ),
        prefixIcon: Icon(
          Icons.location_city,
          color: Colors.blue,
        ),
        labelText: city,
        // helperText: "Write Your Current Location",
        //hintText: 'Mumbai',
      ),
    );
  }
}
