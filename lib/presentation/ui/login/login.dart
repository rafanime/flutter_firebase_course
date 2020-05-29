import 'package:complex_ui/data/services/authService.dart';
import 'package:flutter/material.dart';

import '../../navigation/navigation.dart';
import '../../widgets/platform_aware_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PlatformAwareButton(
                text: 'Log in',
                onPressed: () async {
                  if (await AuthService().signInWithGoogle() != null) {
                    navigateToIntro(context);
                  }
                })
          ],
        ),
      ),
    );
  }
}
