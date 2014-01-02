//
//  UIScrollView+rhextensions.m
//  WS
//
//  Created by Christopher Meyer on 31/12/2013.
//  Copyright (c) 2013 Red House Consulting GmbH. All rights reserved.
//

#import "UIScrollView+rhextensions.h"

@implementation UIScrollView (rhextensions)

-(void)autoContentSize {

	self.showsHorizontalScrollIndicator = NO;
	self.showsVerticalScrollIndicator = NO;

	CGFloat scrollViewHeight = 0.0f;
    CGFloat scrollViewWidth = 0.0f;

	for (UIView* view in self.subviews) {
		if (!view.hidden) {
			CGFloat y = view.frame.origin.y;
			CGFloat h = view.frame.size.height;
			CGFloat x = view.frame.origin.x;
            CGFloat w = view.frame.size.width;

			scrollViewHeight = MAX(scrollViewHeight, h+y);
            scrollViewWidth  = MAX(scrollViewWidth, x+w);
		}
	}

	[self setContentSize:(CGSizeMake(scrollViewWidth, scrollViewHeight+10))];

	self.showsHorizontalScrollIndicator = YES;
	self.showsVerticalScrollIndicator = YES;
}

-(void)scrollToBottomAnimated:(BOOL)animated {
	CGPoint bottomOffset = CGPointMake(0, self.contentSize.height - self.bounds.size.height);
	[self setContentOffset:bottomOffset animated:animated];
}

@end