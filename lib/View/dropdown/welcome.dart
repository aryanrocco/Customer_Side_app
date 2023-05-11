import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var W = context.safePercentWidth;
    var H = context.safePercentHeight;
    return Column(
       // crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HeightBox(H *33),
          Center(
            child: "WELCOME".text.bold.xl4.make(),
          ),
          HeightBox(H *33),
        ]);
  }
}
