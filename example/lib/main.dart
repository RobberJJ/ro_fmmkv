import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ro_fmmkv/ro_fmmkv.dart';

import 'user.dart';
import 'package:ro_fmmkv/ro_fmmkv.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await RoFmmkv.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> textFmmkv() async {

    User user = User.fromJson({
      'name':'name',
      'email':'email@email'});

    Map map = {'one':'Android',
      'two':'IOS',
      'three':'Flutter',
      'num':123,
      'dic':{'one':'Android',
        'two':'IOS',
        'three':'Flutter',
        'num':123}};

    List list = [user,user];
    print(list);

    String str = jsonEncode(list);
    print(str);

    print(jsonDecode(str));
    print(jsonDecode(str,reviver:(key,value) {
      return value.toString();
    }).runtimeType.toString());
    print(jsonDecode(str,reviver:(key,value) {
      print('----------------');
//      print(key.runtimeType.toString() + ':' + value.runtimeType.toString());
//      print(key.toString() + ':' + value.toString());
      return value.toString();
    }));
    List resList = jsonDecode(str);
    resList.forEach(
            (map) {
          print(User.fromJson(map));
        }
    );

    bool b = false;

    print(b.toString().runtimeType.toString());
    print(b.toString());
    print(b.toString() == 'true');
    print((b.toString() == 'true').runtimeType.toString());
    print(b.toString() != 'true');


    print(jsonDecode('true').runtimeType.toString());
    print(jsonDecode('123'));

    print('777777777777777777777');

    dynamic res;
    String key = 'kTest';
    res = await RoFmmkv.setValue(list, key);
    print(res);
    res =  await RoFmmkv.getString(key);
    print(res);
    res =  await RoFmmkv.getValue(key);
    print(res);
    res =  await RoFmmkv.getValue(key,reviver: (value) {
        print('value --' + value);
      });
    print(res);


  }

  @override
  Widget build(BuildContext context) {

    textFmmkv();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
