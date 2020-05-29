import 'package:complex_ui/presentation/assets/dimensions.dart';
import 'package:complex_ui/presentation/navigation/navigation.dart';
import 'package:complex_ui/presentation/widgets/platform_aware_button.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(marginScreen),
              child: SafeArea(
                child: PlatformAwareButton(
                  text: "Login",
                  onPressed: () {
                    navigateToIntro(context);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
