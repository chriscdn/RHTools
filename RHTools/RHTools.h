//
//  RHTools.h
//  Version: 0.3
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

#define IsIPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IsIPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IsIOS61orEarlier (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)

#define kOK NSLocalizedString(@"OK", nil)
#define kCancel NSLocalizedString(@"Cancel", nil)

// RHBoringBlock is just that - no arguments and no return value
typedef void (^RHBoringBlock)();

#import "FrameAccessor.h"
#import "NSArray+rhextensions.h"
#import "NSDictionary+rhextensions.h"
#import "NSString+rhextensions.h"
#import "NSDate+formatter.h"
#import "RHActionSheet.h"
#import "RHAlertView.h"
#import "RHBarButtonItem.h"
#import "RHButton.h"
#import "RHSwitch.h"
#import "UIApplication+rhextensions.h"
#import "RHTapGestureRecognizer.h"
#import "RHTableViewCell.h"
#import "RHTableViewCells.h"
#import "RHTableView.h"
#import "RHKeyboardSlideView.h"
#import "UIView+rhextensions.h"
#import "RHSegmentedControl.h"
#import "UITableView+rhextensions.h"
#import "UIViewController+rhextensions.h"
#import "NSDate+timesince.h"
#import "UIColor+rhextensions.h"
#import "RHTextAreaInputViewController.h"
#import "RHTextField.h"
#import "UIScrollView+rhextensions.h"