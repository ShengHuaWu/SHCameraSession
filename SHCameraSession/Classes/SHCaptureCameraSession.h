//
//  SHCaptureCameraSession.h
//  SHCameraSession
//
//  Created by ShengHuaWu on 2014/6/2.
//  Copyright (c) 2014年 shenghuawu. All rights reserved.
//

/**
 *  Initialize the AVCaptureDevice.
 *  Use the AVCaptureStillImageOutput to capture the camera photo image.
 */

#import "SHCameraSession.h"

@interface SHCaptureCameraSession : SHCameraSession
/**
 *  @bried Use the captureStillImageAsynchronouslyFromConnection: completionHandler: method of the AVCaptureStillImageOutput instance to capture the photo image.
 */
@property (nonatomic, weak) AVCaptureStillImageOutput* stillImageOutput;
@end
