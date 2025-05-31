import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class FingerAuth {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> authenticate(BuildContext context) async {
    try {
      return await auth.authenticate(
        localizedReason: 'Please authenticate to access this feature',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> isDeviceSupported() async {
    try {
      return await auth.isDeviceSupported();
    } catch (e) {
      print(e);
      return false;
    }
  }
}
