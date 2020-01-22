import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

class RoFmmkvConfig {
  String basePath;
  String rootDir;
  String mmapId;
  String cryptKey;
  String relativePath;

  Map<String, dynamic> toJson() {
    return {
      "basePath": this.basePath,
      "rootDir": this.rootDir,
      "mmapId": this.mmapId,
      "cryptKey": this.cryptKey,
      "relativePath": this.relativePath,
    };
  }
}

class RoFmmkv {
  static const MethodChannel _channel =
      const MethodChannel('ro_fmmkv');
  static RoFmmkvConfig config = RoFmmkvConfig();

  static void updateConfig(RoFmmkvConfig newConfig) {
    config = newConfig;
  }

  static Future<bool> setString(String value, String key, {RoFmmkvConfig newConfig}) async {
    Map map = Map.identity();
    map['config'] = newConfig??config;
    map['key'] = key;
    map['value'] = value;
    final Map res = await _channel.invokeMethod('setString',jsonEncode(map));
    return res['res'];
  }

  static Future<bool> setValue(dynamic value, String key, {RoFmmkvConfig newConfig}) async {
    bool isBasicType = (value is bool) || (value is int) || (value is double);
    String realValue;
    if(isBasicType) {
      realValue = value.toString();
    } else {
      realValue = jsonEncode(value);
    }
    return setString(realValue, key, newConfig: newConfig);
  }
  
  static Future<String> getString(String key, {RoFmmkvConfig newConfig}) async {
    Map map = Map.identity();
    map['config'] = newConfig??config;
    map['key'] = key;
    final Map res = await _channel.invokeMethod('getString',jsonEncode(map));
    return res['value'];
  }

  static Future<dynamic> getValue(String key, {RoFmmkvConfig newConfig, reviver(String value)}) async {
    final String value = await getString(key, newConfig: newConfig);
    if(reviver != null) reviver(value);
    dynamic realValue;
    try {
      realValue = jsonDecode(value);
    } catch (_) {
      realValue = value;
    }
    return realValue;
  }

  static Future remove(String key, {RoFmmkvConfig newConfig}) async {
    Map map = Map.identity();
    map['config'] = newConfig??config;
    map['key'] = key;
    return await _channel.invokeMethod('remove',jsonEncode(map));;
  }

  static Future removes(String keys, {RoFmmkvConfig newConfig}) async {
    Map map = Map.identity();
    map['config'] = newConfig??config;
    map['key'] = keys;
    return await _channel.invokeMethod('removes',jsonEncode(map));;
  }

  static Future clearAll({RoFmmkvConfig newConfig}) async {
    Map map = Map.identity();
    map['config'] = newConfig??config;
    return await _channel.invokeMethod('clearAll',jsonEncode(map));;
  }

  static Future clearMemoryCache({RoFmmkvConfig newConfig}) async {
    Map map = Map.identity();
    map['config'] = newConfig??config;
    return await _channel.invokeMethod('clearMemoryCache',jsonEncode(map));;
  }

  static Future close({RoFmmkvConfig newConfig}) async {
    Map map = Map.identity();
    map['config'] = newConfig??config;
    return await _channel.invokeMethod('close',jsonEncode(map));;
  }

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
