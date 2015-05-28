//
//  RHSwitch.m
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

#import "RHSwitch.h"

@interface RHSwitch()
@property (nonatomic, assign) BOOL state;
@end

@implementation RHSwitch
@synthesize state=_state;

-(id)initWithBlock:(RHSwitchBlock)block state:(BOOL)state {
    if (self=[self init]) {
        [self addTarget:self action:@selector(eventValueChanged:) forControlEvents:UIControlEventValueChanged];
		[self setBlock:block];  // copied by @property
		[self setOn:state];
    }
    
    return self;
}

-(id)initWithBlock:(RHSwitchBlock)block {
	return [self initWithBlock:block state:NO];
}

-(void)setOn:(BOOL)on animated:(BOOL)animated {
	[super setOn:on animated:animated];
	[self setState:on];
}

// Rapid tapping of the switch will only call this delegate method for the second tap event (not sure about 3rd or 4th).
// This can cause problems if block() is called and the value hasn't actually changed.
// We get around this by introducing this "state" boolean and only firing the block if the value has changed.
-(void)eventValueChanged:(id)sender {
    if (self.block) {
		if (self.state != self.isOn) {
			self.block( self.isOn );
			[self setState:self.isOn];
		}
	}
}

-(void)dealloc {
	[self removeTarget:self action:@selector(eventValueChanged:) forControlEvents:UIControlEventValueChanged];
}

@end