//
//  UIImage+rhextensions.h
//  TrackMyTour
//
//  Created by Christopher Meyer on 5/9/09.
//  Copyright 2012 Red House Consulting GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (rhextensions)

-(UIImage *)scaleImageWithMaxWidth:(float) maxWidth maxHeight:(float)maxHeight scaleForDevice:(BOOL)scaleForDevice ;
-(UIImage *)fillImageInBoxWithMaxWidth:(float)maxWidth maxHeight:(float)maxHeight scaleForDevice:(BOOL)scaleForDevice ;
-(UIImage *)imageByScalingAndCroppingWithMaxWidth:(float)maxWidth maxHeight:(float)maxHeight scaleForDevice:(BOOL)scaleForDevice ;

@end