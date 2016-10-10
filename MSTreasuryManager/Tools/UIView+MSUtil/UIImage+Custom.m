//
//  UIImage+Custom.m
//  TianyaQing
//
//  Created by Liccon Chang on 12-5-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIImage+Custom.h"
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetRepresentation.h>

CGFloat TYDegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat TYRadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};

static void addRoundedRectToPath(CGContextRef context,
                                 CGRect rect,
                                 CGFloat ovalWidth,
                                 CGFloat ovalHeight)
{
    CGFloat fw,fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

@implementation UIImage (scale)

- (UIImage*)scale:(CGFloat)aScale
{
    CGSize size=CGSizeMake(self.size.width*aScale, self.size.height*aScale);
    
    return [self scaleToSize:size];
}

- (UIImage*)scaleToSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    //UIGraphicsBeginImageContextWithOptions(size,NO,1.0);
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

- (UIImage*)scaleToAspectFitSize:(CGSize)size
{
    CGSize imageSize=self.size;
    
    CGFloat imgRatio = imageSize.width / imageSize.height;
    CGFloat btnRatio = size.width / size.height;
    CGFloat scaleFactor = imgRatio > btnRatio ? imageSize.width / size.width : imageSize.height / size.height;
    
    //
    NSInteger width=imageSize.width/scaleFactor;
    NSInteger height=imageSize.height/scaleFactor;
    
    return [self scaleToSize:CGSizeMake(width, height)];
}

- (UIImage*)scaleToAspectSizeWithHeight:(NSInteger)height
{
    CGSize imageSize=self.size;
    CGFloat scaleFactor = imageSize.height / height;
    NSInteger targetWidth=imageSize.width/scaleFactor;
    if (targetWidth>imageSize.width)
    {
        targetWidth=imageSize.width;
    }
    return [self scaleToSize:CGSizeMake(targetWidth, height)];//[self scaleToAspectFitSize:CGSizeMake(targetWidth, height)];
}

- (UIImage*)scaleToAspectSizeWithWidth:(NSInteger)width
{
    CGSize imageSize=self.size;
    CGFloat scaleFactor = imageSize.width / width;
    NSInteger targetHeight=imageSize.height/scaleFactor;
    return [self scaleToSize:CGSizeMake(width, targetHeight)];
}

- (UIImage *)imageCroppedAndScaledToSize:(CGSize)size
                             contentMode:(UIViewContentMode)contentMode
                                padToFit:(BOOL)padToFit
{
    //calculate rect
    CGRect rect = CGRectZero;
    switch (contentMode)
    {
        case UIViewContentModeScaleAspectFit:
        {
            CGFloat aspect = self.size.width / self.size.height;
            if (size.width / aspect <= size.height)
            {
                rect = CGRectMake(0.0f, (size.height - size.width / aspect) / 2.0f, size.width, size.width / aspect);
            }
            else
            {
                rect = CGRectMake((size.width - size.height * aspect) / 2.0f, 0.0f, size.height * aspect, size.height);
            }
            break;
        }
        case UIViewContentModeScaleAspectFill:
        {
            CGFloat aspect = self.size.width / self.size.height;
            if (size.width / aspect >= size.height)
            {
                rect = CGRectMake(0.0f, (size.height - size.width / aspect) / 2.0f, size.width, size.width / aspect);
            }
            else
            {
                rect = CGRectMake((size.width - size.height * aspect) / 2.0f, 0.0f, size.height * aspect, size.height);
            }
            break;
        }
        case UIViewContentModeCenter:
        {
            rect = CGRectMake((size.width - self.size.width) / 2.0f, (size.height - self.size.height) / 2.0f, self.size.width, self.size.height);
            break;
        }
        case UIViewContentModeTop:
        {
            rect = CGRectMake((size.width - self.size.width) / 2.0f, 0.0f, self.size.width, self.size.height);
            break;
        }
        case UIViewContentModeBottom:
        {
            rect = CGRectMake((size.width - self.size.width) / 2.0f, size.height - self.size.height, self.size.width, self.size.height);
            break;
        }
        case UIViewContentModeLeft:
        {
            rect = CGRectMake(0.0f, (size.height - self.size.height) / 2.0f, self.size.width, self.size.height);
            break;
        }
        case UIViewContentModeRight:
        {
            rect = CGRectMake(size.width - self.size.width, (size.height - self.size.height) / 2.0f, self.size.width, self.size.height);
            break;
        }
        case UIViewContentModeTopLeft:
        {
            rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
            break;
        }
        case UIViewContentModeTopRight:
        {
            rect = CGRectMake(size.width - self.size.width, 0.0f, self.size.width, self.size.height);
            break;
        }
        case UIViewContentModeBottomLeft:
        {
            rect = CGRectMake(0.0f, size.height - self.size.height, self.size.width, self.size.height);
            break;
        }
        case UIViewContentModeBottomRight:
        {
            rect = CGRectMake(size.width - self.size.width, size.height - self.size.height, self.size.width, self.size.height);
            break;
        }
        case UIViewContentModeRedraw:
        case UIViewContentModeScaleToFill:
        {
            rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
            break;
        }
    }
    
    if (!padToFit)
    {
        //remove padding
        if (rect.size.width < size.width)
        {
            size.width = rect.size.width;
            rect.origin.x = 0.0f;
        }
        if (rect.size.height < size.height)
        {
            size.height = rect.size.height;
            rect.origin.y = 0.0f;
        }
    }
    
    //avoid redundant drawing
    if (CGSizeEqualToSize(self.size, size))
    {
        return self;
    }
    
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    //draw
    [self drawInRect:rect];
    
    //capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return image
    return image;
}

- (UIImage*)imageRotatedByRadians:(CGFloat)radians
{
    return [self imageRotatedByDegrees:TYRadiansToDegrees(radians)];
}

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees
{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(TYDegreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, TYDegreesToRadians(degrees));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage*)scaledToSizeWithSameAspectRatio:(CGSize)targetSize fitType:(enum FitType)fitType
{
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        switch (fitType)
        {
            case ENormal:
                if (widthFactor > heightFactor)
                {
                    scaleFactor = widthFactor; // scale to fit height
                }
                else
                {
                    scaleFactor = heightFactor; // scale to fit width
                }
                break;
            case EWidth:
                scaleFactor = widthFactor; // scale to fit height
                break;
            case EHeight:
                scaleFactor = heightFactor; // scale to fit width
                break;
        }
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    CGImageRef imageRef = [self CGImage];
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
    if (bitmapInfo == kCGImageAlphaNone)
    {
        bitmapInfo = (CGBitmapInfo)kCGImageAlphaNoneSkipLast;
    }
    CGContextRef bitmap;
    if (self.imageOrientation == UIImageOrientationUp ||self.imageOrientation == UIImageOrientationDown)
    {
        bitmap = CGBitmapContextCreate(NULL, targetWidth, targetHeight,CGImageGetBitsPerComponent(imageRef),CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
    } else
    {
        bitmap = CGBitmapContextCreate(NULL, targetHeight, targetWidth,CGImageGetBitsPerComponent(imageRef),CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
    }
    // In the right or left cases, we need to switch scaledWidth and scaledHeight,
    // and also the thumbnail point
    if (self.imageOrientation == UIImageOrientationLeft)
    {
        thumbnailPoint = CGPointMake(thumbnailPoint.y, thumbnailPoint.x);
        CGFloat oldScaledWidth = scaledWidth;
        scaledWidth = scaledHeight;
        scaledHeight = oldScaledWidth;
        CGContextRotateCTM (bitmap, TYDegreesToRadians(90.0));
        CGContextTranslateCTM (bitmap, 0, -targetHeight);
    }
    else if (self.imageOrientation ==UIImageOrientationRight)
    {
        thumbnailPoint = CGPointMake(thumbnailPoint.y, thumbnailPoint.x);
        CGFloat oldScaledWidth = scaledWidth;
        scaledWidth = scaledHeight;
        scaledHeight = oldScaledWidth;
        CGContextRotateCTM (bitmap, TYDegreesToRadians(-90.0));
        CGContextTranslateCTM (bitmap, -targetWidth, 0);
    }
    else if (self.imageOrientation == UIImageOrientationUp)
    {
        // NOTHING
    }
    else if (self.imageOrientation == UIImageOrientationDown)
    {
        CGContextTranslateCTM (bitmap, targetWidth, targetHeight);
        CGContextRotateCTM (bitmap, TYDegreesToRadians(-180.0));
    }
    
    UIImage* newImage = nil;
    if (bitmap)
    {
        CGContextDrawImage(bitmap, CGRectMake(thumbnailPoint.x,thumbnailPoint.y, scaledWidth, scaledHeight), imageRef);
        CGImageRef ref = CGBitmapContextCreateImage(bitmap);
        newImage = [UIImage imageWithCGImage:ref];
        CGContextRelease(bitmap);
        CGImageRelease(ref);
    }
    else
    {
        newImage = [self getSubImage:CGRectMake(thumbnailPoint.x,thumbnailPoint.y, scaledWidth, scaledHeight)];
    }
    return newImage;
}

+ (UIImage*)roundedImage:(UIImage*)image size:(CGSize)size
{
    // the size of CGContextRef
    NSInteger w = size.width;
    NSInteger h = size.height;
    UIImage *img = image;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, w/2, h/2);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIImage* roundedImage= [UIImage imageWithCGImage:imageMasked];
    CGImageRelease(imageMasked);
    return roundedImage;
}

-(UIImage*)imageWithCornerRadius:(CGFloat)cornerRadius
{
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.size.width, self.size.height)
                                cornerRadius:cornerRadius] addClip];
    // Draw your image
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    // Get the image, here setting the UIImageView image
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage*)roundedBorderImage:(UIImage*)image size:(CGSize)size
{
    NSInteger w = size.width;
    NSInteger h = size.height;
    UIImage *img = image;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(context, 20);
    CGRect rect = CGRectMake(4, 4, w-8, h-8);
    CGContextStrokeRectWithWidth(context, CGRectMake(0, 0, w, h), 20);
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, w/8, h/8);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(4, 4, w-8, h-8), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIImage* roundedImage= [UIImage imageWithCGImage:imageMasked];
    CGImageRelease(imageMasked);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height)
                                cornerRadius:10.0] addClip];
    [roundedImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* tempImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tempImage;
}

