//
//  SHCameraSession.h
//  SHCameraSession
//
//  Created by ShengHuaWu on 2014/6/2.
//  Copyright (c) 2014年 shenghuawu. All rights reserved.
//

/**
 *  Configure the camera of a device by the AVFoundation framework.
 *  Because this class is abstract, please use the concrete subclasses instead of this class.
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
 *  @brief Adjust the focus, exposure and while balance of the camera at the point that is inside a given rect.
 *
 *  @param point The point that is inside a rect. This point might be the touch point.
 *  @param rect  The rect might be the bounds of the touch view.
 */
- (void)adjustCameraStatusAtPoint:(CGPoint)point inRect:(CGRect)rect;

/**
 *  @brief Crop the camera image with a given region that is inside a particular rect
 *
 *  @param image      The image from the device camera
 *  @param cropRegion The crop region that is inside a given rect
 *  @param rect       The rect that the crop region is in
 *
 *  @return The crop image
 */
- (UIImage *)cropCameraImage:(UIImage *)image withRegion:(CGRect)cropRegion inRect:(CGRect)rect;
@end
