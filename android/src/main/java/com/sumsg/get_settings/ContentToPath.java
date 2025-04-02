package com.sumsg.get_settings;

import android.content.ContentResolver;
import android.content.Context;
import android.net.Uri;
import android.util.Log;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

public class ContentToPath {
    private final Context context;
    private static final String TAG = "ContentToPath";

    public ContentToPath(Context context) {
        this.context = context;
    }

    public String export(String contentUri, boolean rewrite) {
        Uri audioUri = Uri.parse(contentUri);
        String scheme = audioUri.getScheme();
        if (scheme == null || !scheme.equals(ContentResolver.SCHEME_CONTENT)) {
            return null;
        }
        String[] projection = { android.provider.MediaStore.Audio.Media.DATA };
        android.database.Cursor cursor = this.context.getContentResolver().query(audioUri, projection, null, null,
                null);
        if (cursor != null && cursor.moveToFirst()) {
            int columnIndex = cursor.getColumnIndexOrThrow(android.provider.MediaStore.Audio.Media.DATA);
            String filePath = cursor.getString(columnIndex);
            cursor.close();
            //
            File cacheDirectory = context.getCacheDir();
            String[] parts = contentUri.split("/");
            String filename = parts[parts.length - 1];
            String extension = filePath.substring(filePath.lastIndexOf(".") + 1);
            String outFilePath = cacheDirectory + File.separator + filename + "." + extension;
            Log.d(TAG, "export: " + outFilePath);
            //
            File outFile = new File(outFilePath);
            if (outFile.exists()) {
                if (rewrite) {
                    outFile.delete();
                } else {
                    return outFilePath;
                }
            }
            if (copyFile(filePath, outFilePath)) {
                return outFilePath;
            } else {
                return "";
            }
        }
        return null;
    }

    public boolean copyFile(String oldPath, String newPath) {
        try {
            File oldFile = new File(oldPath);
            if (!oldFile.exists() || !oldFile.isFile() || !oldFile.canRead()) {
                return false;
            }
            FileInputStream fileInputStream = new FileInputStream(oldPath);
            FileOutputStream fileOutputStream = new FileOutputStream(newPath);
            byte[] buffer = new byte[1024];
            int byteRead;
            while (-1 != (byteRead = fileInputStream.read(buffer))) {
                fileOutputStream.write(buffer, 0, byteRead);
            }
            fileInputStream.close();
            fileOutputStream.flush();
            fileOutputStream.close();
            return true;
        } catch (Exception e) {
            // e.printStackTrace();
            return false;
        }
    }
}
