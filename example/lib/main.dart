import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get_settings/getsettings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String platformVersion = 'Unknown';
  String isPad = 'Unknown';
  String isiOSAppOnMac = 'Unknown';
  String getUserAgent = 'Unknown';
  String getCPUType = 'Unknown';
  String getRotationOn = 'Unknown';
  final _getsettingsPlugin = GetSettings();

  @override
  void initState() {
    super.initState();
    _getsettingsPlugin.onListenSettings((status1) {
      initPlatformState();
      setState(() {});
    }, (onError) {
      print('error:$onError');
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    platformVersion = await _getsettingsPlugin.getPlatformVersion() ??
        'Unknown platform version';
    isPad = (await _getsettingsPlugin.isPad()).toString();
    isiOSAppOnMac = (await _getsettingsPlugin.isiOSAppOnMac()).toString();
    getUserAgent = (await _getsettingsPlugin.getUserAgent())!;
    getCPUType = (await _getsettingsPlugin.getCPUType())!;
    getRotationOn = (await _getsettingsPlugin.isRotationOn()).toString();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      initPlatformState();
      setState(() {});
    });
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('isPad:$isPad'),
              Text('PlatformVersion:$platformVersion'),
              Text('isiOSAppOnMac:$isiOSAppOnMac'),
              Text('getUserAgent:$getUserAgent'),
              Text('getCPUType:$getCPUType'),
              Text('getRotationOn:$getRotationOn'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            initPlatformState();
            setState(() {});
          },
          child: const Text('Test'),
        ),
      ),
    );
  }
}