/*
 * 等比例缩放图片，并且返回想要尺寸的图片
 */
- (UIImage*)scaleToSizeAndKeepShape:(CGSize)size
{
    CGFloat fScale = 0; //等比例缩放的比例值
    if (size.width/self.size.width > size.height/self.size.height) {
        fScale = size.height/self.size.height;
    } else {
        fScale = size.width/self.size.width;
    }
    UIImage *image = [self scaleToSize:CGSizeMake(self.size.width*fScale, self.size.height*fScale)];
    
    // 将image绘制到新创建的图片缓存中去
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake((size.width-image.size.width)/2, (size.height-image.size.height)/2, image.size.width, image.size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

/*
 * 先等比例缩放图片,同时保持所需宽度,假如高度超高,就裁剪,不够的话，就空缺
 */
- (UIImage*)scaleToSizeAndKeepWidth:(CGSize)size
{
    CGFloat fScaleHeight = self.size.height*(size.width/self.size.width);
    if (fScaleHeight > size.height) { //缩放后高度超高,就要裁剪
        // 先等比缩放
        UIImage* scaleImage = [self scaleToSize:CGSizeMake(size.width, fScaleHeight)];
        // 再裁剪
        CGImageRef sourceImageRef = [scaleImage CGImage];
        CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, CGRectMake(0, (scaleImage.size.height-size.height)/2, size.width, size.height)); //裁剪区域
        UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
        CGImageRelease(newImageRef);
        // 返回裁剪图片
        return newImage;
    } else {                          //高度不够,就空缺一部分填充
        // 并把它设置成为当前正在使用的context
        UIGraphicsBeginImageContext(size);
        // 绘制改变大小的图片
        [self drawInRect:CGRectMake(0, (size.height-fScaleHeight)/2, size.width, fScaleHeight)];
        // 从当前context中创建一个改变大小后的图片
        UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        // 使当前的context出堆栈
        UIGraphicsEndImageContext();
        // 返回新的改变大小后的图片
        return scaledImage;
    }
    return nil;
}

/*
 * 先等比例缩放图片,以最小边缩放,假如高度超高,就裁剪高度,或者宽度过大,就裁剪宽度
 */
- (UIImage*)scaleToSizeAndKeepMinSide:(CGSize)size
{
    if (self.size.width/self.size.height > size.width/size.height) {
        CGFloat fScale = size.height/self.size.height;
        //先不管给定size,等比放大图片
        UIImage* scaleImage = [self scaleToSize:CGSizeMake(self.size.width*fScale, size.height)];
        //再裁剪
        CGImageRef sourceImageRef = [scaleImage CGImage];
        CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, CGRectMake((scaleImage.size.width-size.width)/2, 0, size.width, size.height)); //裁剪区域
        UIImage* newImage = [UIImage imageWithCGImage:newImageRef];
        CGImageRelease(newImageRef);
        // 返回裁剪图片
        return newImage;
    } else {
        CGFloat fScale = size.width/self.size.width;
        //先不管给定size,等比放大图片
        UIImage* scaleImage = [self scaleToSize:CGSizeMake(size.width, self.size.height*fScale)];
        //再裁剪
        CGImageRef sourceImageRef = [scaleImage CGImage];
        CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, CGRectMake(0, (scaleImage.size.height-size.height)/2, size.width, size.height)); //裁剪区域
        UIImage* newImage = [UIImage imageWithCGImage:newImageRef];
        CGImageRelease(newImageRef);
        // 返回裁剪图片
        return newImage;
    }
    
    return nil;
}

