//
//  NSString+rhextensions.m
//  Prospecteer
//
//  Created by Christopher Meyer on 5/26/13.
//  Copyright (c) 2013 Red House Consulting GmbH. All rights reserved.
//

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

@end