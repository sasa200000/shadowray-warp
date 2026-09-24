import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_theme.dart';
import '../../data/models/tunnel_status.dart';
import 'rainbow_border_dance.dart';

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

    return RainbowBorderDance(
      active: on,
      borderRadius: _height / 2,
      borderWidth: on ? 5 : 2.5,
      glow: on,
      padding: const EdgeInsets.all(3),
      child: _SwitchBody(
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