/*
 * 裁减大图,将大图裁减成指定区域内的图片
 */
- (UIImage*)getSubImage:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(subImageRef);
    //
    return smallImage;
}

//没有降低图片质量情况下修改图片大小
-(NSData*)dataOfReducedQualityWithDefaultStandards
{
    UIImage* image=[self imageOfReducedQualityWithDefaultStandards];
    
    NSLog(@"%@",NSStringFromCGSize(image.size));
    NSData* data=UIImageJPEGRepresentation(image,0.65);//0.5
    
    NSLog(@"%lu",(unsigned long)[data length]/1024);
    
    return data;
}

-(UIImage*)imageOfReducedQualityWithDefaultStandards
{
    UIImage* image=self;
    
    /*
     NSData* data=UIImageJPEGRepresentation(image,0);
     int lengthK=[data length]/1024;
     if(lengthK>50)
     */
    
    CGSize imageSize=image.size;
    if(imageSize.width>imageSize.height)
    {
        if(imageSize.width>960)
        {
            image=[image scaleToAspectFitSize:CGSizeMake(960, 10000)];
        }
    }
    else
    {
        if(imageSize.width>640)
        {
            image=[image scaleToAspectFitSize:CGSizeMake(640, 10000)];
        }
    }
    
    return image;
}

