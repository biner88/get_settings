package com.sumsg.get_settings;
import android.content.Context;
import androidx.annotation.NonNull;
import java.util.Objects;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** GetSettingsPlugin */
public class GetSettingsPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Context context;

  private EventChannel eventState;
  private EventChannel.EventSink eventStateSink;
  private final SettingsValueChangeContentObserver mSettingsObserver = new SettingsValueChangeContentObserver();

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "get_settings");
    channel.setMethodCallHandler(this);

    eventState = new EventChannel(flutterPluginBinding.getBinaryMessenger(),
            "get_settings_channel");
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
        result.success(mSettingsObserver.getCPUType());
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
        result.success(Objects.requireNonNullElse(targetUri, ""));
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
