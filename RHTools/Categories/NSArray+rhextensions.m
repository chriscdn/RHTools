//
//  NSArray+rhextensions.m
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

#import "NSArray+rhextensions.h"
#import <objc/message.h>

@implementation NSArray (rhextensions)

-(NSArray *)pluck:(NSString *)key {
	NSMutableArray *items = [NSMutableArray array];

	for (id item in self) {
		[items addObject:[item valueForKeyPath:key]];
	}

	return items;
}

-(id)objectAtIndex:(NSUInteger)index defaultValue:(id)defaultValue {
    // if ((0 <= index ) && (index < [self count])) {
    if (index < [self count]) {
        return [self objectAtIndex:index];
    }

    return defaultValue;
}

-(NSArray *)arrayByPerformingSelector:(SEL)selector {
    
    NSMutableArray * results = [NSMutableArray array];
    
    // http://stackoverflow.com/questions/24922913/too-many-arguments-to-function-call-expected-0-have-3
    id (*typed_msgSend)(id, SEL) = (void *)objc_msgSend;
   
    for (id object in self) {
        id result = typed_msgSend(object, selector);
		[results addObject:result];
    }

    return results;
}

-(NSArray *)arrayByRemovingObject:(id)anObject {
	NSMutableArray *mutarray = [NSMutableArray arrayWithArray:self];
	[mutarray removeObject:anObject];
	return mutarray;
}

@end
