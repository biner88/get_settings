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

/** Get settings Plugin */
public class GetsettingsPlugin implements FlutterPlugin, MethodCallHandler {
  private MethodChannel channel;
  private Context context;

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

    context = flutterPluginBinding.getApplicationContext();
    mSettingsObserver.register(context);
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
      case "ipodToPath":
        result.success("");
        break;
      case "contentToPath":
        String contentUri = call.argument("contentUri");
        boolean rewrite = Boolean.FALSE.equals(call.argument("rewrite"));
        ContentToPath contentToPath = new ContentToPath(context);
        String targetUri = contentToPath.export(contentUri,rewrite);
        if (targetUri!=null){
          result.success(targetUri);
        }else{
          result.success("");
        }
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
    context = null;
    mSettingsObserver.stop();
  }
}
