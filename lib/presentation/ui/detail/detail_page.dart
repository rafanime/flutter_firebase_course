import 'dart:async';

import 'package:complex_ui/data/local/models/recipee.dart';
import 'package:complex_ui/presentation/assets/dimensions.dart';
import 'package:complex_ui/presentation/widgets/header_widget.dart';
import 'package:complex_ui/presentation/widgets/platform_aware_button.dart';
import 'package:complex_ui/presentation/widgets/recipe_image.dart';
import 'package:complex_ui/presentation/widgets/user_icon.dart';
import 'package:flutter/material.dart';

class RecipeDetailPage extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailPage({Key key, this.recipe}) : super(key: key);
  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 125)
    );
    Timer(Duration(milliseconds: 200), () => _animationController.forward());
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            _animationController.reverse().then((value) {
              Navigator.of(context).pop();
            });
          },
        ),
        actions: <Widget>[
          FadeTransition(
            opacity: _animationController,
            child: UserIcon(),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Stack(children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: marginScreen,
                right: marginScreen,
                top: marginRecipeTop,
                bottom: marginRecipeBottom
              ),
              child: RecipeNameWidget(
                recipe: widget.recipe,
                animationController: _animationController,
              ),
            ),
            SafeArea(
              child: Hero(
                tag: widget.recipe,
                child: RecipeImage(
                  recipe: widget.recipe,
                ),
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: BottomDetailWidget(
            recipe: widget.recipe,
            animationController: _animationController,
          ),
        )
      ]),
    );
  }
}

class RecipeNameWidget extends StatelessWidget {
  const RecipeNameWidget({
    Key key,
    @required this.recipe,
    @required this.animationController
  }) : super(key: key);

  final Recipe recipe;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(-1, 0),
          end: Offset.zero,
        ).animate(animationController),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HeaderWidget(
              title: "The best\n",
              subtitle: "${recipe.name}",
            ),
            const SizedBox(
              height: marginSmall,
            ),
            Row(
              children: <Widget>[
                StarsWidget(
                  stars: recipe.startCount,
                ),
                const SizedBox(
                  width: marginMini,
                ),
                Text(
                  "${recipe.reviewCount} reviews",
                  style: Theme.of(context).textTheme.bodyText2,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BottomDetailWidget extends StatelessWidget {
  const BottomDetailWidget({
    Key key,
    @required this.animationController,
    @required this.recipe,
  }) : super(key: key);

  final Recipe recipe;
  final AnimationController animationController;


  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(0, 1),
        end: Offset.zero,
      ).animate(animationController),
      child: FadeTransition(
        opacity: animationController,
        child: Container(
          padding: EdgeInsets.all(marginScreen),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(radius),
              topLeft: Radius.circular(radius),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    DetailWidget(
                      text: "${recipe.pieces} pieces",
                      icon: Icons.adjust,
                    ),
                    DetailWidget(
                      text: "${recipe.calories} cal",
                      icon: Icons.add_box,
                    ),
                    DetailWidget(
                      text: "${recipe.minDuration.inMinutes} min",
                      icon: Icons.access_time,
                    ),
                  ],
                ),
                const SizedBox(
                  height: marginItems,
                ),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: PlatformAwareButton(
                          text: "Start cooking",
                          onPressed: () => print("Yay!"),
                        ),
                      ),
                      const SizedBox(
                        width: marginMedium,
                      ),
                      Favorite(),
                    ],
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> with TickerProviderStateMixin {
  AnimationController _colorAnimationController;
  AnimationController _sizeAnimationController;
  Animation _heartAnimation;
  Animation _backgroundAnimation;
  bool _favorite = false;

  @override
  void initState() {
    _colorAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 125)
    );

    _sizeAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
      value: 1.0,
      lowerBound: 1.0,
      upperBound: 1.75,
    );

    _heartAnimation = ColorTween(
      begin: Colors.black,
      end: Colors.red,
    ).animate(_colorAnimationController)..addListener(() {
      setState(() {});
    });

    _backgroundAnimation = ColorTween(
      begin: Colors.white,
      end: Colors.black,
    ).animate(_colorAnimationController)..addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _colorAnimationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: GestureDetector(
        onTap: (){
          _sizeAnimationController.forward().then((value) {
            _favorite
                ? _colorAnimationController.forward()
                : _colorAnimationController.reverse();
          }).then((value) => _sizeAnimationController..reverse());
          _favorite = !_favorite;
        },
        child: Container(
          decoration: BoxDecoration(
            color: _backgroundAnimation.value,
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
            border: Border.all()
          ),
          child: ScaleTransition(
            scale: _sizeAnimationController,
            child: Icon(Icons.favorite,
              color: _heartAnimation.value,
            ),
          ),
        ),
      ),
    );
  }
}


class StarsWidget extends StatelessWidget {
  final int stars;

  const StarsWidget({Key key, this.stars}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<Widget> list = [];
    for (int i = 0; i < 5; i++) {
      if (i < (stars - 1)) {
        list.add(StarWidget(
          isFull: true,
        ));
      } else {
        list.add(StarWidget(
          isFull: false,
        ));
      }
    }
    return Row(
      children: list,
    );
  }
}

class StarWidget extends StatelessWidget {
  final bool isFull;

  const StarWidget({Key key, this.isFull}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      isFull ? Icons.star : Icons.star_border,
      color: Theme.of(context).primaryColor,
      size: iconSmallSize,
    );
  }
}

class DetailWidget extends StatelessWidget {
  final String text;
  final IconData icon;

  const DetailWidget({Key key, this.text, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: Theme.of(context).primaryColor,
          size: iconSize,
        ),
        Text(
          " $text",
          style: Theme.of(context).textTheme.bodyText1,
        )
      ],
    );
  }
}
