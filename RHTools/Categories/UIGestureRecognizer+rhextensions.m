//
//  UIGestureRecognizer+rhextensions.m
//
//  Copyright (C) 2015 by Christopher Meyer
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

#import "UIGestureRecognizer+rhextensions.h"
#import <objc/runtime.h>

@interface UIGestureRecognizer (rhextensionsprivate)
@property (nonatomic, copy) void (^block) (UIGestureRecognizer *gesture);
@end

@implementation UIGestureRecognizer (rhextensions)

static NSString const *key = @"f94993c0-987a-41a6-84ab-c1f94e28dfb8";

-(id)initWithBlock:(RHGestureBlock)block {
    if ((self = [self initWithTarget:self action:@selector(gesturePerformed:)])) {
        [self setBlock:block];
    }
    
    return self;
}

-(void)gesturePerformed:(UIGestureRecognizer *)gesture {
    /*   RHGestureBlock block = [self block];
     if (block) {
     block(gesture);
     }
     */
    if (self.block) {
        self.block(gesture);
    }
    
}

-(RHGestureBlock)block {
    return objc_getAssociatedObject(self, &key);
}

-(void)setBlock:(RHGestureBlock)block {
    objc_setAssociatedObject(self, &key, block, OBJC_ASSOCIATION_COPY);
}

@end