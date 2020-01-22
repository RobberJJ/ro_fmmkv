#import "RoFmmkvPlugin.h"
#import <MMKV/MMKV.h>

@implementation RoFmmkvPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"ro_fmmkv"
            binaryMessenger:[registrar messenger]];
  RoFmmkvPlugin* instance = [[RoFmmkvPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString *homeDir = NSHomeDirectory();
    //参数校验
    if (![call.arguments isKindOfClass:[NSString class]] || [call.arguments length] <=0) {
        result(@{@"error":@"Error: arguments type is wrong or is not a valid string."});
        return;
    }
    
    NSData * jsonData = [(NSString *)call.arguments dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * params = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    if (nil == params) {
        result(@{@"error":@"Error: arguments is not a valid json string."});
        return;
    }
    if (![params isKindOfClass:[NSDictionary class]]) {
        result(@{@"error":@"Error: arguments is not a valid string with NSDictionary(or Map) type."});
        return;
    }
    
    NSString * key = params[@"key"];
    NSString * value = params[@"value"];
    
    NSString * basePath = params[@"config"][@"basePath"];
    NSString * rootDir = params[@"config"][@"rootDir"];
    NSString * mmapId = params[@"config"][@"mmapId"];
    NSString * cryptKey = params[@"config"][@"cryptKey"];
    NSString * relativePath = params[@"config"][@"relativePath"];
    
    MMKV * mmkv = nil;
    if ([mmapId isEqual:[NSNull null]] || [mmapId length]) {
        mmkv = [MMKV defaultMMKV];
    } else {
        mmkv = [MMKV mmkvWithID:mmapId cryptKey:cryptKey?[cryptKey dataUsingEncoding:NSUTF8StringEncoding]:nil relativePath:relativePath];
    }
    if ([@"setString" isEqualToString:call.method]) {
        if (key.length == 0) {
            result(@{@"error":@"Error: key is not a valid string or length is 0."});
            return;
        }
        if (![value isKindOfClass:[NSString class]] || value.length <= 0) {
            result(@{@"error":@"Error: value is not string type or length is 0."});
            return;
        }
        BOOL res = [mmkv setString:value forKey:key];
        
        result(@{@"res":@(res),@"args":call.arguments});
    } else if ([@"getString" isEqualToString:call.method]) {
        if (key.length == 0) {
            result(@{@"error":@"Error: key is not a valid string or length is 0."});
            return;
        }
        NSString * value = [mmkv getStringForKey:key];
        result(@{@"value":value,@"args":call.arguments});
    } else if ([@"remove" isEqualToString:call.method]) {
        if (key.length == 0) {
            result(@{@"error":@"Error: key is not a valid string or length is 0."});
            return;
        }
        [mmkv removeValueForKey:key];
        result(@{@"res":@YES,@"args":call.arguments});
    } else if ([@"removes" isEqualToString:call.method]) {
        if (key.length == 0) {
            result(@{@"error":@"Error: key is not a valid string or length is 0."});
            return;
        }
        NSArray * keys = [key componentsSeparatedByString:@","];
        [mmkv removeValuesForKeys:keys];
        result(@{@"res":@YES,@"args":call.arguments});
    } else if ([@"clearAll" isEqualToString:call.method]) {
        [mmkv clearAll];
        result(@{@"res":@YES,@"args":call.arguments});
    } else if ([@"clearMemoryCache" isEqualToString:call.method]) {
        [mmkv clearMemoryCache];
        result(@{@"res":@YES,@"args":call.arguments});
    } else if ([@"close" isEqualToString:call.method]) {
        [mmkv close];
        result(@{@"res":@YES,@"args":call.arguments});
    } else if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
