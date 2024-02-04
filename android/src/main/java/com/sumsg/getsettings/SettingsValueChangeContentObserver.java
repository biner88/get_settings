package com.sumsg.getsettings;

import android.content.ContentResolver;
import android.content.res.Configuration;
import android.database.ContentObserver;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.os.UserHandle;
import android.provider.Settings;
import android.content.Context;
import android.util.Log;
import android.webkit.WebSettings;
import android.webkit.WebView;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.EventChannel;

public class SettingsValueChangeContentObserver extends ContentObserver {
    public Context mContext;
    public EventChannel.EventSink eventStateSink;
    private Map<String, Object> constants;
    public SettingsValueChangeContentObserver(Handler handler) {
        super(handler);
    }

    public SettingsValueChangeContentObserver() {
        super(new Handler(Looper.getMainLooper()));
    }

    public void register(Context applicationContext) {
        mContext = applicationContext;
        ContentResolver resolver = mContext.getContentResolver();
        resolver.registerContentObserver(Settings.System.getUriFor(
                Settings.System.ACCELEROMETER_ROTATION), false, this);
        // resolver.registerContentObserver(Settings.System.getUriFor(
        // Settings.System.BLUETOOTH_ON), false, this);

        updateSettings();
    }

    public void registerEvent(EventChannel.EventSink event) {
        if (eventStateSink == null) {
            eventStateSink = event;
        }
    }

    void updateSettings() {
        Map<String, Object> map = new HashMap<>();
        map.put("isRotationOn", isRotationOn());
        // map.put("isBluetoothOn", isBluetoothOn());
        if (eventStateSink != null) {
            eventStateSink.success(map);
        }
    }
    public boolean isPad() {
        return (mContext.getResources().getConfiguration().screenLayout
                & Configuration.SCREENLAYOUT_SIZE_MASK)
                >= Configuration.SCREENLAYOUT_SIZE_LARGE;
    }
    ///
    public boolean isRotationOn() {
        return (android.provider.Settings.System.getInt(mContext.getContentResolver(),
                Settings.System.ACCELEROMETER_ROTATION, 0) == 1);
    }

//    public Map<String, Object> getProperties() {
//        if (constants != null) {
//            return constants;
//        }
//        constants = new HashMap<>();
//
//        PackageManager packageManager = applicationContext.getPackageManager();
//        String packageName = applicationContext.getPackageName();
//        String shortPackageName = packageName.substring(packageName.lastIndexOf(".") + 1);
//        String applicationName = "";
//        String applicationVersion = "";
//        int buildNumber = 0;
//        String userAgent = getUserAgent();
//        String packageUserAgent = userAgent;
//
//        try {
//            PackageInfo info = packageManager.getPackageInfo(packageName, 0);
//            applicationName = applicationContext.getApplicationInfo().loadLabel(applicationContext.getPackageManager())
//                    .toString();
//            applicationVersion = info.versionName;
//            buildNumber = info.versionCode;
//            packageUserAgent = shortPackageName + '/' + applicationVersion + '.' + buildNumber + ' ' + userAgent;
//
//        } catch (PackageManager.NameNotFoundException e) {
//            e.printStackTrace();
//        }
//
//        constants.put("systemName", "Android");
//        constants.put("systemVersion", Build.VERSION.RELEASE);
//        constants.put("packageName", packageName);
//        constants.put("shortPackageName", shortPackageName);
//        constants.put("applicationName", applicationName);
//        constants.put("applicationVersion", applicationVersion);
//        constants.put("applicationBuildNumber", buildNumber);
//        constants.put("packageUserAgent", packageUserAgent);
//        constants.put("userAgent", userAgent);
//        constants.put("webViewUserAgent", getWebViewUserAgent());
//
//        return constants;
//    }

    public String getUserAgent() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
            return WebSettings.getDefaultUserAgent(mContext).replace("; wv)",")");
        }

        WebView webView = new WebView(mContext);
        String userAgentString = webView.getSettings().getUserAgentString().replace("; wv)",")");
        destroyWebView(webView);

        return userAgentString;
    }
    private void destroyWebView(WebView webView) {
        webView.loadUrl("about:blank");
        webView.stopLoading();

        webView.clearHistory();
        webView.removeAllViews();
        webView.destroyDrawingCache();

        // NOTE: This can occasionally cause a segfault below API 17 (4.2)
        webView.destroy();
    }

    // public boolean isBluetoothOn() {
    // return
    // (android.provider.Settings.System.getInt(mContext.getContentResolver(),
    // Settings.System.BLUETOOTH_ON, 0) == 1);
    // }
    @Override
    public void onChange(boolean selfChange) {
        super.onChange(selfChange);
        updateSettings();
    }

    public void stop() {
        mContext.getContentResolver().unregisterContentObserver(this);
    }
}
