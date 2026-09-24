import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/licence_entry_screen.dart';

/// Routes the user past the licence gate and exposes the admin entry point.
///
/// Two rules: nobody reaches the VPN screens without a valid, unexpired code,
/// and the admin panel is reachable only through its lock code. Admin rights
/// are unlimited — the panel itself never expires.
class AppRouter extends ConsumerWidget {
  const AppRouter({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (licence, active) = licenceGateOf(ref);
    if (!active) {
      return LicenceEntryScreen(expired: licence != null);
    }
    return child;
  }
}
