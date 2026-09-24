import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/api.dart' as pc;
import 'package:pointycastle/asymmetric/api.dart' as asym;
import 'package:pointycastle/asn1.dart' as asn1;
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/signers/rsa_signer.dart';

/// Offline, server-free subscription licence.
///
/// Codes are minted by the in-app admin panel (which holds the private key)
/// and verified here with the embedded public key. No backend call is ever
/// made: a code carries its own RSA signature, so the app can prove the code
/// was produced by the admin without asking anyone.
class Licence {
  const Licence({
    required this.code,
    required this.planId,
    required this.planLabel,
    required this.deviceLimit,
    required this.durationDays,
    required this.issuedAt,
    required this.activatedAt,
  });

  final String code;
  final String planId;
  final String planLabel;
  final int deviceLimit;
  final int durationDays;
  final int issuedAt;
  final int activatedAt;

  DateTime get expiryDateTime =>
      DateTime.fromMillisecondsSinceEpoch(issuedAt * 1000, isUtc: true)
          .add(Duration(days: durationDays))
          .copyWith(hour: 23, minute: 59, second: 59);

  bool get isExpired => DateTime.now().isAfter(expiryDateTime);
  int get daysRemaining =>
      expiryDateTime.difference(DateTime.now()).inDays.clamp(0, durationDays);

  double get progress {
    final total = durationDays * 86400000.0;
    final elapsed = DateTime.now().millisecondsSinceEpoch - issuedAt * 1000;
    return (elapsed / total).clamp(0.0, 1.0);
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'code': code,
        'planId': planId,
        'planLabel': planLabel,
        'deviceLimit': deviceLimit,
        'durationDays': durationDays,
        'issuedAt': issuedAt,
        'activatedAt': activatedAt,
      };

  factory Licence.fromMap(Map<String, dynamic> map) => Licence(
        code: map['code'] as String? ?? '',
        planId: map['planId'] as String? ?? '',
        planLabel: map['planLabel'] as String? ?? '',
        deviceLimit: map['deviceLimit'] as int? ?? 1,
        durationDays: map['durationDays'] as int? ?? 0,
        issuedAt: map['issuedAt'] as int? ?? 0,
        activatedAt: map['activatedAt'] as int? ?? 0,
      );
}

/// Catalogue of saleable plans. The id is what is baked into a code.
class LicencePlans {
  const LicencePlans._();

  static const Map<String, LicencePlan> known = <String, LicencePlan>{
    '1D': LicencePlan(id: '1D', label: '۱ روزه', durationDays: 1),
    '1M': LicencePlan(id: '1M', label: '۱ ماهه', durationDays: 30),
    '2M': LicencePlan(id: '2M', label: '۲ ماهه', durationDays: 60),
    '3M': LicencePlan(id: '3M', label: '۳ ماهه', durationDays: 90),
    '5M': LicencePlan(id: '5M', label: '۵ ماهه', durationDays: 150),
    '8M': LicencePlan(id: '8M', label: '۸ ماهه', durationDays: 240),
    '1Y': LicencePlan(id: '1Y', label: '۱ ساله', durationDays: 365),
  };

  static const List<int> deviceTiers = <int>[1, 2, 4, 6];
}

class LicencePlan {
  const LicencePlan({
    required this.id,
    required this.label,
    required this.durationDays,
  });
  final String id;
  final String label;
  final int durationDays;
}

class _ParsedCode {
  const _ParsedCode(this.planId, this.devices, this.issuedAt, this.signature);
  final String planId;
  final int devices;
  final int issuedAt;
  final String signature;
}

class LicenceVerifier {
  LicenceVerifier._();

  static const String _publicKeyPem = '''-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwUak7K8T91N846OdZH0I
+ZXI2Ovni4kz99b68Hrl5KjrWhFjL/+TNzmYlnhqBXpRfpLLQU2SH697XGMJiR1M
5QmC0njJWqMC61zelncU5Oyie7BBmdPYhOkxijglHy1P7gbLC1nlLDVVBneSa2Ue
FxMRHK1diLTRpvwmVa6lKB1ed9/8SjKVmTOlLAlpHCM87j/O3/hlRn3Sng7nEOG/
Jn04XnsvOEwE3lMMsjJSaKEWLOsHcGlflfoPaLJGf9ItLYa522kPyq9F9cP0wjWw
qFnl3H3ov/zZrxaaUq/beRBIGfuE24XbocEj9ttS4164ixPmGkvhccqqUHQ6w8o1
JQIDAQAB
-----END PUBLIC KEY-----''';

  /// Returns the licence described by [rawCode], or null when the signature is
  /// invalid, the plan is unknown, or the code was minted too long ago.
  static Licence? verify(String rawCode) {
    final parts = _parse(rawCode);
    if (parts == null) return null;

    final plan = LicencePlans.known[parts.planId];
    if (plan == null) return null;

    final issued = DateTime.fromMillisecondsSinceEpoch(parts.issuedAt * 1000,
        isUtc: true);
    if (DateTime.now().isAfter(issued.add(Duration(days: plan.durationDays + 60)))) {
      return null;
    }

    final message = utf8.encode('${parts.planId}|${parts.devices}|${parts.issuedAt}');
    try {
      final publicKey = _publicKeyFromPem(_publicKeyPem);
      final signer = RSASigner(SHA256Digest(), '0609608648016503040201')
        ..init(false, pc.PublicKeyParameter<asym.RSAPublicKey>(publicKey));
      final sig = base64Url
          .decode(parts.signature + '=' * (-parts.signature.length % 4));
      if (!signer.verifySignature(
          Uint8List.fromList(message), asym.RSASignature(sig))) {
        return null;
      }
    } catch (_) {
      return null;
    }

    return Licence(
      code: rawCode.trim(),
      planId: plan.id,
      planLabel: plan.label,
      deviceLimit: parts.devices,
      durationDays: plan.durationDays,
      issuedAt: parts.issuedAt,
      activatedAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
    );
  }

  static _ParsedCode? _parse(String raw) {
    final match = RegExp(r'^SASA-([A-Z0-9]+)-(\d+)-(\d+)-([A-Za-z0-9_-]+)$')
        .firstMatch(raw.trim());
    if (match == null) return null;
    final issuedAt = int.tryParse(match.group(3) ?? '');
    if (issuedAt == null) return null;
    return _ParsedCode(match.group(1)!, int.tryParse(match.group(2)!) ?? 0,
        issuedAt, match.group(4)!);
  }

  static asym.RSAPublicKey _publicKeyFromPem(String pem) {
    final lines = pem
        .split(RegExp(r'\r?\n'))
        .where((line) => !line.startsWith('-----'))
        .join();
    final parser = asn1.ASN1Parser(base64.decode(lines));
    final seq = parser.nextObject() as asn1.ASN1Sequence;
    final bitString = seq.elements![1] as asn1.ASN1BitString;
    final keyParser = asn1.ASN1Parser(bitString.valueBytes);
    final keySeq = keyParser.nextObject() as asn1.ASN1Sequence;
    final modulus = (keySeq.elements![0] as asn1.ASN1Integer).integer!;
    final exponent = (keySeq.elements![1] as asn1.ASN1Integer).integer!;
    return asym.RSAPublicKey(modulus, exponent);
  }
}
