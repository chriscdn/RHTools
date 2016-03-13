//
//  UIImage+rhextensions.m
//  TrackMyTour
//
//  Created by Christopher Meyer on 5/9/09.
//  Copyright 2012 Red House Consulting GmbH. All rights reserved.
//

#import "UIImage+rhextensions.h"

@implementation UIImage (rhextensions)

-(CGFloat)aspectRatio {
    CGFloat actualHeight = self.size.height;
    CGFloat actualWidth = self.size.width;
    
    // prevent a divide by zero
    actualHeight = MAX(1, actualHeight);
    
    return actualWidth/actualHeight;
}

-(BOOL)isLandscape {
    return (self.aspectRatio >= 1);
}

-(BOOL)isPortrait {
    return !self.isLandscape;
}

-(UIImage *)scaleImageWithMaxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight scaleForDevice:(BOOL)scaleForDevice {
	
	CGFloat actualHeight = self.size.height;
	CGFloat actualWidth = self.size.width;

	CGFloat imgRatio = actualWidth / actualHeight;
	CGFloat maxRatio = maxWidth / maxHeight;

	if(imgRatio < maxRatio) {
		imgRatio = maxHeight / actualHeight;
		actualWidth = imgRatio * actualWidth;
		actualHeight = maxHeight;		
	} else {
		imgRatio = maxWidth / actualWidth;
		actualHeight = imgRatio * actualHeight;     
		actualWidth = maxWidth;
	}

	return [self fillImageInBoxWithMaxWidth:actualWidth maxHeight:actualHeight scaleForDevice:scaleForDevice];
}

-(UIImage *)fillImageInBoxWithMaxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight scaleForDevice:(BOOL)scaleForDevice {
	CGRect rect = CGRectMake(0.0, 0.0, maxWidth, maxHeight);
    
    // 0 means use the device scaling
    CGFloat scale = scaleForDevice ? 0 : 1;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, scale);
    
    [self drawInRect:rect];  // scales image to rect
	UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return theImage;	
}

-(UIImage *)imageByScalingAndCroppingWithMaxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight scaleForDevice:(BOOL)scaleForDevice {
	CGSize targetSize = CGSizeMake(maxWidth, maxHeight);
	
	UIImage *sourceImage = self;
	UIImage *newImage = nil;        
	CGSize imageSize = sourceImage.size;
	CGFloat width = imageSize.width;
	CGFloat height = imageSize.height;
	CGFloat targetWidth = targetSize.width;
	CGFloat targetHeight = targetSize.height;
	CGFloat scaleFactor = 0.0;
	CGFloat scaledWidth = targetWidth;
	CGFloat scaledHeight = targetHeight;
	CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
	
	if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
		
        if (widthFactor > heightFactor) {
			scaleFactor = widthFactor; // scale to fit height
        } else {
			scaleFactor = heightFactor; // scale to fit width
        }
		
		scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
		
        // center the image
        if (widthFactor > heightFactor) {
			thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5; 
		} else if (widthFactor < heightFactor) {
			thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
		}
	}       
	
    CGFloat scale = scaleForDevice ? 0 : 1;
    UIGraphicsBeginImageContextWithOptions(targetSize, NO, scale);
	
	CGRect thumbnailRect = CGRectZero;
	thumbnailRect.origin = thumbnailPoint;
	thumbnailRect.size.width  = scaledWidth;
	thumbnailRect.size.height = scaledHeight;
	
	[sourceImage drawInRect:thumbnailRect];
	
	newImage = UIGraphicsGetImageFromCurrentImageContext();
	
	if(newImage == nil) {
        NSLog(@"could not scale image");
	}
	
	//pop the context to get back to the default
	UIGraphicsEndImageContext();
	
	return newImage;
}

@end