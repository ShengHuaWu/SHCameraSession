//
//  SHCameraSession.m
//  SHCameraSession
//
//  Created by ShengHuaWu on 2014/6/2.
//  Copyright (c) 2014年 shenghuawu. All rights reserved.
//

#import "SHCameraSession.h"

@implementation SHCameraSession

#pragma mark - Designated initializer
- (instancetype)init
{
    self = [super init];
    if (self) {
        // Create the capture session
        _session = [[AVCaptureSession alloc] init];
        if ([_session canSetSessionPreset:AVCaptureSessionPreset1280x720]) {
            _session.sessionPreset = AVCaptureSessionPreset1280x720;
        } else if ([_session canSetSessionPreset:AVCaptureSessionPreset640x480]) {
            _session.sessionPreset = AVCaptureSessionPreset640x480;
        } else {
            _session.sessionPreset = AVCaptureSessionPreset352x288;
        }
    }
    return self;
}

#pragma - Public method
- (UIView *)cameraViewWithFrame:(CGRect)frame
{
    // Create the capture video preview
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    previewLayer.frame = frame;
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    // Create the view and add the preview layer into it
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    [view.layer addSublayer:previewLayer];
    
    return view;
}

- (void)adjustCameraStatusAtPoint:(CGPoint)point
{
    if ([self.device lockForConfiguration:nil]) {
        if ([self.device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
            self.device.focusMode = AVCaptureFocusModeContinuousAutoFocus;
        } else if ([self.device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
            self.device.focusMode = AVCaptureFocusModeAutoFocus;
        }
        if ([self.device isFocusPointOfInterestSupported]) {
            self.device.focusPointOfInterest = point;
        }
        if ([self.device isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure]) {
            self.device.exposureMode = AVCaptureExposureModeContinuousAutoExposure;
        } else if ([self.device isExposureModeSupported:AVCaptureExposureModeAutoExpose]) {
            self.device.exposureMode = AVCaptureExposureModeAutoExpose;
        }
        if ([self.device isExposurePointOfInterestSupported]) {
            self.device.exposurePointOfInterest = point;
        }
        if ([self.device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance]) {
            self.device.whiteBalanceMode = AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance;
        } else if ([self.device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
            self.device.whiteBalanceMode = AVCaptureWhiteBalanceModeAutoWhiteBalance;
        }
        [self.device unlockForConfiguration];
    }
}

@end
