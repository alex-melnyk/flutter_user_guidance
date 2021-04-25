import 'package:flutter/material.dart';
import 'package:flutter_user_guidance/models/models.dart';

class GuidanceValue {
  const GuidanceValue._([
    this.visible = false,
    this.step = 0,
  ]);

  const GuidanceValue.initial() : this._();

  const GuidanceValue.custom({
    bool visible,
    int step,
  }) : this._(visible, step);

  final bool visible;
  final int step;
}

class GuidanceController extends ValueNotifier<GuidanceValue> {
  GuidanceController() : super(GuidanceValue.initial());

  void show({int from = 0}) {
    value = GuidanceValue.custom(
      visible: true,
      step: from,
    );
  }

  void next() {
    value = GuidanceValue.custom(
      visible: value.visible,
      step: value.step + 1,
    );
  }

  void hide() {
    value = GuidanceValue.custom(
      visible: false,
      step: value.step,
    );
  }
}

class Guidance extends StatefulWidget {
  const Guidance({
    Key key,
    @required this.guides,
    @required this.children,
    this.controller,
    this.duration = const Duration(milliseconds: 250),
  })  : assert(
          guides.length > 0,
          'Property "guides" should have at least one element',
        ),
        assert(
          guides.length == children.length,
          'Property "children" and "guides" should be the same size.',
        ),
        super(key: key);

  final List<Guide> guides;
  final List<Widget> children;
  final GuidanceController controller;
  final Duration duration;

  @override
  _GuidanceState createState() => _GuidanceState();
}

class _GuidanceState extends State<Guidance> {
  GuidanceController _controller;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? GuidanceController();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<GuidanceValue>(
      valueListenable: widget.controller,
      builder: (_, value, child) {
        return AnimatedSwitcher(
          duration: widget.duration,
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
        onTap: _handlePressed,
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
                    ValueListenableBuilder<GuidanceValue>(
                      valueListenable: widget.controller,
                      builder: (context, value, child) {
                        final userGuide = widget.guides[value.step];

                        return AnimatedPositioned.fromRect(
                          duration: widget.duration,
                          rect: userGuide.rect,
                          child: AnimatedContainer(
                            duration: widget.duration,
                            decoration: userGuide.decoration,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: ValueListenableBuilder<GuidanceValue>(
                valueListenable: _controller,
                builder: (context, value, child) {
                  final guideChild = widget.children[value.step];

                  return AnimatedSwitcher(
                    duration: widget.duration,
                    child: SizedBox(
                      key: ValueKey<int>(value.step),
                      child: guideChild,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handlePressed() {
    if (widget.controller.value.step + 1 < widget.guides.length) {
      widget.controller.next();
    } else {
      widget.controller.hide();
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }

    super.dispose();
  }
}
