//
//  UIView+rhextensions.m
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

#import "UIView+rhextensions.h"

@implementation UIView (rhextensions)

+(id)viewFromNib {
    return [self viewFromNibNamed:NSStringFromClass(self)];
}

+(id)viewFromNibNamed:(NSString *)nibName {
    return [self viewFromNibNamed:nibName owner:nil];
}

+(id)viewFromNibNamed:(NSString *)nibName owner:(id)owner {
   //  return [[[NSBundle mainBundle] loadNibNamed:nibName owner:owner options:nil] objectAtIndex:0];
    return [self viewFromNibNamed:nibName owner:owner bundle:[NSBundle mainBundle]];
}

+(id)viewFromNibNamed:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle {
    return [[bundle loadNibNamed:nibName owner:owner options:nil] objectAtIndex:0];
}

-(UIView *)findFirstResponder {
    if ([self isFirstResponder]) {
        return self;
    }
    
    for (UIView * subView in self.subviews) {
        UIView *firstResponder = [subView findFirstResponder];
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    
    return nil;
}

-(void)stackSubviewsWithSpace:(CGFloat)space {
    UIView *view = [self.subviews firstObject];
    NSArray *remainingItems = [self.subviews subarrayWithRange:NSMakeRange(1, ([self.subviews count]-1))];
    
    CGFloat y = view.y;
    CGFloat h = view.height;
    
    for (UIView* view in remainingItems) {
        if (!view.hidden) {
            [view setY:h+y+space];
            y = view.y;
            h = view.height;
        }
    }
}

-(void)stackSubviews {
    [self stackSubviewsWithSpace:10];
}

-(UIView *)superViewWithClass:(NSString *)className {
    UIView *view = self;
    
    while (view) {
        if ([view isKindOfClass:NSClassFromString(className)]) {
            return view;
        }
        view = [view superview];
    }
    
    return nil;
}

-(void)sendToBack {
    UIView *superView = [self superview];
    [superView sendSubviewToBack:self];
}

-(void)bringToFront {
    UIView *superView = [self superview];
    [superView bringSubviewToFront:self];
}


-(NSArray *)constaintsForAttribute:(NSLayoutAttribute)attribute {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstAttribute = %d", attribute];
    return [[self constraints] filteredArrayUsingPredicate:predicate];
}

-(NSLayoutConstraint *)constraintForAttribute:(NSLayoutAttribute)attribute {
    return [[self constaintsForAttribute:attribute] firstObject];
}


@end