- (UIImage *)imageOnBgColor:(UIColor *)color cornerRadius:(NSInteger)cornerRadius
{
    CGRect rect = (CGRect){CGPointZero, self.size};
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius] addClip];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    // Draw your image
    [self drawInRect:rect];
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

@implementation UIImage (TextImage)

//+ (UIImage*)imageFromText:(NSString*)text font:(UIFont*)font
//{
//    CGSize size = [text stringSizeWithFont:font];
//    UIGraphicsBeginImageContextWithOptions(size,NO,0.0);
//    
//    [text drawAtPoint:CGPointZero withAttributes:@{NSFontAttributeName: font}];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
//}

+ (UIImage*)imageFromText:(NSString *)text font:(UIFont*)font textColor:(UIColor*)textColor
{
    return [self imageFromText:text font:font textColor:textColor backgroundColor:nil size:CGSizeZero];
}

+ (UIImage*)imageFromText:(NSString *)text font:(UIFont*)font textColor:(UIColor*)textColor backgroundColor:(UIColor*)backgroundColor
{
    return [self imageFromText:text font:font textColor:textColor backgroundColor:backgroundColor size:CGSizeZero];
}

//+ (UIImage*)imageFromText:(NSString *)text font:(UIFont*)font textColor:(UIColor*)textColor backgroundColor:(UIColor*)backgroundColor size:(CGSize)size
//{
//    // set the font type and size
//    CGSize textSize = [text stringSizeWithFont:font];
//    if (CGSizeEqualToSize(size, CGSizeZero))
//    {
//        size = textSize;
//    }
//    
//    UIGraphicsBeginImageContextWithOptions(size,NO,0.0);
//    
//    // optional: add a shadow, to avoid clipping the shadow you should make the context size bigger
//    
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    if (backgroundColor)
//    {
//        CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
//        CGContextSetFillColorWithColor(ctx, [backgroundColor CGColor]);
//        CGContextFillRect(ctx, rect);
//    }
//    
//    //CGContextSetShadowWithColor(ctx, CGSizeMake(1.0, 1.0), 5.0, [[UIColor whiteColor] CGColor]);
//    CGContextSetFillColorWithColor(ctx, [textColor CGColor]);
//    // draw in context, you can use  drawInRect/drawAtPoint:withFont:
//    //[text drawAtPoint:CGPointMake(0.0, 0.0) withFont:font];
//    [text drawAtPoint:CGPointMake((size.width-textSize.width)/2, (size.height-textSize.height)/2) withAttributes:@{NSFontAttributeName: font}];
//    
//    // transfer image
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return image;
//}

