//
//  UIImage+rhextensions.h
//  TrackMyTour
//
//  Created by Christopher Meyer on 5/9/09.
//  Copyright 2012 Red House Consulting GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (rhextensions)

-(CGFloat)aspectRatio;
-(BOOL)isLandscape;
-(BOOL)isPortrait;

-(UIImage *)scaleImageWithMaxWidth:(CGFloat) maxWidth maxHeight:(CGFloat)maxHeight scaleForDevice:(BOOL)scaleForDevice ;
-(UIImage *)fillImageInBoxWithMaxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight scaleForDevice:(BOOL)scaleForDevice ;
-(UIImage *)imageByScalingAndCroppingWithMaxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight scaleForDevice:(BOOL)scaleForDevice ;

@end