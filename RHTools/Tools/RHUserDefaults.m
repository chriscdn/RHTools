//
//  RHUserDefaults.h
//
//  Copyright (C) 2016 by Christopher Meyer
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
//

#import "RHUserDefaults.h"
#import <objc/runtime.h>

@interface RHUserDefaults()
@end

@implementation RHUserDefaults

+(instancetype)sharedInstance {
    [NSException raise:@"Call to unimplemented sharedInstance" format:@"%@ does not implement sharedInstance.", NSStringFromClass([self class])];
    return nil;
}

-(id)init {
    if (self=[super init]) {
        [self reload];
    }
    
    return self;
}

-(NSUserDefaults *)userDefaults {
    return [NSUserDefaults standardUserDefaults];
}

-(void)reload {
    [self.propertyNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id value = [self.userDefaults valueForKey:obj];
        if (value == nil) {
            value = [self defaultForKey:obj];
        }
        [self setValue:value forKey:obj];
        [self addObserver:self forKeyPath:obj options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }];
}

-(id)defaultForKey:(NSString *)key {
    NSDictionary *defaultValues = @{};
    return [defaultValues objectForKey:key];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSObject *newValue = [change objectForKey:NSKeyValueChangeNewKey];
    
    if isNilOrNull(newValue) {
        [self.userDefaults removeObjectForKey:keyPath];
    } else {
        [self.userDefaults setObject:newValue forKey:keyPath];
    }
    
    [self.userDefaults synchronize];
}

-(NSArray *)propertyNames {
    NSMutableArray *propertyNames = [NSMutableArray array];
    
    unsigned int count;
    
    objc_property_t* props = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = props[i];
        const char *name = property_getName(property);
        
        NSString *propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        [propertyNames addObject:propertyName];
    }
    
    free(props);
    
    return propertyNames;
}

-(void)reset {
    weakify(self);
    [self.propertyNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        strongify(self);
        [self setValue:[self defaultForKey:obj] forKey:obj];
    }];
}

@end
