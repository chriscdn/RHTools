//
//  RHTextField+rhextensions.m
//  Version: 0.1
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

#import "RHTextField.h"

@implementation RHTextField

-(id)initWithFrame:(CGRect)frame {
	if (self=[super initWithFrame:frame]) {
		self.delegate = self;

		// Seems to be a bug in iOS that can cause some infinite loops unless this is set.
		// I believe it's related to using self as the delegate.  Tip taken from:
		// http://stackoverflow.com/questions/10292568/iphone-simulator-crash-with-exc-bad-access-when-uitextfield-delegator-is-calle
		[self setAutocorrectionType:UITextAutocorrectionTypeNo];
	}

	return self;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	if (self.shouldBeginEditingBlock) {
		return self.shouldBeginEditingBlock(self);
	}
	return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
	if (self.didBeginEditingBlock) {
		self.didBeginEditingBlock(self);
	}
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
	if (self.shouldEndEditingBlock) {
		return self.shouldEndEditingBlock(self);
	}
	return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
	if (self.didEndEditingBlock) {
		self.didEndEditingBlock(self);
	}
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (self.shouldReturnBlock) {
		return self.shouldReturnBlock(self);
	}
	return YES;
}

@end