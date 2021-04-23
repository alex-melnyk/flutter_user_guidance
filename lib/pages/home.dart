import 'package:flutter/material.dart';
import 'package:flutter_user_guidance/widgets/user_guidance.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
    this.duration = const Duration(milliseconds: 2500),
  }) : super(key: key);

  final Duration duration;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _userGuidanceController = UserGuidanceController();
  AnimationController _animationController;
  Animation _animation;
  int _counter = 0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..forward();

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
        UserGuidance(
          controller: _userGuidanceController,
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
