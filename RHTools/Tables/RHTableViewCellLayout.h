//
//  RHTableViewCellLayout.h
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
//

@interface RHTableViewCellLayout : NSObject

@property (nonatomic, strong) UIFont *leftLabelFont;
@property (nonatomic, strong) UIColor *leftLabelTextColor;
@property (nonatomic, assign) NSTextAlignment leftLabelTextAlignment;

@property (nonatomic, strong) UIColor *separatorViewColor;

@property (nonatomic, strong) UIFont *largeLabelFont;
@property (nonatomic, strong) UIColor *largeLabelTextColor;
@property (nonatomic, assign) NSTextAlignment largeLabelTextAlignment;

+(RHTableViewCellLayout *)formLayout;

-(void)applyToTableViewCell:(RHTableViewCell *)cell;

@end