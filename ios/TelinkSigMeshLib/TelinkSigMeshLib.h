/********************************************************************************************************
* @file     TelinkSigMeshLib.h
*
* @brief    for TLSR chips
*
* @author     telink
* @date     Sep. 30, 2010
*
* @par      Copyright (c) 2010, Telink Semiconductor (Shanghai) Co., Ltd.
*           All rights reserved.
*
*             The information contained herein is confidential and proprietary property of Telink
*              Semiconductor (Shanghai) Co., Ltd. and is available under the terms
*             of Commercial License Agreement between Telink Semiconductor (Shanghai)
*             Co., Ltd. and the licensee in separate contract or the terms described here-in.
*           This heading MUST NOT be removed from this file.
*
*              Licensees are granted free, non-transferable use of the information in this
*             file under Mutual Non-Disclosure Agreement. NO WARRENTY of ANY KIND is provided.
*
*******************************************************************************************************/
//
//  TelinkSigMeshLib.h
//  TelinkSigMeshLib
//
//  Created by 梁家誌 on 2019/10/21.
//  Copyright © 2019 Telink. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for TelinkSigMeshLib.
FOUNDATION_EXPORT double TelinkSigMeshLibVersionNumber;

//! Project version string for TelinkSigMeshLib.
FOUNDATION_EXPORT const unsigned char TelinkSigMeshLibVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <PublicHeader.h"

#import <CoreBluetooth/CoreBluetooth.h>

/*注意：
 1.注释‘#define kExist’则生成不包含MeshOTA、remote provision代码的库TelinkSigMeshLib.framework，demo需要导入头文件‘#import "TelinkSigMeshLib.h"’
 2.不注释‘#define kExist’则生成包含MeshOTA、remote provision代码的库TelinkSigMeshLibExtensions.framework，demo需要导入头文件‘#import "TelinkSigMeshLib.h"’
 3.default release TelinkSigMeshLib.framework.
 */
//#define kExist
#ifndef kExist

// 1.该部分为不包含MeshOTA、remote provision代码的公开头文件
/*是否存在MeshOTA功能*/
#define kExistMeshOTA   (NO)
/*是否存在remote provision功能*/
#define kExistRemoteProvision   (NO)
#import "SigConst.h"
#import "SigEnumeration.h"
#import "SigStruct.h"
#import "SigLogger.h"
#import "SigModel.h"
#import "BackgroundTimer.h"
#import "SigBearer.h"
#import "SigDataSource.h"
#import "SDKLibCommand.h"
#import "SigConfigMessage.h"
#import "SigMeshMessage.h"
#import "SigMeshLib.h"
#import "SigHelper.h"
#import "SigMessageHandle.h"
#import "SigProxyConfigurationMessage.h"
#import "LibTools.h"
#import "SigGenericMessage.h"
#import "SigHearbeatMessage.h"
#import "OTAManager.h"
#import "SigPublishManager.h"
#import "TelinkHttpManager.h"
#import "SigFastProvisionAddManager.h"
#import "MeshOTAManager.h"
#import "SigRemoteAddManager.h"
#import "SigBluetooth.h"
#import "SigAddDeviceManager.h"
#import "SigPdu.h"
#import "NSData+Conversion.h"
#import "CBPeripheral+Extensions.h"

#else

// 2.该部分为包含MeshOTA、remote provision代码的公开头文件
/*是否存在MeshOTA功能*/
#define kExistMeshOTA   (YES)
/*是否存在remote provision功能*/
#define kExistRemoteProvision   (YES)
#import <TelinkSigMeshLibExtensions/SigConst.h>
#import <TelinkSigMeshLibExtensions/SigEnumeration.h>
#import <TelinkSigMeshLibExtensions/SigStruct.h>
#import <TelinkSigMeshLibExtensions/SigLogger.h>
#import <TelinkSigMeshLibExtensions/SigModel.h>
#import <TelinkSigMeshLibExtensions/BackgroundTimer.h>
#import <TelinkSigMeshLibExtensions/SigBearer.h>
#import <TelinkSigMeshLibExtensions/SigDataSource.h>
#import <TelinkSigMeshLibExtensions/SDKLibCommand.h>
#import <TelinkSigMeshLibExtensions/SigConfigMessage.h>
#import <TelinkSigMeshLibExtensions/SigMeshMessage.h>
#import <TelinkSigMeshLibExtensions/SigMeshLib.h>
#import <TelinkSigMeshLibExtensions/SigHelper.h>
#import <TelinkSigMeshLibExtensions/SigMessageHandle.h>
#import <TelinkSigMeshLibExtensions/SigProxyConfigurationMessage.h>
#import <TelinkSigMeshLibExtensions/LibTools.h>
#import <TelinkSigMeshLibExtensions/SigGenericMessage.h>
#import <TelinkSigMeshLibExtensions/SigHearbeatMessage.h>
#import <TelinkSigMeshLibExtensions/OTAManager.h>
#import <TelinkSigMeshLibExtensions/SigPublishManager.h>
#import <TelinkSigMeshLibExtensions/TelinkHttpManager.h>
#import <TelinkSigMeshLibExtensions/SigFastProvisionAddManager.h>
#import <TelinkSigMeshLibExtensions/MeshOTAManager.h>
#import <TelinkSigMeshLibExtensions/SigRemoteAddManager.h>
#import <TelinkSigMeshLibExtensions/SigBluetooth.h>
#import <TelinkSigMeshLibExtensions/SigAddDeviceManager.h>
#import <TelinkSigMeshLibExtensions/SigPdu.h>
#import <TelinkSigMeshLibExtensions/SDKLibCommand+subnetBridge.h>
#import <TelinkSigMeshLibExtensions/NSData+Conversion.h>
#import <TelinkSigMeshLibExtensions/CBPeripheral+Extensions.h>

#endif
