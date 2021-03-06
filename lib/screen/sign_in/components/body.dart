import 'package:favorite/components/no_account_text.dart';
import 'package:favorite/components/socal_card.dart';
import 'package:favorite/size_config.dart';
import 'package:favorite/viewmodel/sign_in/sign_in_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'sign_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SignInModel signInModel = Provider.of<SignInModel>(context, listen: true);
    return SingleChildScrollView(
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
            ),
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "メールアドレスとパスワードを入力してください。",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                SignForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                Text("他のアカウントでログインする"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocalCard(
                      icon: 'assets/icons/google_icon.png',
                      press: () {
                        signInModel.googleLogin();
                      },
                    ),
                    // SocalCard(
                    //   icon: "assets/icons/facebook-2.svg",
                    //   press: () {},
                    // ),
                    // SocalCard(
                    //   icon: 'assets/icons/twitter.svg',
                    //   press: () {},
                    // ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
