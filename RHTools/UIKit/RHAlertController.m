//
//  RHAlertController.m
//  Version: 0.1
//
//  Copyright (C) 2016 by Christopher Meyer
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
//

#import "RHAlertController.h"

@interface RHAlertController ()
@property (nonatomic, strong) UIWindow *alertWindow;
@end

@implementation RHAlertController

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.alertWindow.hidden = YES;
    self.alertWindow = nil;
}

-(void)show {
    [self showAnimated:YES];
}

// https://github.com/kirbyt/WPSKit/blob/master/WPSKit/UIKit/WPSAlertController.h
-(void)showAnimated:(BOOL)animated {
    UIViewController *viewController = [UIViewController new];
    // [[blankViewController view] setBackgroundColor:[UIColor clearColor]];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [window setRootViewController:viewController];
    // [window setBackgroundColor:[UIColor clearColor]];
    [window setWindowLevel:UIWindowLevelAlert + 1];
    [window makeKeyAndVisible];
    [self setAlertWindow:window];
    
    [viewController presentViewController:self animated:animated completion:nil];
}

@end