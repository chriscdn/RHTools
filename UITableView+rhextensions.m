//
//  UITableView+rhextensions.m
//
//  Copyright (C) 2013 by Christopher Meyer
//  http://schwiiz.org/
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "UITableView+rhextensions.h"

@implementation UITableView (rhextensions)

// http://stackoverflow.com/questions/18822619/ios-7-tableview-like-in-settings-app-on-ipad
-(void)applyiOS7SettingsStyleGrouping:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(tintColor)]) {
		CGFloat cornerRadius = 5.f;
		cell.backgroundColor = UIColor.clearColor;
		CAShapeLayer *layer = [[CAShapeLayer alloc] init];
		CGMutablePathRef pathRef = CGPathCreateMutable();
		CGRect bounds = cell.bounds; // CGRectInset(cell.bounds, 10, 0);
		BOOL addLine = NO;
		if (indexPath.row == 0 && indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
			CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
		} else if (indexPath.row == 0) {
			CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
			CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
			CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
			CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
			addLine = YES;
		} else if (indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
			CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
			CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
			CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
			CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
		} else {
			CGPathAddRect(pathRef, nil, bounds);
			addLine = YES;
		}
		layer.path = pathRef;
		CFRelease(pathRef);
		layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;

		if (addLine == YES) {
			CALayer *lineLayer = [[CALayer alloc] init];
			CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
			lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-10, lineHeight);
			lineLayer.backgroundColor = self.separatorColor.CGColor;
			[layer addSublayer:lineLayer];
		}
		UIView *testView = [[UIView alloc] initWithFrame:bounds];
		[testView.layer insertSublayer:layer atIndex:0];
		testView.backgroundColor = UIColor.clearColor;
		cell.backgroundView = testView;
	}

}

@end