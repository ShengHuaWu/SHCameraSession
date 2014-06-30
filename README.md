# SHCameraSession
Configure the camera of a device by the AVFoundation framework.
Because this class is abstract, please use the concrete subclasses _SHCaptureCameraSession_ and _SHVideoCameraSession_ instead of this class.

## Properties and Methods
You can access the _AVCaptureSession_ directly.

    @property (nonatomic, strong) AVCaptureSession *session;

The concrete subclass should create the device and camera input.

    @property (nonatomic, strong) AVCaptureDevice *device;

Create the capture video preview layer and add it into a view.

    - (UIView *)cameraViewWithFrame:(CGRect)frame;

Adjust the focus, exposure and while balance of the camera at the point that is inside a given rect.

    - (void)adjustCameraStatusAtPoint:(CGPoint)point inRect:(CGRect)rect;

Crop the camera image with a given region that is inside a particular rect.

    - (UIImage *)cropCameraImage:(UIImage *)image withRegion:(CGRect)cropRegion inRect:(CGRect)rect;
