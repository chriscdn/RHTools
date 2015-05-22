//
//  UIScrollView+rhextensions.m
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

-(void)observeKeyboard {
    // UIKeyboardWillChangeFrameNotification doesn't seem to really know the end frame of the keyboard in iOS8.  We therefore follow-up with
    // UIKeyboardDidChangeFrameNotification to make sure our bases our covered.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
}

-(void)stopObservingKeyboard {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
}

-(void)keyboardDidChangeFrame:(NSNotification *)notification {
    // We never know what the original bottom inset is...  We save it here for later.
    // if (self.bottomInsetWithoutKeyboard == 0) {
    //     [self setBottomInsetWithoutKeyboard:self.contentInset.bottom];
    // }
    
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardEndFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // This is the relative position of the keyboard within our tableView
    CGRect keyboardFrame = [self convertRect:keyboardEndFrame fromView:nil];
    CGFloat viewHeight = keyboardFrame.origin.y;
    CGFloat adjustedViewHeight = viewHeight - self.contentOffsetY;
    
    // NOTE: self.contentOffsetY is the same as self.bounds.size.
    
    UIEdgeInsets newInset = self.contentInset;
    newInset.bottom = MAX(self.height - adjustedViewHeight, 0);
    
    //    self.contentInset = newInset;
    //   self.scrollIndicatorInsets = newInset;
    
    
    NSTimeInterval animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions animationCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:animationCurve
                     animations:^{
                         self.contentInset = newInset;
                         self.scrollIndicatorInsets = newInset;
                     }
                     completion:nil];
}

@end