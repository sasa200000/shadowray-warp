import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/tunnel_status.dart';
import '../../l10n/generated/app_localizations.dart';
import '../providers/tunnel_providers.dart';

/// The light dance that runs around the whole screen while the tunnel is up.
///
/// Drawn as an animated border on top of the current screen, so whatever the
/// user has open — home, settings, logs — the rainbow edge follows. It only
/// paints while the tunnel is connecting or connected, and otherwise costs
/// nothing.
class EdgeLightDance extends ConsumerStatefulWidget {
  const EdgeLightDance({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<EdgeLightDance> createState() => _EdgeLightDanceState();
}

class _EdgeLightDanceState extends ConsumerState<EdgeLightDance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  static const List<Color> _rainbow = <Color>[
    Color(0xFFFF0055),
    Color(0xFFFF7700),
    Color(0xFFFFEE00),
    Color(0xFF00FF66),
    Color(0xFF00E5FF),
    Color(0xFF2979FF),
    Color(0xFFAA00FF),
    Color(0xFFFF0055),
  ];

  @override
  Widget build(BuildContext context) {
    final stage = ref.watch(tunnelProvider.select((s) => s.stage));
    final dancing = stage.isBusy || stage.isActive;

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        widget.child,
        if (dancing)
          IgnorePointer(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                return CustomPaint(
                  painter: _EdgePainter(
                    progress: _controller.value,
                    fast: stage.isActive,
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _EdgePainter extends CustomPainter {
  _EdgePainter({required this.progress, required this.fast});

  final double progress;
  final bool fast;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCenter(
      center: center,
      width: size.width - 6,
      height: size.height - 6,
    );
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(22));

    final angle = (progress * 2 * pi) * (fast ? 1.0 : 0.45);
    final sweep = (fast ? 0.55 : 0.3) * 2 * pi;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = fast ? 8 : 4
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        center: Alignment.center,
        startAngle: angle % (2 * pi),
        sweepAngle: sweep,
        colors: _EdgePainterColors.rainbow,
        tileMode: TileMode.mirror,
      ).createShader(rect);

    canvas.drawRRect(rrect, paint);

    // Inner sharp laser edge, counter-rotating.
    final inner = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center,
        width: size.width - 14,
        height: size.height - 14,
      ),
      const Radius.circular(16),
    );
    final innerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..shader = SweepGradient(
        center: Alignment.center,
        startAngle: (-angle * 1.4) % (2 * pi),
        sweepAngle: sweep * 0.6,
        colors: _EdgePainterColors.rainbow,
        tileMode: TileMode.mirror,
      ).createShader(rect);
    canvas.drawRRect(inner, innerPaint);
  }

  @override
  bool shouldRepaint(_EdgePainter old) =>
      old.progress != progress || old.fast != fast;
}

class _EdgePainterColors {
  _EdgePainterColors._();

  static const List<Color> rainbow = <Color>[
    Color(0xFFFF0055),
    Color(0xFFFF7700),
    Color(0xFFFFEE00),
    Color(0xFF00FF66),
    Color(0xFF00E5FF),
    Color(0xFF2979FF),
    Color(0xFFAA00FF),
    Color(0xFFFF0055),
  ];
}
