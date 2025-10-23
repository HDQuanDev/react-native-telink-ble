//
//  TelinkBle+Swift.m
//  TelinkBle
//
//  Objective-C implementation of Swift extension methods
//

#if __has_include(<TelinkSigMeshLib/TelinkSigMeshLib.h>)
#import <TelinkSigMeshLib/TelinkSigMeshLib.h>
#else
#import "TelinkSigMeshLib/TelinkSigMeshLib.h"
#endif

#import <CoreBluetooth/CoreBluetooth.h>
#import "TelinkBle+Swift.h"
#import "DemoCommand.h"
#import "NSString+extension.h"

@implementation TelinkBle (Swift)

RCT_EXPORT_METHOD(setDelegateForIOS) {
    [SigMeshLib.share setDelegateForDeveloper:self];
}

RCT_EXPORT_METHOD(getOnlineState) {
    int responseMaxCount = 0;
    for (SigNodeModel *node in SigDataSource.share.curNodes) {
        if (![node isSensor] && node.isKeyBindSuccess) {
            responseMaxCount += 1;
        }
    }
    
    [DemoCommand getOnlineStatusWithResponseMaxCount:responseMaxCount 
        successCallback:^(UInt16 source, UInt16 destination, SigGenericOnOffStatus * _Nonnull responseMessage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self sendEventWithName:EVENT_DEVICE_ONLINE body:@{
                    @"deviceAddress": @(source),
                    @"destination": @(destination),
                    @"responseMessage": responseMessage
                }];
            });
        }
        resultCallback:^(BOOL isResponseAll, NSError * _Nullable error) {
            // Handle result
        }];
}

RCT_EXPORT_METHOD(setStatus:(NSNumber *)meshAddress withStatus:(NSNumber *)status) {
    [DemoCommand switchOnOffWithIsOn:[status boolValue]
                             address:[meshAddress unsignedShortValue]
                     responseMaxCount:1
                                  ack:NO
                      successCallback:nil
                       resultCallback:nil];
}

RCT_EXPORT_METHOD(setBrightness:(NSNumber *)meshAddress withBrightness:(NSNumber *)brightness) {
    [DemoCommand changeBrightnessWithBrightness100:[brightness unsignedCharValue]
                                            address:[meshAddress unsignedShortValue]
                                         retryCount:0
                                   responseMaxCount:1
                                                ack:NO
                                    successCallback:nil
                                     resultCallback:nil];
}

RCT_EXPORT_METHOD(setTemperature:(NSNumber *)meshAddress withTemperature:(NSNumber *)temperature) {
    UInt16 address = [meshAddress unsignedShortValue];
    if (address < 0xC000) {
        address += 1;
    }
    [DemoCommand changeTempratureWithTemprature100:[temperature unsignedCharValue]
                                            address:address
                                         retryCount:0
                                   responseMaxCount:1
                                                ack:NO
                                    successCallback:nil
                                     resultCallback:nil];
}

RCT_EXPORT_METHOD(setHSL:(NSNumber *)meshAddress withHSL:(NSDictionary<NSString *, NSNumber *> *)hsl) {
    float h = [hsl[@"h"] floatValue] / 360.0;
    float s = [hsl[@"s"] floatValue] / 100.0;
    float l = [hsl[@"l"] floatValue] / 100.0;
    
    [DemoCommand changeHSLWithAddress:[meshAddress unsignedShortValue]
                                  hue:h
                           saturation:s
                           brightness:l
                     responseMaxCount:1
                                  ack:NO
                      successCallback:nil
                       resultCallback:nil];
}

RCT_EXPORT_METHOD(sendRawString:(NSString *)command) {
    NSString *sendString = [[command uppercaseString] removeAllSpacesAndNewLines];
    sendString = [sendString insertSpaceNum:1 charNum:2];
    sendString = [[command uppercaseString] removeAllSpacesAndNewLines];
    NSData *data = [LibTools nsstringToHex:sendString];
    
    [SDKLibCommand sendOpINIData:data
                 successCallback:^(UInt16 source, UInt16 destination, SigMeshMessage * _Nonnull responseMessage) {
                     // Handle success
                 }
                  resultCallback:^(BOOL isResponseAll, NSError * _Nullable error) {
                      // Handle result
                  }];
}

RCT_EXPORT_METHOD(recallScene:(NSNumber *)sceneAddress) {
    [DemoCommand recallSceneWithAddress:0xFFFF
                                sceneId:[sceneAddress unsignedShortValue]
                       responseMaxCount:0
                                    ack:NO
                        successCallback:nil
                         resultCallback:nil];
}

RCT_EXPORT_METHOD(autoConnect) {
    [SigBearer.share startMeshConnectWithComplete:^(BOOL successful) {
        [self sendEventWithName:EVENT_MESH_NETWORK_CONNECTION body:@[@(successful)]];
    }];
}

