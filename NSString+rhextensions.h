//
//  NSString+rhextensions.h
//  Prospecteer
//
//  Created by Christopher Meyer on 5/26/13.
//  Copyright (c) 2013 Red House Consulting GmbH. All rights reserved.
//

@interface NSString (rhextensions)

+(NSString *)UUID;
-(NSString *)firstLetter;
-(BOOL)containsString:(NSString *)substring;
-(NSString *)truncateToLength:(int)charLength;

@end