+ (UIImage *)imageFromText:(NSString *)text
                      font:(UIFont *)font
                 textColor:(UIColor *)textColor
           backgroundColor:(UIColor *)backgroundColor
                   inImage:(UIImage *)originImg
                   imgSize:(CGSize)imgSize
{
    return [self imageFromText:text font:font textColor:textColor backgroundColor:backgroundColor inImage:originImg imgSize:imgSize textAlignment:0];
}

//+ (UIImage *)imageFromText:(NSString *)text
//                      font:(UIFont *)font
//                 textColor:(UIColor *)textColor
//           backgroundColor:(UIColor *)backgroundColor
//                   inImage:(UIImage *)originImg
//                   imgSize:(CGSize)imgSize
//             textAlignment:(NSInteger)alignment
//{
//    CGSize size = [text respondsToSelector:@selector(sizeWithAttributes:)] ? [text sizeWithAttributes:@{NSFontAttributeName: font}] :
//    [text stringSizeWithFont:font];
//    size = CGSizeMake(ceilf(size.width) + 2, ceilf(size.height) + 2);
//    
//    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 0.0);
//    
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    [originImg drawAtPoint: CGPointZero];
//    
//    CGPoint textOrigin = CGPointMake(imgSize.width - size.width, imgSize.height - size.height);
//    if (alignment == 0)
//    {
//        textOrigin = CGPointMake(imgSize.width - size.width, imgSize.height - size.height);
//    }
//    else
//    {
//        textOrigin = CGPointMake((imgSize.width - size.width)/2, (imgSize.height - size.height)/2);
//    }
//    if (backgroundColor)
//    {
//        CGRect rect = (CGRect){textOrigin, size};
//        CGContextSetFillColorWithColor(ctx, [backgroundColor CGColor]);
//        CGContextFillRect(ctx, rect);
//    }
//    
//    CGContextSetFillColorWithColor(ctx, [textColor CGColor]);
//    [text drawAtPoint:CGPointMake(textOrigin.x + 1, textOrigin.y + 1) withAttributes:@{NSFontAttributeName: font,NSForegroundColorAttributeName:textColor}];
//    
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return image;
//}

