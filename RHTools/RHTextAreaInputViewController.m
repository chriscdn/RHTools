//
//  RHTextAreaInputViewController.m
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

#import "RHTextAreaInputViewController.h"

@implementation RHTextAreaInputViewController

-(id)init {
    if (self=[super init]) {
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

		[self.view setBackgroundColor:[UIColor whiteColor]];

		[self setTextView:[[UITextView alloc] initWithFrame:self.view.bounds]];
		[self.textView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
		[self.textView setFont:[UIFont fontWithName:@"AmericanTypewriter" size:[UIFont systemFontSize]+3]];
		[self.textView setDelegate:self];

		[self.textView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeInteractive];

		[self.view addSubview:self.textView];
	}

    return self;
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self applyToolbarItems];
	[self textViewDidChange:self.textView];
    [self.textView becomeFirstResponder];
}

-(void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self setHasChanges:NO];
    
}

-(void)applyToolbarItems {
	NSArray *toolbarItems = [self toolbarItems];

	if (toolbarItems) {
		UIToolbar *toolbar = [[UIToolbar alloc] init];
		[toolbar sizeToFit];

		CGRect frame = toolbar.frame;
		frame.size.height = 30;
		[toolbar setFrame:frame];
		[toolbar setItems:toolbarItems];
		[self.textView setInputAccessoryView:toolbar];
	}
}

-(NSMutableArray *)toolbarItems {
	return nil;
}

-(void)keyboardWillShow:(NSNotification *)notification {
	NSDictionary  *userInfo = [notification userInfo];

	NSTimeInterval animationDuration;
	UIViewAnimationCurve animationCurve;
	CGRect keyboardEndFrame;
	[[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
	[[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
	[[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];

	CGRect keyboardFrame = [self.view convertRect:keyboardEndFrame fromView:nil];
	CGFloat textViewWidth = self.view.bounds.size.width;

    /* Animation Block */
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:animationDuration];
	[UIView setAnimationCurve:animationCurve];
	self.textView.frame = CGRectMake(0, 0, textViewWidth, keyboardFrame.origin.y);
	[UIView commitAnimations];
}

-(void)keyboardWillHide:(NSNotification *)notification {
	NSDictionary  *userInfo = [notification userInfo];
	NSTimeInterval animationDuration;
	UIViewAnimationCurve animationCurve;
	CGRect keyboardEndFrame;
	[[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
	[[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
	[[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];

    /* Animation Block */
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:animationDuration];
	[UIView setAnimationCurve:animationCurve];
	self.textView.frame = self.view.bounds;
	[UIView commitAnimations];
}

-(void)hideKeyboard {
	[self.textView resignFirstResponder];
}

#pragma mark TextView Delegate Methods

-(void)textViewDidChangeSelection:(UITextView *)textView {
	// This gets around a bug in iOS7 that doesn't properly scroll.
	[textView scrollRangeToVisible:textView.selectedRange];
}

-(void)textViewDidChange:(UITextView *)textView {
	self.hasChanges = YES;
}

#pragma mark -
#pragma mark Keyboard View

-(void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.textView setDelegate:nil];
}

@end


@implementation RHTextAreaInputForNavigationViewController

+(UINavigationController *)controllerWithTitle:(NSString *)title text:(NSString *)text didSaveTextBlock:(RHDidSaveTextBlock)didSaveTextBlock {
	RHTextAreaInputForNavigationViewController *controller = [[RHTextAreaInputForNavigationViewController alloc] init];
	[controller setTitle:title];
	[controller.textView setText:text];
	[controller setDidSaveTextBlock:didSaveTextBlock];

	return [controller wrapInNavigationController];
}

-(void)viewDidLoad {
	[super viewDidLoad];

	__weak RHTextAreaInputForNavigationViewController *bself = self;

	self.navigationItem.leftBarButtonItem = [RHBarButtonItem itemWithBarButtonSystemItem:UIBarButtonSystemItemCancel block:^{
		[bself dismissViewControllerAnimated:YES completion:nil];
	}];

	self.navigationItem.rightBarButtonItem = [RHBarButtonItem itemWithBarButtonSystemItem:UIBarButtonSystemItemSave block:^{
		if (self.didSaveTextBlock) {
			self.didSaveTextBlock(self.textView.text);
		}
		[bself dismissViewControllerAnimated:YES completion:nil];
	}];
}

@end