RCT_EXPORT_METHOD(stopScanning) {
    [SDKLibCommand stopScan];
}

RCT_EXPORT_METHOD(getNodes:(RCTPromiseResolveBlock)resolve withRejecter:(RCTPromiseRejectBlock)reject) {
    NSMutableArray *curNodes = SigDataSource.share.curNodes;
    NSMutableArray *result = [NSMutableArray array];
    
    for (SigNodeModel *node in curNodes) {
        [result addObject:@{
            @"name": node.name ?: @"",
            @"uuid": node.uuid ?: @"",
            @"macAddress": node.macAddress ?: @"",
            @"meshAddress": @(node.address),
            @"deviceKey": node.deviceKey ?: @"",
            @"hasHSL": @(node.hslAddresses.count > 0),
            @"hasLightness": @(node.temperatureAddresses.count > 0)
        }];
    }
    
    resolve(result);
}

RCT_EXPORT_METHOD(addDevice:(NSNumber *)deviceAddress withGroupAddress:(NSNumber *)groupAddress) {
    [DemoCommand editSubscribeListWithWithDestination:[deviceAddress unsignedShortValue]
                                                isAdd:YES
                                         groupAddress:[groupAddress unsignedShortValue]
                                       elementAddress:[deviceAddress unsignedShortValue]
                                     modelIdentifier:4096
                                    companyIdentifier:0
                                           retryCount:0
                                     responseMaxCount:1
                                      successCallback:^(UInt16 source, UInt16 destination, SigConfigModelSubscriptionStatus * _Nonnull responseMessage) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self sendEventWithName:EVENT_SET_GROUP_SUCCESS body:@{
                @"deviceAddress": deviceAddress,
                @"groupAddress": @(responseMessage.address),
                @"opcode": @(responseMessage.opCode)
            }];
        });
    }
                                       resultCallback:^(BOOL isResponseAll, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self sendEventWithName:EVENT_SET_GROUP_FAILED body:@{
                @"deviceAddress": deviceAddress
            }];
        });
    }];
}

RCT_EXPORT_METHOD(removeDevice:(NSNumber *)deviceAddress withGroupAddress:(NSNumber *)groupAddress) {
    [DemoCommand editSubscribeListWithWithDestination:[deviceAddress unsignedShortValue]
                                                isAdd:NO
                                         groupAddress:[groupAddress unsignedShortValue]
                                       elementAddress:[deviceAddress unsignedShortValue]
                                     modelIdentifier:4096
                                    companyIdentifier:0
                                           retryCount:1
                                     responseMaxCount:1
                                      successCallback:^(UInt16 source, UInt16 destination, SigConfigModelSubscriptionStatus * _Nonnull responseMessage) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *eventName = responseMessage.isSuccess ? EVENT_SET_GROUP_SUCCESS : EVENT_SET_GROUP_FAILED;
            [self sendEventWithName:eventName body:@{
                @"deviceAddress": @(source),
                @"groupAddress": @(responseMessage.address),
                @"opcode": @(responseMessage.opCode)
            }];
        });
    }
                                       resultCallback:^(BOOL isResponseAll, NSError * _Nullable error) {
        // Handle result
    }];
}

RCT_EXPORT_METHOD(resetNode:(NSNumber *)meshAddress) {
    [DemoCommand kickoutDevice:[meshAddress unsignedShortValue]
                    retryCount:0
              responseMaxCount:1
               successCallback:^(UInt16 source, UInt16 destination, SigConfigNodeResetStatus * _Nonnull responseMessage) {
        [SigDataSource.share deleteNodeFromMeshNetworkWithDeviceAddress:source];
        [self sendEventWithName:EVENT_NODE_RESET_SUCCESS body:@(source)];
    }
                resultCallback:^(BOOL isResponseAll, NSError * _Nullable error) {
        // Handle result
    }];
}

RCT_EXPORT_METHOD(openBluetoothSubSetting) {
    CBCentralManager *manager = [[CBCentralManager alloc] initWithDelegate:nil
                                                                     queue:nil
                                                                   options:@{CBCentralManagerOptionShowPowerAlertKey: @YES}];
    (void)manager; // Suppress unused variable warning
}

@end

@implementation NSData (HexEncoding)

- (NSString *)hexEncodedString {
    const unsigned char *bytes = (const unsigned char *)self.bytes;
    NSMutableString *hex = [NSMutableString stringWithCapacity:self.length * 3];
    
    for (NSUInteger i = 0; i < self.length; i++) {
        if (i > 0) {
            [hex appendString:@":"];
        }
        [hex appendFormat:@"%02hhx", bytes[i]];
    }
    
    return [hex copy];
}

@end
