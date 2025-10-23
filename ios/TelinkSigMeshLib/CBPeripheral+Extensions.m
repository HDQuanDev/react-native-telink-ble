//
//  CBPeripheral+Extensions.m
//  TelinkSigMeshLib
//
//  Category for CBPeripheral to provide additional utility methods
//

#import "CBPeripheral+Extensions.h"

@implementation CBPeripheral (Extensions)

- (NSDictionary *)asDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if (self.identifier) {
        dict[@"uuid"] = self.identifier.UUIDString;
    }
    
    if (self.name) {
        dict[@"name"] = self.name;
    }
    
    dict[@"state"] = @(self.state);
    
    NSString *stateString = @"unknown";
    switch (self.state) {
        case CBPeripheralStateDisconnected:
            stateString = @"disconnected";
            break;
        case CBPeripheralStateConnecting:
            stateString = @"connecting";
            break;
        case CBPeripheralStateConnected:
            stateString = @"connected";
            break;
        case CBPeripheralStateDisconnecting:
            stateString = @"disconnecting";
            break;
    }
    dict[@"stateString"] = stateString;
    
    return [dict copy];
}

@end
