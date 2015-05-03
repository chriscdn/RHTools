//
//  RHPopoverController.m
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

#import "RHPopoverController.h"

static RHPopoverController *_sharedInstance;

@implementation RHPopoverController

+(RHPopoverController *)sharedInstance {
    return _sharedInstance;
}

+(RHPopoverController *)popoverWithContentViewController:(UIViewController *)controller {
    RHPopoverController *popover = [[RHPopoverController alloc] initWithContentViewController:controller];
    _sharedInstance = popover;
    return [self sharedInstance];
}

+(RHPopoverController *)popoverWithContentViewController:(UIViewController *)controller presentFromBarButtonItem:(UIBarButtonItem *)barButtonItem permittedArrowDirection:(UIPopoverArrowDirection)arrowDirections {
    RHPopoverController *popover = [self popoverWithContentViewController:controller];
    [popover presentPopoverFromBarButtonItem:barButtonItem permittedArrowDirections:arrowDirections animated:YES];
    
    return popover;
}

+(void)dismiss {
    [[self sharedInstance] dismissPopoverAnimated:YES];
}

@end