import 'package:flutter/material.dart';
import 'package:probitas_app/core/constants/colors.dart';
import 'package:probitas_app/core/utils/config.dart';
import 'package:probitas_app/core/utils/components.dart';
import 'package:probitas_app/features/bottom_navigation.dart';
import '../../../../../core/constants/image_path.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
        body: Stack(children: [
      Positioned(
        top: -40,
        child: Image.asset(ImagesAsset.top_background),
      ),
      Positioned(
        top: 80,
        child: Container(
          width: context.screenWidth(),
          height: 25,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(!isDarkMode
                      ? ImagesAsset.logo_light
                      : ImagesAsset.logo_dark))),
        ),
      ),
      Positioned.fill(
        top: 150,
        child: Column(
          children: [
            Container(
              width: context.screenWidth(),
              height: 240,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage(ImagesAsset.senate_building))),
            ),
            YMargin(40),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Text(
                    "LOGIN",
                    style: Config.b1(context).copyWith(
                        color: !isDarkMode
                            ? ProbitasColor.ProbitasSecondry
                            : ProbitasColor.ProbitasAccent),
                  ),
                ),
              ],
            ),
            YMargin(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Column(children: [
                ProbitasTextFormField(
                  hintText: "Matric Number",
                  inputType: TextInputType.text,
                ),
                YMargin(20),
                ProbitasTextFormField(
                  hintText: "Password",
                  inputType: TextInputType.visiblePassword,
                  obscureText: !visible,
                  suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          visible = !visible;
                        });
                      },
                      child: Icon(
                        !visible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: !isDarkMode
                            ? ProbitasColor.ProbitasSecondry
                            : ProbitasColor.ProbitasAccent,
                      )),
                ),
              ]),
            ),
            YMargin(40),
            ProbitasButton(
              text: "Login",
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => NavController()));
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "Note: Use Matric Number and Password \nfrom your student portal to proceed",
                textAlign: TextAlign.center,
                style: Config.b3(context).copyWith(
                    color: !isDarkMode
                        ? ProbitasColor.ProbitasSecondry
                        : ProbitasColor.ProbitasAccent),
              ),
            )
          ],
        ),
      ),
    ]));
  }
}