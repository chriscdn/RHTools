//
//  CLLocation+rhextensions.m
//
//  Copyright (C) 2015 by Christopher Meyer
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

#import "CLLocation+rhextensions.h"

@implementation CLLocation (rhextensions)

-(id)initWithCoordinates:(CLLocationCoordinate2D)coordinates {
    return [self initWithLatitude:coordinates.latitude longitude:coordinates.longitude];
}

-(void)timeZoneWithBlock:(void (^)(NSTimeZone *timezone))block {
    
    [[[CLGeocoder alloc] init] reverseGeocodeLocation:self completionHandler:^(NSArray *placemarks, NSError *error) {
        
        NSTimeZone *timezone = nil;
        
        if (error == nil && [placemarks count] > 0) {
            
            CLPlacemark *placeMark = [placemarks firstObject];
            NSString *desc = [placeMark description];
            
            NSRegularExpression  *regex  = [NSRegularExpression regularExpressionWithPattern:@"identifier = \"([a-z]*\\/[a-z]*_*[a-z]*)\"" options:NSRegularExpressionCaseInsensitive error:nil];
            NSTextCheckingResult *result = [regex firstMatchInString:desc options:0 range:NSMakeRange(0, [desc length])];
            
            NSString *timezoneString = [desc substringWithRange:[result rangeAtIndex:1]];
            
            timezone = [NSTimeZone timeZoneWithName:timezoneString];

        }
        
        block(timezone);
        
    }];
    
}

@end