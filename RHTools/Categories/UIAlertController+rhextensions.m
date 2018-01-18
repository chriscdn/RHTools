//
//  UIAlertController+rhextensions.m
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
//

#import "UIAlertController+rhextensions.h"

@implementation UIAlertController (rhextensions)

+(nonnull instancetype)actionSheetWithTitle:(nullable NSString *)title message:(nullable NSString *)message barButtonItem:(nullable UIBarButtonItem *)barButtonItem {
    UIAlertController *alertController = [self
            alertControllerWithTitle:title
            message:message
            preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController.popoverPresentationController setBarButtonItem:barButtonItem];
    
    return alertController;
}

+(nonnull instancetype)actionSheetWithTitle:(nullable NSString *)title message:(nullable NSString *)message view:(nullable UIView *)view {
    
    return [self actionSheetWithTitle:title message:message view:view rect:view.frame];
    
}

+(nonnull instancetype)actionSheetWithTitle:(nullable NSString *)title message:(nullable NSString *)message view:(nullable UIView *)view rect:(CGRect)rect {
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController.popoverPresentationController setSourceView:view];
    [alertController.popoverPresentationController setSourceRect:rect];
    
    
    return alertController;
}

+(nonnull instancetype)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message {
    return [self
            alertControllerWithTitle:title
            message:message
            preferredStyle:UIAlertControllerStyleAlert];
}

-(void)addButtonWithTitle:(nullable NSString *)title block:(void (^ __nullable)(UIAlertAction * __nonnull action))block {
    [self addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:block]];
}

-(void)addDestructiveButtonWithTitle:(nullable NSString *)title block:(void (^ __nullable)(UIAlertAction * __nonnull action))block {
    [self addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDestructive handler:block]];
}

-(void)addCancelButtonWithTitle:(nullable NSString *)title block:(void (^ __nullable)(UIAlertAction * __nonnull action))block {
    [self addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:block]];
}

-(void)addCancelButtonWithTitle:(nullable NSString *)title {
    [self addCancelButtonWithTitle:title block:nil];
}

-(void)addCancelButton {
    [self addCancelButtonWithTitle:kCancel];
}

-(void)presentInViewController:(nullable UIViewController *)controller {
    [controller presentViewController:self animated:YES completion:nil];
}

@end
