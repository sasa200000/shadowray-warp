import 'dart:math' show pi;

import 'package:flutter/cupertino.dart';

/// A reusable rainbow light border that dances around ANY widget.
///
/// A rotating seven-colour gradient is painted as a rounded-rect stroke around
/// the wrapped child. It is the one effect used across the whole app: the
/// connect button, the licence entry field, the admin panel pickers and the
/// generated-code box. [active] controls speed and saturation, so the same
/// widget can either breathe slowly or run fast.
class RainbowBorderDance extends StatefulWidget {
  const RainbowBorderDance({
    super.key,
    required this.child,
    this.active = true,
    this.borderRadius = 18,
    this.borderWidth = 3,
    this.glow = false,
    this.padding = EdgeInsets.zero,
  });

  final Widget child;
  final bool active;
  final double borderRadius;
  final double borderWidth;
  final bool glow;
  final EdgeInsets padding;

  @override
  State<RainbowBorderDance> createState() => _RainbowBorderDanceState();
}

class _RainbowBorderDanceState extends State<RainbowBorderDance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return CustomPaint(
          painter: _RainbowBorderPainter(
            progress: _controller.value,
            radius: widget.borderRadius,
            width: widget.borderWidth,
            glow: widget.glow,
            speed: widget.active ? 1.0 : 0.25,
            alpha: widget.active ? 1.0 : 0.55,
          ),
          child: Padding(
            padding: widget.padding,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

class _RainbowBorderPainter extends CustomPainter {
  _RainbowBorderPainter({
    required this.progress,
    required this.radius,
    required this.width,
    required this.glow,
    required this.speed,
    required this.alpha,
  });

  final double progress;
  final double radius;
  final double width;
  final bool glow;
  final double speed;
  final double alpha;

  static const List<Color> _rainbow = <Color>[
    Color(0xFFFF1744),
    Color(0xFFFF9100),
    Color(0xFFFFEA00),
    Color(0xFF00E676),
    Color(0xFF00E5FF),
    Color(0xFF2979FF),
    Color(0xFFD500F9),
    Color(0xFFFF1744),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final inset = width / 2;
    final rect = Rect.fromLTRB(inset, inset, size.width - inset, size.height - inset);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    final angle = (progress * 2 * pi * speed) % (2 * pi);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        center: Alignment.center,
        startAngle: angle,
        colors: _rainbow
            .map((Color c) => c.withValues(alpha: alpha))
            .toList(growable: false),
        tileMode: TileMode.mirror,
      ).createShader(rect);

    if (glow) {
      final glowPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = width * 2.4
        ..strokeJoin = StrokeJoin.round
        ..shader = SweepGradient(
          center: Alignment.center,
          startAngle: angle,
          colors: _rainbow
              .map((Color c) => c.withValues(alpha: 0.30 * alpha))
              .toList(growable: false),
          tileMode: TileMode.mirror,
        ).createShader(rect.inflate(width * 1.6));
      canvas.drawRRect(rrect.inflate(width * 0.8), glowPaint);
    }

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(_RainbowBorderPainter old) =>
      old.progress != progress || old.alpha != alpha;
}
