//
//  UIImage+rhextensions.m
//  TrackMyTour
//
//  Created by Christopher Meyer on 5/9/09.
//  Copyright 2012 Red House Consulting GmbH. All rights reserved.
//

#import "UIImage+rhextensions.h"

@implementation UIImage (rhextensions)

-(UIImage *)scaleImageWithMaxWidth:(float)maxWidth maxHeight:(float)maxHeight {
	
	float actualHeight = self.size.height;
	float actualWidth = self.size.width;

	float imgRatio = actualWidth / actualHeight;
	float maxRatio = maxWidth / maxHeight;

	if(imgRatio < maxRatio) {
		imgRatio = maxHeight / actualHeight;
		actualWidth = imgRatio * actualWidth;
		actualHeight = maxHeight;		
	} else {
		imgRatio = maxWidth / actualWidth;
		actualHeight = imgRatio * actualHeight;     
		actualWidth = maxWidth;
	}

	return [self fillImageInBoxWithMaxWidth:actualWidth maxHeight:actualHeight];
}

-(UIImage *)fillImageInBoxWithMaxWidth:(float)maxWidth maxHeight:(float)maxHeight {
	CGRect rect = CGRectMake(0.0, 0.0, maxWidth, maxHeight);
	UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
	[self drawInRect:rect];  // scales image to rect
	UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return theImage;	
}

-(UIImage *)imageByScalingAndCroppingWithMaxWidth:(float)maxWidth maxHeight:(float)maxHeight {
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
	
	UIGraphicsBeginImageContextWithOptions(targetSize, NO, 0); // this will crop
	
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