import 'package:complex_ui/data/local/repositories/recipee_repository.dart';
import 'package:complex_ui/presentation/assets/dimensions.dart';
import 'package:complex_ui/presentation/navigation/navigation.dart';
import 'package:complex_ui/presentation/widgets/header_widget.dart';
import 'package:complex_ui/presentation/widgets/platform_aware_button.dart';
import 'package:complex_ui/presentation/widgets/recipe_image.dart';
import 'package:complex_ui/presentation/widgets/user_icon.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final RecipeeRepository recipeeRepository;

  HomePage({
    Key key,
    this.recipeeRepository,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: <Widget>[
          UserIcon(),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: marginScreen,
              right: marginScreen,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "User Name",
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(color: Colors.black),
                ),
                Text(
                  "User email",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black),
                ),
                const SizedBox(
                  height: marginText,
                ),
                HeaderWidget(
                  title: "Good ",
                  subtitle: "${_getGreeting()}!",
                  color: Colors.black,
                ),
                const SizedBox(
                  height: marginText,
                ),
                ChipSearchBar(),
                const SizedBox(
                  height: marginItems,
                ),
                RecipeGrid(
                  children: widget.recipeeRepository
                      .getSpecialRecipees()
                      .map((recipe) {
                    return Hero(
                      tag: recipe,
                      child: RecipeImage(
                        recipe: recipe,
                        onClicked: (recipe, context) =>
                            navigateToDetail(context, recipe),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: marginItems,
                ),
              ],
            ),
          ),
          Recommendations(
            children: widget.recipeeRepository
                .getRecommendations()
                .map((recipe) => RecipeImage(
                      recipe: recipe,
                      onClicked: (recipe, context) =>
                          navigateToDetail(context, recipe),
                    ))
                .toList(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(marginScreen),
                child: SafeArea(
                  child: PlatformAwareButton(
                    text: "Log out",
                    onPressed: () {
                      navigateToLogin(context);
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  String _getGreeting() {
    var time = DateTime.now();
    if (time.hour > 3 && time.hour < 12) {
      return "morning";
    } else if (time.hour < 18) {
      return "evening";
    } else {
      return "night";
    }
  }
}

class ChipSearchBar extends StatefulWidget {
  @override
  _ChipSearchBarState createState() => _ChipSearchBarState();
}

class _ChipSearchBarState extends State<ChipSearchBar> {
  final _selectedWidgets = <CookChip>[];
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 8.0,
        children: (<Widget>[
          TextFormField(
              textInputAction: TextInputAction.done,
              controller: _textController,
              focusNode: _focusNode,
              decoration: InputDecoration(suffixIcon: Icon(Icons.search)),
              onFieldSubmitted: (value) {
                _selectedWidgets.add(CookChip(
                    key: Key(value),
                    text: value,
                    onDeleted: () => setState(() {
                          removeChipWithValue(value);
                        })));
                _textController.clear();
                setState(() {});
                _focusNode.requestFocus();
              }),
          ..._selectedWidgets,
        ]));
  }

  void removeChipWithValue(String value) {
    for (var cookChip in _selectedWidgets) {
      if (cookChip.text == value) {
        _selectedWidgets.remove(cookChip);
        break;
      }
    }
  }
}

class CookChip extends StatefulWidget {
  final String text;
  final VoidCallback onDeleted;
  final Key key;

  CookChip({this.text, this.onDeleted, this.key}) : super(key: key);

  @override
  _CookChipState createState() => _CookChipState();
}

class _CookChipState extends State<CookChip>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: SizeTransition(
        axis: Axis.horizontal,
        sizeFactor: _animationController,
        child: Chip(
          label: Text(widget.text),
          deleteIcon: Icon(
            Icons.clear,
            size: iconSize,
          ),
          onDeleted: onDeleted,
        ),
      ),
    );
  }

  void onDeleted() {
    _animationController.reverse().then((value) => widget.onDeleted());
  }
}

class RecipeGrid extends StatelessWidget {
  final List<Widget> children;

  RecipeGrid({
    this.children,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        final size = constraint.biggest;
        final smallBoxSize = (size.width - 2 * marginSmall) / 3;
        final bigBoxSize = smallBoxSize * 2 + marginSmall;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      width: smallBoxSize,
                      height: smallBoxSize,
                      child: children[0],
                    ),
                    const SizedBox(
                      height: marginSmall,
                    ),
                    SizedBox(
                      width: smallBoxSize,
                      height: smallBoxSize,
                      child: children[1],
                    ),
                  ],
                ),
                const SizedBox(
                  width: marginSmall,
                ),
                SizedBox(
                  width: bigBoxSize,
                  height: bigBoxSize,
                  child: children[2],
                ),
              ],
            ),
            const SizedBox(
              height: marginSmall,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: smallBoxSize,
                  height: smallBoxSize,
                  child: children[3],
                ),
                const SizedBox(
                  width: marginSmall,
                ),
                SizedBox(
                  width: smallBoxSize,
                  height: smallBoxSize,
                  child: children[4],
                ),
                const SizedBox(
                  width: marginSmall,
                ),
                SizedBox(
                  width: smallBoxSize,
                  height: smallBoxSize,
                  child: children[5],
                ),
              ],
            )
          ],
        );
      },
    );
  }
}

class Recommendations extends StatelessWidget {
  final List<Widget> children;

  Recommendations({
    this.children,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme.headline2.copyWith(
          fontWeight: FontWeight.w300,
        );
    final itemSize = MediaQuery.of(context).size.width / 3;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: marginScreen,
            bottom: marginSmall,
          ),
          child: RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              style: Theme.of(context).textTheme.headline2.copyWith(
                    fontWeight: FontWeight.w300,
                  ),
              children: <TextSpan>[
                TextSpan(text: "Your special\n"),
                TextSpan(
                  text: "recommendations",
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
            height: itemSize,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(width: marginScreen),
                ...children
                    .map(
                      (recipe) => Container(
                        child: recipe,
                        margin: EdgeInsets.only(right: marginSmall),
                      ),
                    )
                    .toList()
              ],
            ))
      ],
    );
  }
}
