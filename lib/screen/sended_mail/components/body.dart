import 'package:favorite/components/default_button.dart';
import 'package:favorite/screen/sign_in/sign_in_screen.dart';
import 'package:favorite/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.2),
        Center(
          child: Image.asset("assets/images/login_success_key.png",
              height: SizeConfig.screenHeight * 0.3),
        ), // 40%
        SizedBox(height: SizeConfig.screenHeight * 0.08),
        Text(
          "メールを送信しました！",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(20),
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        Spacer(flex: 1),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            text: "OK",
            press: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}
