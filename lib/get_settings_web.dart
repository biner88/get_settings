// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:web/web.dart' as web;

import 'get_settings_platform_interface.dart';

/// A web implementation of the GetSettingsPlatform of the GetSettings plugin.
class GetSettingsWeb extends GetSettingsPlatform {
  /// Constructs a GetSettingsWeb
  GetSettingsWeb();

  static void registerWith(Registrar registrar) {
    GetSettingsPlatform.instance = GetSettingsWeb();
  }

  @override
  void onListenSettings(onEvent, onError) {}

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String?> getPlatformVersion() async {
    final version = web.window.navigator.userAgent;
    return version;
  }

  @override
  Future<bool?> isRotationOn() async {
    return null;
  }

  @override
  Future<bool?> isiOSAppOnMac() async {
    return null;
  }

  @override
  Future<String?> getUserAgent() async {
    return web.window.navigator.userAgent;
  }

  @override
  Future<String?> getCPUType() async {
    return "Unknown";
  }

  @override
  Future<bool?> isPad() async {
    final userAgent = web.window.navigator.userAgent.toLowerCase();
    return userAgent.contains("ipad") || userAgent.contains("tablet");
  }
}
