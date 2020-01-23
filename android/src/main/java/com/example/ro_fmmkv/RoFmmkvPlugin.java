package com.example.ro_fmmkv;

import androidx.annotation.NonNull;

import org.json.JSONException;
import org.json.JSONObject;
import com.tencent.mmkv.MMKV;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** RoFmmkvPlugin */
public class RoFmmkvPlugin implements FlutterPlugin, MethodCallHandler {
  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    final MethodChannel channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "ro_fmmkv");
    channel.setMethodCallHandler(new RoFmmkvPlugin());
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "ro_fmmkv");
    channel.setMethodCallHandler(new RoFmmkvPlugin());
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    JSONObject params;
     try {
       params = new JSONObject((String)call.arguments);
     } catch (JSONException e) {
       return;
     }
    String key = (String)params.opt("key");
    String value = (String)params.opt("value");

    String basePath = null;
    String rootDir = null;
    String mmapId = null;
    String cryptKey = null;
    String relativePath = null;

    String config = (String)params.opt("config");
    if (config != null) {
      try {
        params = new JSONObject(config);
      } catch (JSONException e) {
        params = null;
      }
    } else  {
      params = null;
    }
    if (params != null) {
      basePath = (String)params.opt("basePath");
      rootDir = (String)params.opt("rootDir");
      mmapId = (String)params.opt("mmapId");
      cryptKey = (String)params.opt("cryptKey");
      relativePath = (String)params.opt("relativePath");
    }


    MMKV mmkv = nil;
    if (mmapId == null || mmapId.length() == 0) {
      mmkv = MMKV.defaultMMKV();
    } else {
//      mmkv = (MMKV mmkvWithID:mmapId cryptKey:cryptKey?(cryptKey dataUsingEncoding:NSUTF8StringEncoding):nil relativePath:relativePath);
    }
//    if (.opt("setString" isEqualToString:call.method)) {
//      if (key.length == 0) {
//        result(@{@"error":@"Error: key is not a valid string or length is 0."});
//        return;
//      }
//      if (!(value isKindOfClass:(NSString class)) || value.length <= 0) {
//        result(@{@"error":@"Error: value is not string type or length is 0."});
//        return;
//      }
//      BOOL res = (mmkv setString:value forKey:key);
//
//      result(@{@"res":@(res),@"args":call.arguments});
//    } else if (.opt("getString" isEqualToString:call.method)) {
//      if (key.length == 0) {
//        result(@{@"error":@"Error: key is not a valid string or length is 0."});
//        return;
//      }
//      String value = (mmkv getStringForKey:key);
//      result(@{@"value":value,@"args":call.arguments});
//    } else if (.opt("remove" isEqualToString:call.method)) {
//      if (key.length == 0) {
//        result(@{@"error":@"Error: key is not a valid string or length is 0."});
//        return;
//      }
//        (mmkv removeValueForKey:key);
//      result(@{@"res":@YES,@"args":call.arguments});
//    } else if (.opt("removes" isEqualToString:call.method)) {
//      if (key.length == 0) {
//        result(@{@"error":@"Error: key is not a valid string or length is 0."});
//        return;
//      }
//      NSArray * keys = (key componentsSeparatedByString:@",");
//        (mmkv removeValuesForKeys:keys);
//      result(@{@"res":@YES,@"args":call.arguments});
//    } else if (.opt("clearAll" isEqualToString:call.method)) {
//        (mmkv clearAll);
//      result(@{@"res":@YES,@"args":call.arguments});
//    } else if (.opt("clearMemoryCache" isEqualToString:call.method)) {
//        (mmkv clearMemoryCache);
//      result(@{@"res":@YES,@"args":call.arguments});
//    } else if (.opt("close" isEqualToString:call.method)) {
//        (mmkv close);
//      result(@{@"res":@YES,@"args":call.arguments});
//    } else
      if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
  }
}
