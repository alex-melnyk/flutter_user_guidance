import 'package:flutter/material.dart';

class Guide {
  const Guide._(this.rect, this.decoration);

  /// Create a custom [Guide] instance.
  /// NOTICE: To take effect set any color e.g. [Colors.white].
  const Guide.custom(Rect rect, {Decoration decoration})
      : this._(rect, decoration);

  const Guide.rect(Rect rect)
      : this._(
          rect,
          const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
          ),
        );

  const Guide.circle(Rect rect)
      : this._(
          rect,
          const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        );

  final Rect rect;
  final Decoration decoration;
}
