//
//  RHKeyboardSlideView.h
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

#import "RHKeyboardSlideView.h"

@interface RHKeyboardSlideView()
@property (nonatomic, assign) CGRect keyboardFrame;
@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, assign) UIViewAnimationOptions animationCurve;

-(void)setupNotfications;

@end

@implementation RHKeyboardSlideView


-(id)init {
	if (self = [super init]) {
		[self setupNotfications];
	}

	return self;
}


-(id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		[self setupNotfications];
	}

	return self;
}

-(void)setupNotfications {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidBeginEditingNotification object:nil];
}

-(void)keyboardWillShow:(NSNotification *)_notification {

	NSDictionary  *userInfo = [_notification userInfo];

	NSTimeInterval animationDuration;
	UIViewAnimationOptions animationCurve;
	CGRect keyboardEndFrame;
	[[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
	[[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
	[[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];

	self.keyboardFrame = [self convertRect:keyboardEndFrame fromView:nil];
	self.animationCurve = animationCurve;
	self.animationDuration = animationDuration;

	[UIView animateWithDuration:animationDuration delay:0 options:animationCurve animations:^{
		[self scrollToMakeVisible:[self findFirstResponder]];
	} completion:nil];

}

-(void)keyboardWillHide:(NSNotification *)_notification {

	NSDictionary  *userInfo = [_notification userInfo];

	NSTimeInterval animationDuration;
	UIViewAnimationOptions animationCurve;
	CGRect keyboardEndFrame;
	[[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
	[[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
	[[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];

	self.keyboardFrame = CGRectNull;

    /* Animation Block */
	[UIView animateWithDuration:animationDuration delay:0 options:animationCurve animations:^{
		self.y = 0;
	} completion:nil];

}

-(void)scrollToMakeVisible:(UIView *)view {

	CGRect frFrame = [self convertRect:view.frame fromView:view.superview];
	CGRect keyboardFrame = self.keyboardFrame;

	CGFloat screenHeight   = self.height;
	CGFloat keyboardHeight = keyboardFrame.size.height;

	self.y = (screenHeight-keyboardHeight-view.height)/2 - frFrame.origin.y;
	
}

-(void)textFieldChanged:(NSNotification *)_notification {
	if ( !CGRectIsNull(self.keyboardFrame) ) {
		[UIView animateWithDuration:self.animationDuration delay:0 options:self.animationCurve animations:^{
			[self scrollToMakeVisible:[_notification object]];
		} completion:nil];
	}
}

-(void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end