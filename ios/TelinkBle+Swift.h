//
//  TelinkBle+Swift.h
//  TelinkBle
//
//  Objective-C implementation of Swift extension methods
//

#import <Foundation/Foundation.h>
#import "TelinkBle.h"

@interface TelinkBle (Swift)

- (void)setDelegateForIOS;
- (void)getOnlineState;
- (void)setStatus:(NSNumber *)meshAddress withStatus:(NSNumber *)status;
- (void)setBrightness:(NSNumber *)meshAddress withBrightness:(NSNumber *)brightness;
- (void)setTemperature:(NSNumber *)meshAddress withTemperature:(NSNumber *)temperature;
- (void)setHSL:(NSNumber *)meshAddress withHSL:(NSDictionary<NSString *, NSNumber *> *)hsl;
- (void)sendRawString:(NSString *)command;
- (void)recallScene:(NSNumber *)sceneAddress;
- (void)autoConnect;
- (void)stopScanning;
- (void)getNodes:(RCTPromiseResolveBlock)resolve withRejecter:(RCTPromiseRejectBlock)reject;
- (void)addDevice:(NSNumber *)deviceAddress withGroupAddress:(NSNumber *)groupAddress;
- (void)removeDevice:(NSNumber *)deviceAddress withGroupAddress:(NSNumber *)groupAddress;
- (void)resetNode:(NSNumber *)meshAddress;
- (void)openBluetoothSubSetting;

@end

@interface NSData (HexEncoding)

- (NSString *)hexEncodedString;

@end
