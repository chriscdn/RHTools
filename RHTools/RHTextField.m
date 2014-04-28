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

/**
 * This odd implementation is required since setting the UITextField delegate to itself causes an infinite loop.
 * This is well documented in various blogs and forums online.
 */

@interface RHTextFieldBlockDelegate : NSObject<UITextFieldDelegate>

@property (nonatomic, copy) BOOL(^shouldBeginEditingBlock)(RHTextField *textField);
@property (nonatomic, copy) void(^didBeginEditingBlock)(RHTextField *textField);
@property (nonatomic, copy) BOOL(^shouldEndEditingBlock)(RHTextField *textField);
@property (nonatomic, copy) void(^didEndEditingBlock)(RHTextField *textField);
@property (nonatomic, copy) BOOL(^shouldReturnBlock)(RHTextField *textField);

@end

@implementation RHTextFieldBlockDelegate

-(BOOL)textFieldShouldBeginEditing:(RHTextField *)textField {
	if (self.shouldBeginEditingBlock) {
		return self.shouldBeginEditingBlock(textField);
	}
	return YES;
}

-(void)textFieldDidBeginEditing:(RHTextField *)textField {
	if (self.didBeginEditingBlock) {
		self.didBeginEditingBlock(textField);
	}
}

-(BOOL)textFieldShouldEndEditing:(RHTextField *)textField {
	if (self.shouldEndEditingBlock) {
		return self.shouldEndEditingBlock(textField);
	}
	return YES;
}

-(void)textFieldDidEndEditing:(RHTextField *)textField {
	if (self.didEndEditingBlock) {
		self.didEndEditingBlock(textField);
	}
}

-(BOOL)textFieldShouldReturn:(RHTextField *)textField {
	if (self.shouldReturnBlock) {
		return self.shouldReturnBlock(textField);
	}
	return YES;
}

@end


@interface RHTextField()
@property (nonatomic, strong) RHTextFieldBlockDelegate* powerDelegate;
@end

@implementation RHTextField

-(id)initWithFrame:(CGRect)frame {
	if (self=[super initWithFrame:frame]) {
		self.powerDelegate = [RHTextFieldBlockDelegate new];
		self.delegate = self.powerDelegate;
	}

	return self;
}

-(void)setShouldBeginEditingBlock:(BOOL (^)(RHTextField *))shouldBeginEditingBlock {
	[self.powerDelegate setShouldBeginEditingBlock:shouldBeginEditingBlock ];
}

-(void)setDidBeginEditingBlock:(void (^)(RHTextField *))didBeginEditingBlock {
	[self.powerDelegate setDidBeginEditingBlock:didBeginEditingBlock];
}

-(void)setShouldEndEditingBlock:(BOOL (^)(RHTextField *))shouldEndEditingBlock {
	[self.powerDelegate setShouldEndEditingBlock:shouldEndEditingBlock];
}

-(void)setDidEndEditingBlock:(void (^)(RHTextField *))didEndEditingBlock {
	[self.powerDelegate setDidEndEditingBlock:didEndEditingBlock];
}

-(void)setShouldReturnBlock:(BOOL (^)(RHTextField *))shouldReturnBlock {
	[self.powerDelegate setShouldReturnBlock:shouldReturnBlock];
}

@end