import 'package:flutter/material.dart';
import 'dart:async';

import 'package:get_settings/get_settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String platformVersion = 'Not Supported';
  String isPad = 'Not Supported';
  String isiOSAppOnMac = 'Not Supported';
  String getUserAgent = 'Not Supported';
  String getCPUType = 'Not Supported';
  String getRotationOn = 'Not Supported';
  final _getsettingsPlugin = GetSettings();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initPlatformState();
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    platformVersion =
        await _getsettingsPlugin.getPlatformVersion() ??
        'Unknown platform version';
    isPad = (await _getsettingsPlugin.isPad()).toString();
    isiOSAppOnMac = (await _getsettingsPlugin.isiOSAppOnMac()).toString();
    getUserAgent = (await _getsettingsPlugin.getUserAgent())!;
    getCPUType = (await _getsettingsPlugin.getCPUType())!;
    getRotationOn = (await _getsettingsPlugin.isRotationOn()).toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Container(
          padding: EdgeInsets.all(15),
          child: ListView(
            children: [
              ListTile(
                title: _buildTitle('Is Pad'),
                subtitle: _buildText(isPad),
              ),
              ListTile(
                title: _buildTitle('Platform Version'),
                subtitle: _buildText(platformVersion),
              ),
              ListTile(
                title: _buildTitle('IOS App On Mac'),
                subtitle: _buildText(isiOSAppOnMac),
              ),
              ListTile(
                title: _buildTitle('User Agent'),
                subtitle: _buildText(getUserAgent),
              ),
              ListTile(
                title: _buildTitle('CPU Type'),
                subtitle: _buildText(getCPUType),
              ),
              ListTile(
                title: _buildTitle('Rotation Lock State'),
                subtitle: _buildText(getRotationOn),
              ),
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

  Widget _buildTitle(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 20, color: Colors.black45),
    );
  }

  Widget _buildText(String text) {
    return Text(text, style: const TextStyle(fontSize: 20));
  }
}
