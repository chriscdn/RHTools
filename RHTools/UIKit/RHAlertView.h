//
//  RHAlertView.h
//  Version: 0.2
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
//

@interface RHAlertView : NSObject

+(RHAlertView * _Nonnull)alertWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message;
+(RHAlertView * _Nonnull)alertWithOKButtonWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message;
-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message;

-(void)addButtonWithTitle:(NSString *)title block:(void (^)(void))block;
-(void)addOKButton;
-(void)addOKButtonWithBlock:(void (^)(void))block;
-(void)addCancelButton;
-(void)addCancelButtonWithTitle:(NSString *)title;
-(void)addCancelButtonWithTitle:(NSString *)title block:(void (^ _Nonnull)(UIAlertAction *action))block;
-(void)show;

@end
