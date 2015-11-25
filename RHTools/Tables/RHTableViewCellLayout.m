//
//  RHTableViewCellLayout.m
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

#import "RHTableViewCellLayout.h"

@implementation RHTableViewCellLayout

+(RHTableViewCellLayout *)formLayout {
    RHTableViewCellLayout *layout = [RHTableViewCellLayout new];
    layout.leftLabelFont = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    layout.leftLabelTextAlignment = NSTextAlignmentRight;
    layout.leftLabelTextColor = [UIColor grayColor];
    layout.separatorViewColor = [UIColor groupTableViewBackgroundColor];
    return layout;
}

-(id)init {
    if (self=[super init]) {
        self.leftLabelTextAlignment = NSTextAlignmentLeft;
        self.largeLabelTextAlignment = NSTextAlignmentLeft;
    }
    return self;
}

-(UIFont *)leftLabelFont {
    if (_leftLabelFont == nil) {
        _leftLabelFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    }
    
    return _leftLabelFont;
}

-(UIColor *)leftLabelTextColor {
    if (_leftLabelTextColor == nil) {
        _leftLabelTextColor = [UIColor blackColor];
    }
    
    return _leftLabelTextColor;
}

-(UIFont *)largeLabelFont {
    if (_largeLabelFont == nil) {
        _largeLabelFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    }
    
    return _largeLabelFont;
}

-(UIColor *)largeLabelTextColor {
    if (_largeLabelTextColor == nil) {
        _largeLabelTextColor = [UIColor darkGrayColor];
    }
    
    return _largeLabelTextColor;
}

-(void)applyToTableViewCell:(RHTableViewCell *)cell {
    cell.leftLabel.font = self.leftLabelFont;
    cell.leftLabel.textColor = self.leftLabelTextColor;
    cell.leftLabel.textAlignment = self.leftLabelTextAlignment;
    
    cell.labelSeparatorView.backgroundColor = self.separatorViewColor;
    
    cell.largeLabel.font = self.largeLabelFont;
    cell.largeLabel.textColor = self.largeLabelTextColor;
    cell.largeLabel.textAlignment = self.largeLabelTextAlignment;
    
    cell.textLabel.font = self.leftLabelFont;
    // cell.textLabel.textColor = self.leftLabelTextColor;
    
    // cell.detailTextLabel.font = self.largeLabelFont;
    // cell.detailTextLabel.textColor = self.largeLabelTextColor;
}

@end