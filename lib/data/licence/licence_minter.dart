import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'licence.dart';

/// The admin side of the offline licence scheme.
///
/// Holds the RSA private key and mints signed codes. The private key lives
/// inside the app so the admin (you) can generate codes from the panel with no
/// server; the trade-off is that a determined attacker who decompiles the APK
/// can forge codes too. When you are ready to close that hole, move key
/// generation onto a small server and keep only the public key in the app.
class LicenceMinter {
  LicenceMinter._();

  /// The same secret the verifier uses. Keep it private to the admin build.
  static const String _secret = 'SasaVPN-licence-secret-v2';

  /// Produces one code for [planId] and [devices], valid from now.
  static String mint({required String planId, required int devices}) {
    final issuedAt = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final message = '$planId|$devices|$issuedAt';
    final mac =
        Hmac(sha256, _secret.codeUnits).convert(message.codeUnits).bytes;
    final b64 = base64Url.encode(mac).replaceAll('=', '');
    return 'SASA-$planId-$devices-$issuedAt-$b64';
  }
}
