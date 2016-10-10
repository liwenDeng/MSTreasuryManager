//
//  UIImage+Custom.h
//  TianyaQing
//
//  Created by Liccon Chang on 12-5-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^ALAssetsLibraryAssetForURLImageResultBlock)(UIImage* image);

enum FitType
{
    ENormal = 0,//自计算
    EWidth = 1,//以宽为准
    EHeight = 2//以高为准
};

@interface UIImage (scale)
- (UIImage*)scale:(CGFloat)aScale;
- (UIImage*)scaleToSize:(CGSize)size;
- (UIImage*)scaleToAspectFitSize:(CGSize)size;
- (UIImage*)scaleToAspectSizeWithHeight:(NSInteger)height;
- (UIImage*)scaleToAspectSizeWithWidth:(NSInteger)width;
- (UIImage*)getSubImage:(CGRect)rect;
- (UIImage*)imageRotatedByRadians:(CGFloat)radians;
- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees;
- (UIImage*)scaledToSizeWithSameAspectRatio:(CGSize)targetSize fitType:(enum FitType)fitType;
+ (UIImage*)roundedImage:(UIImage*)image size:(CGSize)size;
+ (UIImage*)roundedBorderImage:(UIImage*)image size:(CGSize)size;
-(UIImage*)imageWithCornerRadius:(CGFloat)cornerRadius;
- (UIImage*)scaleToSizeAndKeepShape:(CGSize)size;
- (UIImage*)scaleToSizeAndKeepWidth:(CGSize)size;
- (UIImage*)scaleToSizeAndKeepMinSide:(CGSize)size;
- (NSData*)dataOfReducedQualityWithDefaultStandards;//按默认标准降低了质量的图片的数据
- (UIImage *)imageCroppedAndScaledToSize:(CGSize)size
                             contentMode:(UIViewContentMode)contentMode
                                padToFit:(BOOL)padToFit;
- (UIImage *)imageOnBgColor:(UIColor *)color cornerRadius:(NSInteger)cornerRadius;

@end

@interface UIImage (TextImage)
+ (UIImage*)imageFromText:(NSString*)text font:(UIFont*)font;
+ (UIImage*)imageFromText:(NSString *)text font:(UIFont*)font textColor:(UIColor*)textColor;
+ (UIImage*)imageFromText:(NSString *)text font:(UIFont*)font textColor:(UIColor*)textColor backgroundColor:(UIColor*)backgroundColor;
+ (UIImage*)imageFromText:(NSString *)text font:(UIFont*)font textColor:(UIColor*)textColor backgroundColor:(UIColor*)backgroundColor size:(CGSize)size;
+ (UIImage*)imageFromColor:(UIColor*)color size:(CGSize)size;

+ (UIImage *)imageFromText:(NSString *)text
                      font:(UIFont *)font
                 textColor:(UIColor *)textColor
           backgroundColor:(UIColor *)backgroundColor
                   inImage:(UIImage *)originImg
                   imgSize:(CGSize)imgSize;

+ (UIImage *)imageFromText:(NSString *)text
                      font:(UIFont *)font
                 textColor:(UIColor *)textColor
           backgroundColor:(UIColor *)backgroundColor
                   inImage:(UIImage *)originImg
                   imgSize:(CGSize)imgSize
             textAlignment:(NSInteger)alignment;

@end

@interface UIImage (FitInSize)
+ (CGSize)fitSize:(CGSize)thisSize inSize:(CGSize) aSize;
+ (UIImage *)image:(UIImage *)image fitInSize: (CGSize)viewsize;
@end

@interface UIImage (UIImagePickerControllerDidFinishPickingMedia)
+ (UIImage*)originalImageFromImagePickerMediaInfo:(NSDictionary*)info;
+ (UIImage*)originalImageFromImagePickerMediaInfo:(NSDictionary*)info resultBlock:(ALAssetsLibraryAssetForURLImageResultBlock)resultBlock;
+ (UIImage*)editedImageFromImagePickerMediaInfo:(NSDictionary*)info;
+ (UIImage*)editedImageFromImagePickerMediaInfo:(NSDictionary*)info resultBlock:(ALAssetsLibraryAssetForURLImageResultBlock)resultBlock;
@end
