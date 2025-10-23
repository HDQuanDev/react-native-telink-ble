//
//  CBPeripheral+Extensions.h
//  TelinkSigMeshLib
//
//  Category for CBPeripheral to provide additional utility methods
//

#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBPeripheral (Extensions)

/// Converts peripheral information to a dictionary representation
/// @return Dictionary containing peripheral UUID, name, and state
- (NSDictionary *)asDictionary;

@end

NS_ASSUME_NONNULL_END
