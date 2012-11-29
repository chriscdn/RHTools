//
//  NSDate+formatter.m
//  Version: 0.3
//
//  Copyright (C) 2012 by Christopher Meyer
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

#import "NSDate+formatter.h"

@implementation NSDate (formatter)

#pragma mark -
#pragma mark Class methods
+(NSDateFormatter *)formatter {
    
	static NSDateFormatter *formatter = nil;
	static dispatch_once_t oncePredicate;
	
    dispatch_once(&oncePredicate, ^{
        formatter = [[NSDateFormatter alloc] init];
		[formatter setDateStyle:NSDateFormatterMediumStyle];
		[formatter setTimeStyle:NSDateFormatterShortStyle];
		[formatter setDoesRelativeDateFormatting:YES];
    });
	
    return formatter;
}

+(NSDateFormatter *)formatterWithoutTime {
    
	static NSDateFormatter *formatterWithoutTime = nil;
	static dispatch_once_t oncePredicate;
	
    dispatch_once(&oncePredicate, ^{
		formatterWithoutTime = [[NSDate formatter] copy];
		[formatterWithoutTime setTimeStyle:NSDateFormatterNoStyle];
    });
	
    return formatterWithoutTime;
}

#pragma mark -
#pragma mark Formatter with time
-(NSString *)formatWithUTCTimeZone {
    return [self formatWithTimeZoneOffset:0];
}

-(NSString *)formatWithLocalTimeZone {
    return [self formatWithTimeZone:[NSTimeZone localTimeZone]];
}

-(NSString *)formatWithTimeZoneOffset:(NSTimeInterval)offset {
    return [self formatWithTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:offset]];
}

-(NSString *)formatWithTimeZone:(NSTimeZone *)timezone {
    NSDateFormatter *formatter = [NSDate formatter];
    [formatter setTimeZone:timezone];
    return [formatter stringFromDate:self];
}

#pragma mark -
#pragma mark Formatter without time
-(NSString *)formatWithUTCTimeZoneWithoutTime {
    return [self formatWithTimeZoneOffsetWithoutTime:0];
}

-(NSString *)formatWithLocalTimeZoneWithoutTime {
    return [self formatWithTimeZoneWithoutTime:[NSTimeZone localTimeZone]];
}

-(NSString *)formatWithTimeZoneOffsetWithoutTime:(NSTimeInterval)offset {
    return [self formatWithTimeZoneWithoutTime:[NSTimeZone timeZoneForSecondsFromGMT:offset]];
}

-(NSString *)formatWithTimeZoneWithoutTime:(NSTimeZone *)timezone {
    NSDateFormatter *formatter = [NSDate formatterWithoutTime];
    [formatter setTimeZone:timezone];
    return [formatter stringFromDate:self];
}

@end