/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the QtAndroidExtras module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

package org.qtproject.example.notification;
import org.qtproject.qt5.android.bindings.QtApplication;
import org.qtproject.qt5.android.QtNative;
import android.app.Notification;
import android.app.NotificationManager;
import android.content.Context;
import android.os.Bundle;

import android.content.Intent;
import android.widget.Toast;
import android.os.Handler;
import android.os.Message;
import android.os.StrictMode;

import android.support.v4.content.FileProvider;
import android.app.Activity;
import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import android.os.Message;
import android.os.SystemClock;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;

import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Bundle;
import android.os.Build.VERSION;

import android.os.Build;
import android.os.Build.VERSION;

import java.io.File;
import android.net.Uri;
import java.text.SimpleDateFormat;
import android.os.Environment;
import android.provider.MediaStore;
import android.graphics.Rect;
import android.view.Window;
import android.content.ContentResolver;
import android.content.ContentUris;
import android.content.Context;

import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;
import android.view.ViewTreeObserver;
import android.graphics.Rect;
import android.view.ViewGroup;
import android.provider.DocumentsContract;
import     android.content.ContentUris;

public class NotificationClient extends org.qtproject.qt5.android.bindings.QtActivity
{
   private static NotificationClient mInstance = null;
   public static Activity instanceActivity;
   private static Rect keyboardRectangle;

   public static native void fileSelected(String fileName);
   static final int REQUEST_OPEN_IMAGE = 1;

 private static ContentResolver contentResolver;

   public NotificationClient()
   {
       mInstance = this;
    System.out.println("Login Create.......===========>"+Build.VERSION.SDK_INT);
       }

   /**
     * @see {@link Activity#onCreate}
     */

    @Override
    public void onCreate(Bundle savedInstanceState) {
       super.onCreate(savedInstanceState);
       System.out.println("Login Create.......===========>");
        mInstance = this;

        System.out.println("Login Create.......===========>"+Build.VERSION.SDK_INT);


    }


    public static void installApk(String filePath,org.qtproject.qt5.android.bindings.QtActivity activity){

    }

    @Override
    protected void onDestroy()
    {
       super.onDestroy();
    }

    public static void notify(String s,org.qtproject.qt5.android.bindings.QtActivity activity)
    {
          System.out.println("try to call native method");
          final View myRootView = ((ViewGroup)activity.findViewById(android.R.id.content)).getChildAt(0);
          System.out.println("try to call native method"+myRootView);
          instanceActivity=activity;
          myRootView.getViewTreeObserver().addOnGlobalLayoutListener(
          new ViewTreeObserver.OnGlobalLayoutListener() {
            @Override
            public void onGlobalLayout() {
                Rect outRect = new Rect();
                instanceActivity.getWindow().getDecorView().getWindowVisibleDisplayFrame(outRect);
                keyboardRectangle = new Rect();
                myRootView.getWindowVisibleDisplayFrame(keyboardRectangle);
                 System.out.println("outRect====>"+outRect);
                 int screenHeight = myRootView.getRootView().getHeight();

                 System.out.println("try to call native method====>"+screenHeight);
                 int magic = 0;
                 int virtualKeyboardHeight = screenHeight - (keyboardRectangle.bottom - keyboardRectangle.top)
                                            - outRect.top - magic;
                System.out.println("try to call native method====>"+virtualKeyboardHeight);
                QqLoginCallbacks.onLoginSuccess(virtualKeyboardHeight);
            }
        });
    }

     ////////////////


