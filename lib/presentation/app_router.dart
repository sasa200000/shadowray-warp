import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/licence/licence.dart';
import '../data/services/licence_providers.dart';
import 'screens/licence_entry_screen.dart';

/// Decides what the user is allowed to see right now.
///
/// Returns the stored licence (if any) and whether it is still valid. When the
/// stored licence has run out, [ Licence.valid] is false but the licence itself
/// is not null, so the entry screen can explain that the subscription ended
/// rather than claiming the code was never valid.
(Licence?, bool) licenceGateOf(WidgetRef ref) {
  final licence = ref.watch(currentLicenceProvider);
  if (licence == null) return (null, false);
  return (licence, !licence.isExpired);
}

/// Routes the user past the licence gate.
///
/// One rule: nobody reaches the VPN screens without a valid, unexpired code.
/// Expired codes fall through to the entry screen, where the user is told the
/// subscription ran out.
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
