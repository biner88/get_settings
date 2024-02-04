package com.sumsg.getsettings;

import android.os.Handler;
import android.provider.Settings;
import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.EventChannel;

/** GetsettingsPlugin */
public class GetsettingsPlugin implements FlutterPlugin, MethodCallHandler {
  private MethodChannel channel;
  private Context applicationContext;

  private EventChannel eventState;
  private EventChannel.EventSink eventStateSink;
  private SettingsValueChangeContentObserver mSettingsObserver = new SettingsValueChangeContentObserver();

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "GetsettingsPlugin");
    channel.setMethodCallHandler(this);

    eventState = new EventChannel(flutterPluginBinding.getBinaryMessenger(),
        "GetSettingsChannel");
    eventState.setStreamHandler(new EventChannel.StreamHandler() {
      @Override
      public void onListen(Object args, EventChannel.EventSink events) {
        eventStateSink = events;
      }

      @Override
      public void onCancel(Object args) {
        eventStateSink = null;
      }
    });

    applicationContext = flutterPluginBinding.getApplicationContext();
    mSettingsObserver.register(applicationContext);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    // mSettingsObserver.mContext = applicationContext;
    // mSettingsObserver.eventStateSink = eventStateSink;

    switch (call.method) {
      case "isRotationOn":
        mSettingsObserver.registerEvent(eventStateSink);
        result.success(mSettingsObserver.isRotationOn());
        break;
      case "getPlatformVersion":
        result.success(android.os.Build.VERSION.RELEASE);
        break;
      case "isiOSAppOnMac":
        result.success(false);
        break;
      case "getUserAgent":
        result.success(mSettingsObserver.getUserAgent());
        break;
      case "getCPUType":
        result.success("unkown");
        break;
      case "isPad":
        result.success(mSettingsObserver.isPad());
        break;
      default:
        result.notImplemented();
        break;
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    eventState.setStreamHandler(null);
    applicationContext = null;
    mSettingsObserver.stop();
  }
}