    public  static void openAnImage(String filePath,org.qtproject.qt5.android.bindings.QtActivity activity)
     {
//          Intent intent = new Intent(Intent.ACTION_GET_CONTENT);
//          intent.setType("image/*");
//          activity.startActivityForResult(intent, REQUEST_OPEN_IMAGE);

 System.out.println("Login Create.......===========>"+Build.VERSION.SDK_INT);

        String result = "";
        Uri uri = MediaStore.Images.Media.EXTERNAL_CONTENT_URI;

        contentResolver = activity.getContentResolver();
        Cursor cursor = contentResolver.query(uri, null, null, null, null);
        if (cursor == null || cursor.getCount() <= 0)
        {
            System.out.println("NO IMAGE !!");
            return ; // 没有图片
        }
        while (cursor.moveToNext())
        {
            int index = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA);
            String path = cursor.getString(index); // 文件地址
            File file = new File(path);
            if (file.exists())
            {
                result += "|" + path;
            }

         System.out.println(path);

        }
        cursor.close();



    }


      @Override
      protected  void onActivityResult(int requestCode, int resultCode, Intent data)
      {
          System.out.println("onActivityResult");


         if (resultCode == RESULT_OK)
          {
              if(requestCode == REQUEST_OPEN_IMAGE)
              {
                  String filePath = getPath(getApplicationContext(), data.getData());
                  fileSelected(filePath);
              }
          }
          else
          {
              fileSelected(":(");
          }
          super.onActivityResult(requestCode, resultCode, data);
      }

      private void dispatchOpenGallery()
      {
          System.out.println("dispatchOpenGallery");

          Intent intent = new Intent(Intent.ACTION_GET_CONTENT);
          intent.setType("image/*");
          startActivityForResult(intent, REQUEST_OPEN_IMAGE);
      }

      /**
       * Get a file path from a Uri. This will get the the path for Storage Access
       * Framework Documents, as well as the _data field for the MediaStore and
       * other file-based ContentProviders.
       *
       * @param context The context.
       * @param uri The Uri to query.
       * @author paulburke
       */
      public static String getPath(final Context context, final Uri uri) {

          final boolean isKitKat = Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT;

          // DocumentProvider
          if (isKitKat && DocumentsContract.isDocumentUri(context, uri)) {
              // ExternalStorageProvider
              if (isExternalStorageDocument(uri)) {
                  final String docId = DocumentsContract.getDocumentId(uri);
                  final String[] split = docId.split(":");
                  final String type = split[0];

                  if ("primary".equalsIgnoreCase(type)) {
                      return Environment.getExternalStorageDirectory() + "/" + split[1];
                  }

                  // TODO handle non-primary volumes
              }
              // DownloadsProvider
              else if (isDownloadsDocument(uri)) {

                  final String id = DocumentsContract.getDocumentId(uri);
                  final Uri contentUri = ContentUris.withAppendedId(
                          Uri.parse("content://downloads/public_downloads"), Long.valueOf(id));

                  return getDataColumn(context, contentUri, null, null);
              }
              // MediaProvider
              else if (isMediaDocument(uri)) {
                  final String docId = DocumentsContract.getDocumentId(uri);
                  final String[] split = docId.split(":");
                  final String type = split[0];

                  Uri contentUri = null;
                  if ("image".equals(type)) {
                      contentUri = MediaStore.Images.Media.EXTERNAL_CONTENT_URI;
                  } else if ("video".equals(type)) {
                      contentUri = MediaStore.Video.Media.EXTERNAL_CONTENT_URI;
                  } else if ("audio".equals(type)) {
                      contentUri = MediaStore.Audio.Media.EXTERNAL_CONTENT_URI;
                  }

                  final String selection = "_id=?";
                  final String[] selectionArgs = new String[] {
                          split[1]
                  };

                  return getDataColumn(context, contentUri, selection, selectionArgs);
              }
          }
          // MediaStore (and general)
          else if ("content".equalsIgnoreCase(uri.getScheme())) {
              return getDataColumn(context, uri, null, null);
          }
          // File
          else if ("file".equalsIgnoreCase(uri.getScheme())) {
              return uri.getPath();
          }

          return null;
      }

      /**
       * Get the value of the data column for this Uri. This is useful for
       * MediaStore Uris, and other file-based ContentProviders.
       *
       * @param context The context.
       * @param uri The Uri to query.
       * @param selection (Optional) Filter used in the query.
       * @param selectionArgs (Optional) Selection arguments used in the query.
       * @return The value of the _data column, which is typically a file path.
       */
      public static String getDataColumn(Context context, Uri uri, String selection,
              String[] selectionArgs) {

          Cursor cursor = null;
          final String column = "_data";
          final String[] projection = {
                  column
          };

          try {
              cursor = context.getContentResolver().query(uri, projection, selection, selectionArgs,
                      null);
              if (cursor != null && cursor.moveToFirst()) {
                  final int column_index = cursor.getColumnIndexOrThrow(column);
                  return cursor.getString(column_index);
              }
          } finally {
              if (cursor != null)
                  cursor.close();
          }
          return null;
      }


      /**
       * @param uri The Uri to check.
       * @return Whether the Uri authority is ExternalStorageProvider.
       */
      public static boolean isExternalStorageDocument(Uri uri) {
          return "com.android.externalstorage.documents".equals(uri.getAuthority());
      }

      /**
       * @param uri The Uri to check.
       * @return Whether the Uri authority is DownloadsProvider.
       */
      public static boolean isDownloadsDocument(Uri uri) {
          return "com.android.providers.downloads.documents".equals(uri.getAuthority());
      }

      /**
       * @param uri The Uri to check.
       * @return Whether the Uri authority is MediaProvider.
       */
      public static boolean isMediaDocument(Uri uri) {
          return "com.android.providers.media.documents".equals(uri.getAuthority());
      }




}


class QqLoginCallbacks {
    public static native void onLoginSuccess(int height);
}

