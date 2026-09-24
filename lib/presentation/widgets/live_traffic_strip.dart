import 'package:flutter/cupertino.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../data/models/tunnel_status.dart';

/// Live upload / download / duration strip shown while the tunnel is up.
///
/// Sits under the connect button and counts in real time. The values are the
/// real byte counters the core reports, not estimates.
class LiveTrafficStrip extends StatelessWidget {
  const LiveTrafficStrip({super.key, required this.status});

  final TunnelStatus status;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    if (!status.stage.isActive) return const SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _Chip(
          icon: CupertinoIcons.arrow_down,
          label: Formatters.bytes(status.stats.rxBytes),
          tone: palette.primary,
        ),
        const SizedBox(width: 12),
        _Chip(
          icon: CupertinoIcons.arrow_up,
          label: Formatters.bytes(status.stats.txBytes),
          tone: palette.labelSecondary,
        ),
        const SizedBox(width: 12),
        _Chip(
          icon: CupertinoIcons.timer,
          label: Formatters.clock(status.uptime),
          tone: palette.labelSecondary,
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.icon,
    required this.label,
    required this.tone,
  });

  final IconData icon;
  final String label;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 14, color: tone),
          const SizedBox(width: 6),
          Text(
            label,
            textDirection: TextDirection.ltr,
            style: AppText.caption(tone).copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
