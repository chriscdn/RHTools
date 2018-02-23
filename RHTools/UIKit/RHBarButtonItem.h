//
//  RHBarButtonItem.h
//  Version: 0.3
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



@interface RHBarButtonItem : UIBarButtonItem

typedef void (^RHBarButtonItemBlock)(RHBarButtonItem *barButtonItem);

@property (nonatomic, copy) RHBarButtonItemBlock block;

+(instancetype)itemWithTitle:(NSString *)title block:(RHBarButtonItemBlock)block;
+(instancetype)itemWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem block:(RHBarButtonItemBlock)block;
+(instancetype)itemWithImage:(UIImage *)image block:(RHBarButtonItemBlock)block;
+(instancetype)itemWithCustomView:(UIView *)customView block:(RHBarButtonItemBlock)block;
+(instancetype)flexibleSpace;

-(instancetype)initWithTitle:(NSString *)title block:(RHBarButtonItemBlock)block;
-(instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem block:(RHBarButtonItemBlock)block;
-(instancetype)initWithImage:(UIImage *)image block:(RHBarButtonItemBlock)block;
-(instancetype)initWithCustomView:(UIView *)customView block:(RHBarButtonItemBlock)block;

@end
