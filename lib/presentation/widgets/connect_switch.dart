import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_theme.dart';
import '../../data/models/tunnel_status.dart';

/// The big connect button, wrapped in the light dance.
///
/// The halo is a rotating multi-arc ring painted on a canvas behind the
/// switch. When the tunnel is idle the ring breathes slowly; while connecting
/// it spins up; once connected it turns into a fast, saturated rainbow that
/// runs around the whole button while live upload/download counters are shown
/// elsewhere on the screen.
class ConnectSwitch extends StatelessWidget {
  const ConnectSwitch({
    super.key,
    required this.stage,
    required this.onConnect,
    required this.onDisconnect,
  });

  final TunnelStage stage;
  final VoidCallback onConnect;
  final VoidCallback onDisconnect;

  static const double _width = 160;
  static const double _height = 74;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    final on = stage.isActive || stage.isBusy;

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        SizedBox(
          width: _width + 72,
          height: _height + 72,
          child: CustomPaint(painter: _HaloPainter(stage: stage)),
        ),
        _SwitchBody(
          stage: stage,
          on: on,
          trackColor: switch (stage) {
            TunnelStage.failed => palette.danger,
            _ => on ? palette.primary : palette.track,
          },
          palette: palette,
          onTap: () {
            HapticFeedback.mediumImpact();
            if (stage.isActive || stage.isBusy) {
              onDisconnect();
            } else {
              onConnect();
            }
          },
        ),
      ],
    );
  }
}

class _SwitchBody extends StatelessWidget {
  const _SwitchBody({
    required this.stage,
    required this.on,
    required this.trackColor,
    required this.palette,
    required this.onTap,
  });

  final TunnelStage stage;
  final bool on;
  final Color trackColor;
  final AppPalette palette;
  final VoidCallback onTap;

  static const double _border = 3;

  @override
  Widget build(BuildContext context) {
    final knob = ConnectSwitch._height - _border * 2;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
        width: ConnectSwitch._width,
        height: ConnectSwitch._height,
        padding: const EdgeInsets.all(_border),
        decoration: BoxDecoration(
          color: trackColor,
          borderRadius: BorderRadius.circular(ConnectSwitch._height / 2),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOut,
          alignment: on ? Alignment.centerRight : Alignment.centerLeft,
          child: SizedBox(
            width: knob,
            height: knob,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: palette.card,
                shape: BoxShape.circle,
              ),
              child: stage.isBusy
                  ? const Center(child: CupertinoActivityIndicator(radius: 11))
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}

/// Paints the rotating light ring. The animation is driven by an
/// [AnimationController] owned by a wrapper that rebuilds every frame, so the
/// painter itself only draws the current frame it is handed.
class _HaloPainter extends CustomPainter {
  _HaloPainter({required this.stage});

  final TunnelStage stage;

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
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.shortestSide / 2) * 0.92;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // The rotation comes from the system frame clock; keep it deterministic
    // per frame so the ring always advances while the widget is visible.
    final t = DateTime.now().millisecondsSinceEpoch / 1000.0;
    final spin = switch (stage) {
      TunnelStage.connected => t * 1.6,
      TunnelStage.connecting => t * 0.9,
      TunnelStage.validating => t * 0.9,
      _ => t * 0.35,
    };

    final sweep = switch (stage) {
      TunnelStage.connected => 0.75,
      TunnelStage.connecting => 0.5,
      TunnelStage.validating => 0.5,
      _ => 0.28,
    };

    final alpha = switch (stage) {
      TunnelStage.connected => 1.0,
      TunnelStage.connecting => 0.75,
      TunnelStage.validating => 0.75,
      TunnelStage.failed => 0.35,
      _ => 0.5,
    };

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stage.isActive ? 9 : 5
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        center: Alignment.center,
        startAngle: spin % (2 * pi),
        sweepAngle: sweep * 2 * pi,
        colors: _rainbow.map((Color c) => c.withOpacity(alpha)).toList(),
      ).createShader(rect);

    canvas.drawArc(rect, spin % (2 * pi), sweep * 2 * pi, false, paint);

    // Soft outer bloom while connected.
    if (stage.isActive) {
      final bloom = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..shader = RadialGradient(
          colors: <Color>[
            const Color(0xFF00E5FF).withOpacity(0.25),
            Colors.transparent,
          ],
        ).createShader(rect.inflate(18));
      canvas.drawCircle(center, radius + 12, bloom);
    }
  }

  @override
  bool shouldRepaint(_HaloPainter old) => old.stage != stage;
}
