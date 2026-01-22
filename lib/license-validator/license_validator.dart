import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/asn1.dart';
import 'package:flutter_application_1/license-validator/hardware_provider.dart';

class LicenseValidator {
  static const String _publicKeyPem = '''
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAs/2rCzeyLR261J1lP7tZOR1vaNqiG1EFMZIn0gJRqRu2O59RGD/42VyqtS/eeX2n+ZR7hZkSx4YXb+t9FPFyOOvMHCAMjv8GDnh03PcRDkS1cX/L74gkoUWcmgLdFUaDCxZ6YeIRjGAzMFRLvyKnzXJp6Vafl3H9+EsqxLuoTW+ok4fMneU2phm34Kjj1odEZBofrqmr7cHVanZYUjAUDqdjwCPXtVe6CO2yWdgy2stEAxgLGyNoCouIkYSx8kFX9qQyNyUa0pUQeuzB6VPdizs0wgPrV0TopqCglQCaeUcg1l2OVrYLP4yXe5TTX2JewuwyUUGwSVSbY9qYrLROlQIDAQAB
-----END PUBLIC KEY-----
''';

  static Future<bool> isLicenseValid() async {
    try {
      // final file = File('license.json');
      // if (!await file.exists()) return false;

      // final Map<String, dynamic> license = jsonDecode(await file.readAsString());

      final jsonString =
          "{\"licenseId\":\"b1af40c8cab948058e22da68f6796fad\",\"customerId\":\"Bhavin-001\",\"productCode\":null,\"fingerprintHash\":\"3543BC73E2400CE2025FAC120C612CAC9618922203D9BD005DCB24C9491474A7\",\"issuedAt\":\"2026-01-22T06:08:41.6237661Z\",\"expiresAt\":\"2027-01-22T06:08:41.6321529Z\",\"status\":\"Active\",\"maxActivations\":1,\"activationCount\":1,\"fingerprintVersion\":\"v1\",\"signature\":\"HIuX3NjSF6+MbgH0EwtJ7TIH35/dqXkc82KUvXb702IaHDsw5OgKbfjq2rviu6Wfdm4qr4Yj3k7uTt1+XLMHIcdFzIGxekhDxx8IigtE9J6q8veWBM0iEmES1q5e0b4qyONDgVwXB4z15RsNjMLC7nLOXrpdbq8JDFj9Kb/I0k9c7EkNqjNkYe3LdISz6fQTCSv1EwN8LcV6LZbbLJIRnNfT4o3/yo4Eooj/ho53a/dA3fu2NPQjMS4lCgIP7tuINySyOK1CRZDdcKKX3M+geYiR+gckjIv/WjGZAJS20O1sIpDUSUQSqoHW7oHqUqTnO7XgaEmhhS3+a5QT8fAGTg==\"}";

      final license = jsonDecode(jsonString);

      // Payload MUST match backend signing
      final payload =
          '${license['licenseId']}|'
          '${license['fingerprintHash']}|'
          '${license['issuedAt']}|'
          '${license['expiresAt']}';

      // Verify signature
      final isValid = _verifySignature(
        payload,
        license['signature'],
        _publicKeyPem,
      );

      if (!isValid) {
        print('Invalid license signature');
        return isValid;
      }

      // Expiry check
      final expiry = DateTime.parse(license['expiresAt']);
      if (DateTime.now().isAfter(expiry)) {
        print('License expired');
        return false;
      }

      // Hardware fingerprint check
      final currentFingerprint = (await HardwareProvider.getFingerprint())
          .trim()
          .toLowerCase();

      final licenseFingerprint = license['fingerprintHash']
          .toString()
          .trim()
          .toLowerCase();

      if (currentFingerprint != licenseFingerprint) {
        print('Hardware mismatch');
        return false;
      }

      return isValid;
    } catch (e, st) {
      print('License validation error: $e , stack crash: $st');
      return false;
    }
  }

  // PointyCastle RSA verify
  static bool _verifySignature(
    String payload,
    String signatureBase64,
    String publicKeyPem,
  ) {
    final publicKey = _parsePublicKeyFromPem(publicKeyPem);

    final signer = Signer('SHA-256/RSA');
    signer.init(false, PublicKeyParameter<RSAPublicKey>(publicKey));

    final payloadBytes = Uint8List.fromList(utf8.encode(payload));
    final signatureBytes = base64.decode(signatureBase64);

    return signer.verifySignature(payloadBytes, RSASignature(signatureBytes));
  }

  // RSAPrivateKey PEM → RSAPublicKey
  static RSAPublicKey _parsePublicKeyFromPem(String pem) {
    final normalizedPem = pem
        .replaceAll('-----BEGIN PUBLIC KEY-----', '')
        .replaceAll('-----END PUBLIC KEY-----', '')
        .replaceAll('\n', '')
        .replaceAll('\r', '')
        .trim();

    final derBytes = base64.decode(normalizedPem);

    final asn1Parser = ASN1Parser(derBytes);
    final topLevelSeq = asn1Parser.nextObject() as ASN1Sequence;

    final publicKeyBitString = topLevelSeq.elements![1] as ASN1BitString;

    final publicKeyAsn = ASN1Parser(
      publicKeyBitString.stringValues as Uint8List,
    );

    final publicKeySeq = publicKeyAsn.nextObject() as ASN1Sequence;

    final modulus = publicKeySeq.elements![0] as ASN1Integer;
    final exponent = publicKeySeq.elements![1] as ASN1Integer;

    final BigInt? modulusBigInt = modulus.integer;
    final BigInt? exponentBigInt = exponent.integer;

    if (modulusBigInt == null || exponentBigInt == null) {
      throw Exception('Invalid RSA public key');
    }

    return RSAPublicKey(modulusBigInt, exponentBigInt);
  }
}