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


// http://stackoverflow.com/questions/25780283/ios-how-to-detect-iphone-6-plus-iphone-6-iphone-5-by-macro

#define IsIPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IsIPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IsIPhone6Plus (IsIPhone && [[UIScreen mainScreen] nativeScale] == 3.0f)

#define async(...) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ __VA_ARGS__ })
#define async_main(...) dispatch_async(dispatch_get_main_queue(), ^{ __VA_ARGS__ })

#define isNillOrNull(item) (!item || [item isEqual:[NSNull null]])

#define LocaleIsMetric ([[[NSLocale currentLocale] objectForKey:NSLocaleUsesMetricSystem] boolValue])

#define kOK NSLocalizedString(@"OK", nil)
#define kCancel NSLocalizedString(@"Cancel", nil)
#define kYes NSLocalizedString(@"Yes", nil)
#define kNo NSLocalizedString(@"No", nil)
#define kOneMoment NSLocalizedString(@"One moment...", nil)


// https://gist.github.com/bsneed/5980089
#define strongify(v) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong __typeof(v) v = v ## _weak_ \
_Pragma("clang diagnostic pop")

#define weakify(v) \
__weak __typeof(v) v ## _weak_ = v \


// RHBoringBlock is just that - no arguments and no return value
typedef void (^RHBoringBlock)();

#import "FrameAccessor.h"

#import "CLLocation+rhextensions.h"
#import "NSArray+rhextensions.h"
#import "NSDate+formatter.h"
#import "NSDate+timesince.h"
#import "NSDateFormatter+rhextensions.h"
#import "NSDictionary+rhextensions.h"
#import "NSString+rhextensions.h"
#import "UIAlertController+rhextensions.h"
#import "UIApplication+rhextensions.h"
#import "UIColor+rhextensions.h"
#import "UIGestureRecognizer+rhextensions.h"
#import "UIImage+rhextensions.h"
#import "UIScrollView+rhextensions.h"
#import "UITableView+rhextensions.h"
#import "UIView+rhextensions.h"
#import "UIViewController+rhextensions.h"
#import "RHTableView.h"
#import "RHTableViewCell.h"
#import "RHTableViewCellLayout.h"
#import "RHTableViewCells.h"
#import "RHUserDefaults.h"
#import "RHAlertView.h"
#import "RHBarButtonItem.h"
#import "RHButton.h"
#import "RHKeyboardScrunchView.h"
#import "RHKeyboardSlideView.h"
#import "RHPopoverController.h"
#import "RHRefreshControl.h"
#import "RHSegmentedControl.h"
#import "RHSwitch.h"
#import "RHTextAreaInputViewController.h"
#import "RHTextField.h"