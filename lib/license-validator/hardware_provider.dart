//import 'dart:io';
import 'dart:convert';
import 'package:crypto/crypto.dart';
//import 'package:process_run/shell.dart';

class HardwareProvider {
  static Future<String> getFingerprint() async {
    String rawFingerprint = '';
    /*if (Platform.isWindows) {
      // Getting MachineGuid, BIOS Serial, and ProcessorID via PowerShell
      var shell = Shell();

      // Machine GUID
      var guidRes = await shell.run(
        'reg query "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Cryptography" /v MachineGuid',
      );
      String guid = guidRes.outText.split('Reg_SZ').last.trim();

      // BIOS Serial
      var biosRes = await shell.run('wmic bios get serialnumber');
      String bios = biosRes.outText.replaceAll('SerialNumber', '').trim();

      // CPU ID
      var cpuRes = await shell.run('wmic cpu get processorid');
      String cpu = cpuRes.outText.replaceAll('ProcessorId', '').trim();
      rawFingerprint = '$guid|$bios|$cpu';
    } else {
      rawFingerprint =
          '6c7a9790-dc9d-4b0e-a38a-2a0b5b4ec86b|PF38R0TL|BFEBFBFF000806C1';
    }*/
    rawFingerprint = '6c7a9790-dc9d-4b0e-a38a-2a0b5b4ec86b|PF38R0TL|BFEBFBFF000806C1';
    return sha256.convert(utf8.encode(rawFingerprint)).toString().toUpperCase();
  }
}