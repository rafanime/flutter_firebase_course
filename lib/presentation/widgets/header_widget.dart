import 'dart:async';

import 'package:flutter/material.dart';

class HeaderWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final Color color;

  const HeaderWidget({
    Key key,
    this.title,
    this.subtitle,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );
    Timer(Duration(milliseconds: 25), () => _animationController.forward());
    super.initState();
  }

  void changeAlignment(){

  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(1, 0),
          end: Offset.zero,
        ).animate(_animationController),
        child: RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: widget.title,
                style: Theme.of(context).textTheme.headline1.copyWith(
                  fontWeight: FontWeight.w300,
                  color: widget.color,
                ),
              ),
              TextSpan(
                text: widget.subtitle,
                style: Theme.of(context).textTheme.headline1.copyWith(
                  color: widget.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
