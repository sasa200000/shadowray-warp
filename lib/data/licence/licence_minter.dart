import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/api.dart' as pc;
import 'package:pointycastle/asn1.dart' as asn1;
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/signers/pkcs1.dart';

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

  static const String _privateKeyPem = '''-----BEGIN PRIVATE KEY-----
MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDBRqTsrxP3U3zj
o51kfQj5lcjY6+eLiTP31vrweuXkqOtaEWMv/5M3OZiWeGoFelF+kstBTZIfr3tc
YwmJHUzlCYLSeMlaowLrXN6WdxTk7KJ7sEGZ09iE6TGKOCUfLU/uBssLWeUsNVUG
d5JrZR4XExEcrV2ItNGm/CZVrqUoHV533/xKMpWZM6UsCWkcIzzuP87f+GVGfdKe
DucQ4b8mfTheey84TATeUwyyMlJooRYs6wdwaV+V+g9oskZ/0i0thrnbaQ/Kr0X1
w/TCNbCoWeXcfei//NmvFppSr9t5EEgZ+4TbhduhwSP221LjXriLE+YaS+FxyqpQ
dDrDyjUlAgMBAAECggEAAI+njtF5T/o9k6RJsN1G9aviKMou/vkbLD4YYTLrCWZP
CtgRvwr8MmF2JqzM78ewvzcqOcxBsRNNvo3B8mKwVkxYKPKcfwy0chN+Op3w5KUJ
rxCVcRCBVtEBZhgO2/peiN+pZc+mgWjac/RozwgD2UtpterFYpVkQjcF+pS01tPq
mLJ1maMEDoyPPmYb+oX5+7h0yoCr2cFxYdMWF1DN8fYSo5pEXuBQef8otZ6vnuhx
R4dKGOsqkdi1P77xi/2VX3wGymTf9nkMEmKdXMhppOi0NYp2kCoL2myH+cipEARz
NPfzuG/JTfBA4v5FWj+B2J/4+4SKtxfRmYbpx9tI8QKBgQDrohbiFnptDF0rb/NN
nAHZp9v1MeDlNufR46VbrScNba+CGcxT2acyKGzSNj8uRbzy2YOWXHE4mm3u89ub
K025828v+FVLtRIchKw+ETAgl2NeJVEWgXjmxCw/c2rtpVB3St+c4N66eN1CYDVR
m6yzoozm1wsPlQP+3dMRxfkOfQKBgQDR+06R41zIyjIqtgFrJjLLWm2gVOXEsy44
ucg1tvxXvuiPUItQhpuHUsFThahfNR5WCqjl7DlrgZB7oczIa3AnWDMfe6Hl/8Zv
fl7WEpEiW2N/ibkNMhwuFKEEHlHqv2bd7JGZRfx2XW6xWGYBxxlp3COqqjfpJpP1
NDNR9lQ5yQKBgQC79Es0hKGbImWfJGl62ppPN6ooZ2Tw8V7w+RkJi5C/EWMR7+og
aFkJlV1YQJUdH9ucCwz/fzWA5Q4TsMjXeS9CyH9EUF4ZSZHs1Zde2u780EUe771C
qnv59zkkU7hTX65TuZGs3WJMc+Rp8bwWIIsdruedqqLUBxVs0xxt7PDBMQKBgQC+
8/h5dveTqTyB1s3ncO9UOkHjQhFJFWD9OQW2w1crPHMkkSx/6ElbgIhKugtpuVaD
DGKX5IA7IbIQnA0sXXe6b9zdzoJmNHlyPstjhbLyOYV8H/Rm6aDyztO2eRQplDGp
s06cwiZaRZE6OZdaGoMj34uX0f/SSMDYhcX9zTK+8QKBgQDWGVD+IVBI7pCoOiP7
gnnw13b9Z3L4cIo+Ty65sG/EUNCIYoCsAjd1YYPj+o5ooT0rZd4euWwTfZDbMQLs
eeqYKHZENFc85dRdOc2bovfUXH9QTL+kY7f/VzmVvI+mYBIWUDNjUg7a/1EHjYUY
1bpjZ34uxiboIxk9LOe4xjmSXg==
-----END PRIVATE KEY-----''';

  /// Produces one code for [planId] and [devices], valid from now.
  static String mint({required String planId, required int devices}) {
    final issuedAt = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final message = utf8.encode('$planId|$devices|$issuedAt');
    final privateKey = _privateKeyFromPem(_privateKeyPem);
    final signer = PKCS1Signer(SHA256Digest())
      ..init(true, pc.PrivateKeyParameter<pc.RSAPrivateKey>(privateKey));
    final sig = signer.generateSignature(Uint8List.fromList(message));
    final b64 = base64Url.encode(sig.bytes).replaceAll('=', '');
    return 'SASA-$planId-$devices-$issuedAt-$b64';
  }

  static pc.RSAPrivateKey _privateKeyFromPem(String pem) {
    final lines = pem
        .split(RegExp(r'\r?\n'))
        .where((line) => !line.startsWith('-----'))
        .join();
    final outer =
        asn1.ASN1Parser(base64.decode(lines)).nextObject() as asn1.ASN1Sequence;
    // PKCS#8: version, algorithm identifier, octet string holding PKCS#1.
    final innerBytes = (outer.elements![2] as asn1.ASN1OctetString).valueBytes;
    final inner =
        asn1.ASN1Parser(innerBytes).nextObject() as asn1.ASN1Sequence;
    // RSAPrivateKey: version, n, e, d, p, q, dP, dQ, qInv.
    final modulus = (inner.elements![1] as asn1.ASN1Integer).value;
    final privateExponent = (inner.elements![3] as asn1.ASN1Integer).value;
    final p = (inner.elements![4] as asn1.ASN1Integer).value;
    final q = (inner.elements![5] as asn1.ASN1Integer).value;
    return pc.RSAPrivateKey(modulus, privateExponent, p, q);
  }
}
