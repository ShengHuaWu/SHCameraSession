//
//  MainViewController.m
//  SHCameraSession
//
//  Created by ShengHuaWu on 2014/6/2.
//  Copyright (c) 2014年 shenghuawu. All rights reserved.
//

#import "MainViewController.h"
#import "SHCaptureCameraSession.h"

@interface MainViewController ()
@property (nonatomic, strong) SHCaptureCameraSession *captureCameraSession;
@property (nonatomic, weak) UIView *cameraView;
@end

@implementation MainViewController

#pragma mark - View life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.captureCameraSession = [[SHCaptureCameraSession alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.captureCameraSession.session startRunning];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (!self.cameraView) {
        UIView *cameraView = [self.captureCameraSession cameraViewWithFrame:self.view.bounds];
        [self.view addSubview:cameraView];
        self.cameraView = cameraView;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.captureCameraSession.session stopRunning];
}

@end
