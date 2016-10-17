//
//  MSQRCodeReaderViewController.m
//  MSTreasuryManager
//
//  Created by apple on 16/10/15.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSQRCodeReaderViewController.h"

@interface MSQRCodeReaderViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation MSQRCodeReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *scan = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"album"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(openPhotolib)];
    self.navigationItem.rightBarButtonItem = scan;
}

- (void)openPhotolib {
    //打开相册
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        
        UIImagePickerController *pickerC = [[UIImagePickerController alloc] init];
        pickerC.delegate = self;
        
        pickerC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;  //来自相册
        
        [self presentViewController:pickerC animated:YES completion:NULL];
        
    }else{
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"设备不支持访问相册，请在设置->隐私->照片中进行设置！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //1.获取选择的图片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    //2.初始化一个监测器
    CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        //监测到的结果数组  放置识别完之后的数据
        NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
        //判断是否有数据（即是否是二维码）
        if (features.count >=1) {
            /**结果对象 */
            CIQRCodeFeature *feature = [features objectAtIndex:0];
            NSString *scannedResult = feature.messageString;
            
            if ([self.photoReaderDelegate respondsToSelector:@selector(codereader:photoScanResult:)]) {
                [self.photoReaderDelegate codereader:self photoScanResult:scannedResult];
            }
        }
        else{
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该图片没有包含二维码！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            
        }
    }];
}

@end
