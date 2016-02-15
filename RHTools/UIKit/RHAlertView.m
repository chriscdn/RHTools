//
//  RHAlertView.m
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

#import "RHAlertView.h"
#import "UIAlertController+window.h"

@interface RHAlertView()
@property (nonatomic, strong) UIAlertController *alertController;
@end

@implementation RHAlertView

+(RHAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message {
	return [[self alloc] initWithTitle:title message:message];
}

+(RHAlertView *)alertWithOKButtonWithTitle:(NSString *)title message:(NSString *)message {
	RHAlertView *alert = [self alertWithTitle:title message:message];
	[alert addOKButton];
	return alert;
}

-(id)init {
	if (self=[super init]) {
        self.alertController = [UIAlertController alertWithTitle:nil message:nil];
	}
	return self;
}

-(id)initWithTitle:(NSString *)title message:(NSString *)message {
	if (self=[self init]) {
        [self.alertController setTitle:title];
        [self.alertController setMessage:message];
	}
	return self;
}

-(void)addButtonWithTitle:(NSString *)title block:(void (^)())block {
    [self.alertController addButtonWithTitle:title block:^(UIAlertAction * _Nonnull action) {
        if (block) {
            block();
        }
    }];
}

-(void)addOKButton {
	return [self addOKButtonWithBlock:nil];
}

-(void)addOKButtonWithBlock:(void (^)())block {
	return [self addButtonWithTitle:kOK block:block];
}

-(void)addCancelButton {
	return [self addCancelButtonWithTitle:kCancel];
}

-(void)addCancelButtonWithTitle:(NSString *)title {
    [self.alertController addCancelButtonWithTitle:title];
}

-(void)addCancelButtonWithTitle:(NSString *)title block:(void (^)())block {
    [self.alertController addCancelButtonWithTitle:title block:block];
}

-(void)show {
    [self.alertController show];
}

@end