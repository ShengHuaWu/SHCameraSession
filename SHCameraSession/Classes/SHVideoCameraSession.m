//
//  SHVideoCameraSession.m
//  SHCameraSession
//
//  Created by ShengHuaWu on 2014/6/2.
//  Copyright (c) 2014年 shenghuawu. All rights reserved.
//

#import "SHVideoCameraSession.h"

@implementation SHVideoCameraSession

#pragma mark - Designated initializer
- (instancetype)init
{
    self = [super init];
    if (self) {
        // Create the deviece with the back camera
        for (AVCaptureDevice *device in [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo]) {
            if ([device position] == AVCaptureDevicePositionBack) {
                self.device = device;
                break;
            }
        }
        // Create the capture device input
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
        [self.session addInput:input];
        // Create the video data output
        AVCaptureVideoDataOutput *videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
        videoDataOutput.alwaysDiscardsLateVideoFrames = YES;
        videoDataOutput.videoSettings = @{(__bridge_transfer NSString *)kCVPixelBufferPixelFormatTypeKey: @(kCVPixelFormatType_32BGRA)};
        [self.session addOutput:videoDataOutput];
        _videoDataOutput = videoDataOutput;
    }
    return self;
}

@end
