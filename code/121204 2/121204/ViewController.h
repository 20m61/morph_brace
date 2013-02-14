//
//  ViewController.h
//  121204
//
//  Created by changhwi on 12/12/04.
//  Copyright (c) 2012年 changhwi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

int buttonCount;

AVCaptureDevice *backCamera;

NSArray *devices;
NSString *cameraDevice;


@interface ViewController : UIViewController <AVCaptureVideoDataOutputSampleBufferDelegate, UITextFieldDelegate>
{
    AVCaptureSession *session;
    UIView *myView;
}
@property (strong, nonatomic) IBOutlet UIImageView *cameraView;

- (void)captureOutput:(AVCaptureOutput*)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection*)connection;

@end
