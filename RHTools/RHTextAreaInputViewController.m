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

static UIFont *_font = nil;


@interface RHTextAreaInputViewController()
@property (nonatomic, strong) NSString *initialText;
@end


@implementation RHTextAreaInputViewController

+(void)setFont:(UIFont *)font {
    _font = font;
}

+(void)initialize {
    if(self == [RHTextAreaInputViewController class]){
        [self setFont:[UIFont fontWithName:@"AmericanTypewriter" size:[UIFont systemFontSize]+3]];
    }
}

-(void)viewDidLoad {
	[super viewDidLoad];

	// we don't want this in init... since self.view will cause the view to load
	[self.view setBackgroundColor:[UIColor whiteColor]];

	[self setTextView:[[UITextView alloc] initWithFrame:self.view.bounds]];
	[self.textView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    [self.textView setText:self.initialText];
    [self.textView setFont:_font];
	[self.textView setDelegate:self];
	[self.textView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeInteractive];
    [self.textView observeKeyboard];
    
	[self.view addSubview:self.textView];
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

		// CGRect frame = toolbar.frame;
		// frame.size.height = 30;
		// [toolbar setFrame:frame];
        [toolbar setHeight:30.0f];
		[toolbar setItems:toolbarItems];
		[self.textView setInputAccessoryView:toolbar];
	}
}

-(NSMutableArray *)toolbarItems {
	return nil;
}

-(void)hideKeyboard {
	[self.textView resignFirstResponder];
}

#pragma mark TextView Delegate Methods

-(void)textViewDidChange:(UITextView *)textView {
	self.hasChanges = YES;
}

-(void)dealloc {
    [self.textView stopObservingKeyboard];
}

@end


@implementation RHTextAreaInputForNavigationViewController

+(UINavigationController *)controllerWithTitle:(NSString *)title text:(NSString *)text didSaveTextBlock:(RHDidSaveTextBlock)didSaveTextBlock {
	RHTextAreaInputForNavigationViewController *controller = [[RHTextAreaInputForNavigationViewController alloc] init];
    [controller setTitle:title];
    [controller setInitialText:text];
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
		if (bself.didSaveTextBlock) {
			bself.didSaveTextBlock(bself.textView.text);
		}
		[bself dismissViewControllerAnimated:YES completion:nil];
	}];
}

@end