+(UIImage*)imageFromColor:(UIColor*)color size:(CGSize)size
{
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width,size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end

@implementation UIImage (FitInSize)

+ (CGSize)fitSize:(CGSize)thisSize inSize:(CGSize)aSize
{
    CGFloat scale;
    CGSize newsize;
    
    if(thisSize.width<aSize.width && thisSize.height < aSize.height)
    {
        newsize = thisSize;
    }
    else
    {
        if(thisSize.width >= thisSize.height)
        {
            scale = aSize.width/thisSize.width;
            newsize.width = aSize.width;
            newsize.height = thisSize.height*scale;
        }
        else
        {
            scale = aSize.height/thisSize.height;
            newsize.height = aSize.height;
            newsize.width = thisSize.width*scale;
        }
    }
    return newsize;
}

+ (UIImage *)image:(UIImage *)image fitInSize:(CGSize)viewsize
{
    // calculate the fitted size
    CGSize size = [UIImage fitSize:image.size inSize:viewsize];
    
    UIGraphicsBeginImageContext(size);
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    [image drawInRect:rect];
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}

@end

@implementation UIImage (UIImagePickerControllerDidFinishPickingMedia)
+ (UIImage*)originalImageFromImagePickerMediaInfo:(NSDictionary*)info
{
    return [UIImage imageFromImagePickerMediaInfo:info imageType:UIImagePickerControllerOriginalImage resultBlock:nil];
}
+ (UIImage*)originalImageFromImagePickerMediaInfo:(NSDictionary*)info resultBlock:(ALAssetsLibraryAssetForURLImageResultBlock)resultBlock
{
    return [UIImage imageFromImagePickerMediaInfo:info imageType:UIImagePickerControllerOriginalImage resultBlock:resultBlock];
}
+ (UIImage*)editedImageFromImagePickerMediaInfo:(NSDictionary*)info
{
    return [UIImage imageFromImagePickerMediaInfo:info imageType:UIImagePickerControllerEditedImage resultBlock:nil];
}
+ (UIImage*)editedImageFromImagePickerMediaInfo:(NSDictionary*)info resultBlock:(ALAssetsLibraryAssetForURLImageResultBlock)resultBlock
{
    return [UIImage imageFromImagePickerMediaInfo:info imageType:UIImagePickerControllerEditedImage resultBlock:resultBlock];
}
+ (UIImage*)imageFromImagePickerMediaInfo:(NSDictionary*)info imageType:(NSString*)imageType resultBlock:(ALAssetsLibraryAssetForURLImageResultBlock)resultBlock
{
    UIImage* image=nil;
    
    NSString* mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if([mediaType isEqualToString:(NSString*)kUTTypeImage])//(NSString*)kUTTypeImage,public.image
    {
        image=[info objectForKey:imageType];
        
        if(!image)
        {
            //ALAssetsLibrary
            NSURL *imageFileURL = [info objectForKey:UIImagePickerControllerReferenceURL];
            ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
            __block UIImage* thumbnail = nil;
            [library assetForURL:imageFileURL resultBlock:^(ALAsset *asset)
             {
                 thumbnail = [UIImage imageWithCGImage:asset.thumbnail];
                 thumbnail=[UIImage adjustImageOrientation:thumbnail];
                 resultBlock(thumbnail);
             }
                    failureBlock:^(NSError *error)
             {
                 NSLog(@"error : %@", error);
                 resultBlock(nil);
                 
             }];
        }
        else
        {
            if([[[UIDevice currentDevice] systemVersion] floatValue]<7.0)
            {
                image=[UIImage adjustImageOrientation:image];
            }
        }
    }
    
    return image;
}

+(UIImage*)adjustImageOrientation:(UIImage*)image
{
    UIImageOrientation imageOrientation=image.imageOrientation;
    if(imageOrientation!=UIImageOrientationUp)
    {
        // 原始图片可以根据照相时的角度来显示，但UIImage无法判定，于是出现获取的图片会逆时针旋转９０度的现象。
        // 以下为调整图片角度的部分
        UIGraphicsBeginImageContext(image.size);
        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        // 调整图片角度完毕
    }
    
    return image;
}
@end
