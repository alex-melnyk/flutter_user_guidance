import 'package:flutter/material.dart';

class UserGuidanceValue {
  const UserGuidanceValue._([
    this.visible = false,
    this.step = 0,
  ]);

  const UserGuidanceValue.hidden() : this._();

  const UserGuidanceValue.visible() : this._(true);

  final bool visible;
  final int step;
}

class UserGuidanceController extends ValueNotifier<UserGuidanceValue> {
  UserGuidanceController() : super(UserGuidanceValue.hidden());

  void show() {
    value = UserGuidanceValue.visible();
  }

  void hide() {
    value = UserGuidanceValue.hidden();
  }
}

class UserGuidance extends StatefulWidget {
  const UserGuidance({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final UserGuidanceController controller;

  @override
  _UserGuidanceState createState() => _UserGuidanceState();
}

class _UserGuidanceState extends State<UserGuidance> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    final clipSize = 56.0;

    return ValueListenableBuilder<UserGuidanceValue>(
      valueListenable: widget.controller,
      builder: (_, value, child) {
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 250),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: value.visible
              ? SizedBox(key: ValueKey(0), child: child)
              : const SizedBox(key: ValueKey(1)),
        );
      },
      child: GestureDetector(
        onTap: () => widget.controller.hide(),
        child: Stack(
          children: [
            Positioned.fill(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black87,
                  BlendMode.srcOut,
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          backgroundBlendMode: BlendMode.dstOut,
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        AnimatedPositioned.fromRect(
                          duration: Duration(milliseconds: 250),
                          rect: Rect.fromLTWH(
                            media.size.width - clipSize - 16.0,
                            media.size.height - clipSize - 16.0,
                            clipSize,
                            clipSize,
                          ),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 8.0,
                                  spreadRadius: 8.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
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
                  child: Text(
                    'Tap on (+) button to increase the number',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
