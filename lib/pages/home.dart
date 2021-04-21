import 'package:flutter/material.dart';

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
  final _textTyping = 'Tap on (+) button to increase the number';

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
        Positioned.fill(
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black87,
              BlendMode.srcOut,
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    backgroundBlendMode: BlendMode.dstOut,
                  ),
                ),
                Positioned(
                  bottom: 22,
                  right: 4,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 80,
                    ),
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(
                bottom: 160,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              width: double.maxFinite,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  final textLength = StepTween(
                    begin: 0,
                    end: _textTyping.length,
                  ).evaluate(_animationController);

                  return Text(
                    _textTyping.substring(0, textLength),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ),
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
