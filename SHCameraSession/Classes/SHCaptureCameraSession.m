//
//  SHCaptureCameraSession.m
//  SHCameraSession
//
//  Created by ShengHuaWu on 2014/6/2.
//  Copyright (c) 2014年 shenghuawu. All rights reserved.
//

#import "SHCaptureCameraSession.h"

@implementation SHCaptureCameraSession

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
        // Create the still image output
        AVCaptureStillImageOutput *stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
        NSDictionary *outputSettings = @{AVVideoCodecKey: AVVideoCodecJPEG};
        stillImageOutput.outputSettings = outputSettings;
        [self.session addOutput:stillImageOutput];
        _stillImageOutput = stillImageOutput;
    }
    return self;
}

@end
