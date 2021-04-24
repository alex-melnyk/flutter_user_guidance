import 'package:flutter/material.dart';
import 'package:flutter_user_guidance/models/guide.dart';
import 'package:flutter_user_guidance/widgets/guidance.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
    this.duration = const Duration(milliseconds: 2500),
  }) : super(key: key);

  final Duration duration;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _userGuidanceController = GuidanceController();
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);

    final clipSize = 56.0;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text('Flutter User Guidance Example'),
            centerTitle: false,
            actions: [
              IconButton(
                icon: Icon(Icons.slideshow),
                onPressed: () => _userGuidanceController.show(),
              ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: theme.textTheme.headline4,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _handleFABPressed,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        ),
        Guidance(
          controller: _userGuidanceController,
          guides: [
            Guide.rect(Rect.fromLTWH(
              0.0,
              0.0,
              media.size.width,
              media.viewPadding.top,
            )),
            Guide.rect(Rect.fromLTWH(
              0.0,
              media.viewPadding.top,
              media.size.width,
              56.0,
            )),
            Guide.custom(
              Rect.fromLTWH(
                media.size.width - 48.0,
                media.viewPadding.top + 4.0,
                48.0,
                48.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.0),
              ),
            ),
            Guide.rect(Rect.fromLTWH(
              24.0,
              media.size.height / 2 + media.viewPadding.top + 56.0 - 80.0,
              media.size.width - 48.0,
              80.0,
            )),
            Guide.custom(
              Rect.fromLTWH(
                media.size.width - clipSize - 16.0,
                media.size.height - clipSize - 16.0,
                clipSize,
                clipSize,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(clipSize),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Guide.custom(
              Rect.fromLTWH(
                media.size.width - clipSize - 16.0,
                media.size.height - clipSize - 16.0,
                clipSize,
                clipSize,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(clipSize),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 8.0,
                    spreadRadius: 8.0,
                  ),
                ],
              ),
            ),
          ],
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 120,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              alignment: Alignment.topCenter,
              child: Text(
                'System StatusBar',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 120,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              alignment: Alignment.topLeft,
              child: Text(
                'Application AppBar',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 120,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              alignment: Alignment.topRight,
              child: Text(
                'AppBar action button',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: 120,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              alignment: Alignment.center,
              child: Text(
                'The amount of User Taps:',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: 160,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              alignment: Alignment.bottomCenter,
              child: Text(
                'Float Action Button',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: 160,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              alignment: Alignment.bottomCenter,
              child: Text(
                'Tap on (+) button to increase the number',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _handleFABPressed() {
    setState(() {
      _counter++;
    });
  }
}
