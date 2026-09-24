import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../licence/licence.dart';

/// Persists the activated licence and the admin lock code.
///
/// Both live in plain SharedPreferences on the device. That is deliberate:
/// there is no server, so the device is the only place to keep state. It means
/// clearing app data also clears the licence, so codes are bound to a device
/// only loosely.
class LicenceStore {
  LicenceStore(this._prefs);

  final SharedPreferences _prefs;

  static const String _kLicence = 'sasavpn.licence';
  static const String _kAdminLock = 'sasavpn.admin.lock';
  static const String _kAdminSeen = 'sasavpn.admin.seen';
  static const String _kMintedCodes = 'sasavpn.admin.minted';

  static const String _defaultAdminLock = 'SAZA-64243771B6EA04A0';

  /// The lock code that opens the admin panel. Defaults to the shipped one;
  /// the admin changes it from inside the panel and it sticks on this device.
  String get adminLock => _prefs.getString(_kAdminLock) ?? _defaultAdminLock;

  Future<void> setAdminLock(String code) async {
    await _prefs.setString(_kAdminLock, code);
  }

  bool get adminSetupDone => _prefs.getBool(_kAdminSeen) ?? false;
  Future<void> markAdminSetupDone() async => _prefs.setBool(_kAdminSeen, true);

  Licence? get currentLicence {
    final raw = _prefs.getString(_kLicence);
    if (raw == null || raw.isEmpty) return null;
    try {
      return Licence.fromMap(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  Future<void> saveLicence(Licence licence) async {
    await _prefs.setString(_kLicence, jsonEncode(licence.toMap()));
  }

  Future<void> clearLicence() async => _prefs.remove(_kLicence);

  /// Every code this panel has ever minted, newest first.
  List<String> get mintedCodes {
    final raw = _prefs.getStringList(_kMintedCodes);
    return raw ?? <String>[];
  }

  Future<void> rememberMintedCode(String code) async {
    final list = mintedCodes;
    if (!list.contains(code)) {
      list.insert(0, code);
      await _prefs.setStringList(_kMintedCodes, list);
    }
  }
}
