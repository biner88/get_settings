package com.sumsg.get_settings;

import android.content.ContentResolver;
import android.content.res.Configuration;
import android.database.ContentObserver;
import android.os.Handler;
import android.os.Looper;
import android.provider.Settings;
import android.content.Context;
import android.util.Log;
import android.webkit.WebSettings;
import java.util.HashMap;
import java.util.Map;
import io.flutter.plugin.common.EventChannel;

public class SettingsValueChangeContentObserver extends ContentObserver {
    public Context mContext;
    public EventChannel.EventSink eventStateSink;

    public SettingsValueChangeContentObserver() {
        super(new Handler(Looper.getMainLooper()));
    }

    public void register(Context applicationContext) {
        mContext = applicationContext;
        ContentResolver resolver = mContext.getContentResolver();
        resolver.registerContentObserver(Settings.System.getUriFor(
                Settings.System.ACCELEROMETER_ROTATION), false, this);
        updateSettings();
    }

    public void registerEvent(EventChannel.EventSink event) {
        eventStateSink = event;
    }

    void updateSettings() {
        Map<String, Object> map = new HashMap<>();
        map.put("isRotationOn", isRotationOn());
        if (eventStateSink != null) {
            eventStateSink.success(map);
        }
    }

    public boolean isPad() {
        return (mContext.getResources().getConfiguration().screenLayout
                & Configuration.SCREENLAYOUT_SIZE_MASK) >= Configuration.SCREENLAYOUT_SIZE_LARGE;
    }

    ///
    public boolean isRotationOn() {
        return (android.provider.Settings.System.getInt(mContext.getContentResolver(),
                Settings.System.ACCELEROMETER_ROTATION, 0) == 1);
    }

    public String getUserAgent() {
        return WebSettings.getDefaultUserAgent(mContext).replace("; wv)", ")");

    }

    public String getCPUType() {
        String cpuType = null;
        String arch = System.getProperty("os.arch");
        // Log.d("getCPUType", "getCPUType: "+arch);
        if (arch != null) {
            switch (arch.toLowerCase()) {
                case "arm":
                    cpuType = "ARM";
                    break;
                case "arm64":
                    cpuType = "ARM64";
                    break;
                case "x86":
                    cpuType = "X86";
                    break;
                case "x86_64":
                    cpuType = "X86_64";
                    break;
                default:
                    cpuType = arch.toUpperCase();
                    break;
            }
        }
        return cpuType;
    }

    @Override
    public void onChange(boolean selfChange) {
        super.onChange(selfChange);
        updateSettings();
    }

    public void stop() {
        mContext.getContentResolver().unregisterContentObserver(this);
    }
}
