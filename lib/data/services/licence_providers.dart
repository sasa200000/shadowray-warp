import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../licence/licence.dart';
import '../licence/licence_store.dart';

final licenceStoreProvider = FutureProvider<LicenceStore>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return LicenceStore(prefs);
});

/// The active licence, or null when the user has not entered a code yet.
final currentLicenceProvider =
    StateNotifierProvider<LicenceController, Licence?>((ref) {
  return LicenceController(ref);
});

class LicenceController extends StateNotifier<Licence?> {
  LicenceController(this._ref) : super(null) {
    _hydrate();
  }

  final Ref _ref;

  Future<void> _hydrate() async {
    final store = await _ref.read(licenceStoreProvider.future);
    if (!mounted) return;
    state = store.currentLicence;
  }

  /// Verifies a typed code and, when it is genuinely signed by the admin key,
  /// stores it as the active licence. Returns false on any failure.
  Future<bool> activate(String code) async {
    final licence = LicenceVerifier.verify(code);
    if (licence == null) return false;

    final store = await _ref.read(licenceStoreProvider.future);
    await store.saveLicence(licence);
    if (!mounted) return true;
    state = licence;
    return true;
  }

  Future<void> deactivate() async {
    final store = await _ref.read(licenceStoreProvider.future);
    await store.clearLicence();
    if (!mounted) return;
    state = null;
  }

  /// Gate used by the UI: a user may only reach the home screen with a licence
  /// that is still inside its window. Expired codes fall through to the entry
  /// screen, where they are told the code ran out.
  bool get hasActiveLicence {
    final licence = state;
    return licence != null && !licence.isExpired;
  }
}
