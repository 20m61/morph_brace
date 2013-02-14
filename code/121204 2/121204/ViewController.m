//
//  ViewController.m
//  121204
//
//  Created by changhwi on 12/12/04.
//  Copyright (c) 2012年 changhwi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self cameraRun];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - camera

- (void)cameraLoad{
    //カメラセッションのインスタンスを作成
    session = [[AVCaptureSession alloc] init];
    
    // ビデオキャプチャデバイスの取得（ビデオのデータを持ってきてくれるデバイス）
    // このアプリを実行してるiOSデバイスについてるカメラ一覧
    NSArray *devices = [AVCaptureDevice devices];
    for (AVCaptureDevice *device in devices) {
        
        NSLog(@"Device name: %@", [device localizedName]);
        
        if ([device hasMediaType:AVMediaTypeVideo]) {
            if ([device position] == AVCaptureDevicePositionBack) {
                NSLog(@"Device position : back");
                backCamera = device;
            }
        }
    }
    
    // カメラがついていないデバイス向け
    if ([devices count] == 0)
    {
        NSLog(@"カメラがついてない ....");
    }
}

- (void)cameraSelectBack{
    NSError *error = nil;
    AVCaptureDeviceInput *backCameraDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:backCamera error:&error];
    if (error == nil)
    {
        if ([session canAddInput:backCameraDeviceInput])
            [session addInput:backCameraDeviceInput];
        else {
            NSLog(@"Couldn't add front facing video input");
        }
    }
}

- (void)cameraSetting{
    /**
     output deviceを選んで、sessionに登録
     ---------------------------------------------
     */
    
    // output.......
    // -----------------------
    AVCaptureVideoDataOutput *dataOutput = [[AVCaptureVideoDataOutput alloc] init];
    
    // ビデオデータ出力の作成
    //設定を辞書に書き込む
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    [settings setObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA]
                 forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    //設定をアウトプットに読み込む
    dataOutput.videoSettings = settings;
    //メインキュー（デバイスから情報がくるたび＝毎フレーム）の後に毎回setSampleBufferDelegateをする
    [dataOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    
    
    // sessionに in/outわたす.......
    // -----------------------
    // セッションの作成
    //    [session addInput:deviceInput];
    [session addOutput:dataOutput];
    
    // セッションの開始
    [session startRunning];
    
}

- (void)captureOutput:(AVCaptureOutput*)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection*)connection
{
    // イメージバッファの取得
    CVImageBufferRef buffer;
    buffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    
    // イメージバッファのロック
    CVPixelBufferLockBaseAddress(buffer, 0);
    
    // イメージバッファ情報の取得
    uint8_t*    base;
    size_t      width, height, bytesPerRow;
    base = CVPixelBufferGetBaseAddress(buffer);
    width = CVPixelBufferGetWidth(buffer);
    height = CVPixelBufferGetHeight(buffer);
    bytesPerRow = CVPixelBufferGetBytesPerRow(buffer);
    
    // ビットマップコンテキストの作成
    //色
    CGColorSpaceRef colorSpace;
    //サイズなど
    CGContextRef    cgContext;
    colorSpace = CGColorSpaceCreateDeviceRGB();
    cgContext = CGBitmapContextCreate(
                                      base, width, height, 8, bytesPerRow, colorSpace,
                                      kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(colorSpace);
    
    // 画像の作成
    CGImageRef  cgImage;
    UIImage*    image;
    cgImage = CGBitmapContextCreateImage(cgContext);
    image = [UIImage imageWithCGImage:cgImage scale:1.0f
                          orientation:UIImageOrientationRight];
    CGImageRelease(cgImage);
    CGContextRelease(cgContext);
    
    // イメージバッファのアンロック
    CVPixelBufferUnlockBaseAddress(buffer, 0);
    
    // 画像の表示
    self.cameraView.image = image;
}

- (void)cameraRun{
    
    [session stopRunning];
    [self cameraLoad];
    
    
    
    if (buttonCount == 0) {
        buttonCount ++;
    }else{
        buttonCount = 0;
    }
    
    if (buttonCount == 1) {
        [self cameraSelectBack];
        NSLog(@"complete front back setting %d", buttonCount);
    }
    
    [self cameraSetting];
}

- (IBAction)cameraChenge:(id)sender {
    [self cameraRun];
}


@end