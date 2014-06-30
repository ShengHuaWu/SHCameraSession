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

- (void)adjustCameraStatusAtPoint:(CGPoint)point inRect:(CGRect)rect
{
    // Convert the point to the camera interest point
    // Rotate the point since the app only supports portrait
    CGPoint interestPoint = CGPointMake(point.y / CGRectGetHeight(rect), 1.0 - point.x / CGRectGetWidth(rect));
    // Configure the camera view size
    CGSize previewSize = CGSizeMake(352.0f, 288.0f);
    if ([self.session.sessionPreset isEqualToString:AVCaptureSessionPreset1280x720]) {
        previewSize = CGSizeMake(1280.0f, 720.0f);
    } else if ([self.session.sessionPreset isEqualToString:AVCaptureSessionPreset640x480]) {
        previewSize = CGSizeMake(640.0f, 480.0f);
    }
    // Scale the interest point
    CGFloat scale = (previewSize.width * CGRectGetWidth(rect)) / (previewSize.height * CGRectGetHeight(rect));
    if (scale < 1.0f) {
        interestPoint.y = (interestPoint.y - 0.5f) * scale + 0.5f;
    } else if (scale > 1.0f) {
        interestPoint.x = (interestPoint.x - 0.5f) / scale + 0.5f;
    }
    
    // Adjust camera status with the interest point
    if ([self.device lockForConfiguration:nil]) {
        if ([self.device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
            self.device.focusMode = AVCaptureFocusModeContinuousAutoFocus;
        } else if ([self.device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
            self.device.focusMode = AVCaptureFocusModeAutoFocus;
        }
        if ([self.device isFocusPointOfInterestSupported]) {
            self.device.focusPointOfInterest = interestPoint;
        }
        if ([self.device isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure]) {
            self.device.exposureMode = AVCaptureExposureModeContinuousAutoExposure;
        } else if ([self.device isExposureModeSupported:AVCaptureExposureModeAutoExpose]) {
            self.device.exposureMode = AVCaptureExposureModeAutoExpose;
        }
        if ([self.device isExposurePointOfInterestSupported]) {
            self.device.exposurePointOfInterest = interestPoint;
        }
        if ([self.device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance]) {
            self.device.whiteBalanceMode = AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance;
        } else if ([self.device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
            self.device.whiteBalanceMode = AVCaptureWhiteBalanceModeAutoWhiteBalance;
        }
        [self.device unlockForConfiguration];
    }
}

- (UIImage *)cropCameraImage:(UIImage *)image withRegion:(CGRect)cropRegion inRect:(CGRect)rect
{
    // Mapping the region to the camera frame
    CGAffineTransform t1 = CGAffineTransformIdentity;
    CGAffineTransform t2 = CGAffineTransformIdentity;
    CGFloat scale = 0.0;
    CGFloat offset = 0.0;
    if ([self.session.sessionPreset isEqualToString:AVCaptureSessionPreset1280x720]) {
        // Rotate and scale to adapt with camera frame size
        scale = 720.0 / CGRectGetWidth(rect);
        t1 = CGAffineTransformScale(CGAffineTransformMakeRotation(-M_PI / 2.0), scale, scale);
        // Add offset from the part that camera frame out of screen
        offset = (1280.0 - CGRectGetHeight(rect) * scale) / 2.0;
        t2 = CGAffineTransformMakeTranslation(offset, 720.0);
    } else if ([self.session.sessionPreset isEqualToString:AVCaptureSessionPreset640x480]) {
        scale = 640.0 / CGRectGetHeight(rect);
        t1 = CGAffineTransformScale(CGAffineTransformMakeRotation(-M_PI / 2.0), scale, scale);
        CGFloat offset = 480.0 - (480.0 - CGRectGetWidth(rect) * scale) / 2.0;
        t2 = CGAffineTransformMakeTranslation(0.0, offset);
    } else {
        scale = 352.0 / CGRectGetHeight(rect);
        t1 = CGAffineTransformScale(CGAffineTransformMakeRotation(-M_PI / 2.0), scale, scale);
        offset = 288.0 - (288.0 - CGRectGetWidth(rect) * scale) / 2.0;
        t2 = CGAffineTransformMakeTranslation(0.0, offset);
    }
    CGRect mappingRegion = CGRectApplyAffineTransform(cropRegion, CGAffineTransformConcat(t1, t2));
    
    // Crop and rotate the image
    CGImageRef croppedImage = CGImageCreateWithImageInRect(image.CGImage, mappingRegion);
    UIImage *resultImage = [[UIImage alloc] initWithCGImage:croppedImage scale:1.0 orientation:UIImageOrientationRight];
    CGImageRelease(croppedImage);
    
    return resultImage;
}

@end
