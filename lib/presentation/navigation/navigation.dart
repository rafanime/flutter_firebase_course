import 'package:complex_ui/data/local/models/recipee.dart';
import 'package:complex_ui/data/local/repositories/recipee_repository.dart';
import 'package:complex_ui/presentation/ui/app.dart';
import 'package:complex_ui/presentation/ui/home/home_page.dart';
import 'package:complex_ui/presentation/ui/intro/intro_page.dart';
import 'package:flutter/material.dart';

Future<void> navigateToHome(BuildContext context) {
//  return Navigator.of(context).pushReplacementNamed(routeHome);
  return Navigator.of(context).push(PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return HomePage(recipeeRepository: RecipeeRepository());
    },
    transitionDuration: Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return Stack(
        children: <Widget>[
          child,
          SlideTransition(
            position: Tween<Offset>(
              begin: Offset.zero,
              end: Offset(-1, 0),
            ).animate(animation),
            child: IntroPage(),
          ),
        ],
      );
  }
  ));
}

Future<void> navigateToDetail(BuildContext context, Recipe recipe) {
  FocusScope.of(context).requestFocus(FocusNode());
  return Navigator.of(context).pushNamed(routeDetail, arguments: recipe);
}