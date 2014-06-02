//
//  SHCameraSession.h
//  SHCameraSession
//
//  Created by ShengHuaWu on 2014/6/2.
//  Copyright (c) 2014年 shenghuawu. All rights reserved.
//

/**
 *  Configure the camera of a device by the AVFoundation framework.
 *  This class is abstract. Please use the concrete subclasses instead of this class.
 */

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface SHCameraSession : NSObject
@property (nonatomic, strong) AVCaptureSession *session;

/**
 *  @brief The concrete subclass should create the device and camera input.
 */
@property (nonatomic, strong) AVCaptureDevice *device;

/**
 *  @brief Create the capture video preview layer and add it into a view.
 *
 *  @param frame The frame of the preview layer and view
 *
 *  @return The view that contains the capture video preview layer
 */
- (UIView *)cameraViewWithFrame:(CGRect)frame;

/**
 *  @brief Adjust the focus, exposure and while balance of the camera at the point.
 *
 *  @param point The point of interest for foucs, exposure and while balance.
 */
- (void)adjustCameraStatusAtPoint:(CGPoint)point;
@end
