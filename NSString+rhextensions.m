//
//  NSString+rhextensions.m
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

#define kEllipsis @"…"

#import "NSString+rhextensions.h"

@implementation NSString (rhextensions)

+(NSString *)UUID {
	// Returns a UUID
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidStr = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuid);
    CFRelease(uuid);

    return [uuidStr lowercaseString];
}

-(NSString *)firstLetter {
    if (!self.length || self.length == 1) {
        return self;
	}
	
    return [self substringToIndex:1];
}

-(BOOL)containsString:(NSString *)substring {
    NSRange range = [self rangeOfString : substring];
    BOOL found = ( range.location != NSNotFound );
    return found;
}

-(NSString *)truncateToLength:(int)charLength {
	if ( self.length > charLength ) {
		NSRange range = {0, charLength-kEllipsis.length};
		return [[self substringWithRange:range] stringByAppendingFormat:kEllipsis];
	} else {
		return self;
	}
}

-(NSString *)trim {
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(NSNumber *)toNumber {
	return [NSNumber numberWithInt:self.intValue];
}

@end