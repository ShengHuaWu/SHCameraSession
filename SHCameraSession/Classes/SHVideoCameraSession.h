//
//  SHVideoCameraSession.h
//  SHCameraSession
//
//  Created by ShengHuaWu on 2014/6/2.
//  Copyright (c) 2014年 shenghuawu. All rights reserved.
//

/**
 *  Initialize the AVCaptureDevice.
 *  Use the AVCaptureVideoDataOutput to record the video.
 */

#import "SHCameraSession.h"

@interface SHVideoCameraSession : SHCameraSession
/**
 *  @brief Remeber to set the SampleBufferDelegate before recording the video.
 */
@property (nonatomic, weak) AVCaptureVideoDataOutput *videoDataOutput;
@end
