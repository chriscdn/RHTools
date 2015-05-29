//
//  RHTableViewCell.h
//  Version: 0.1
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

// #define kRHDetailLabelLeftMargin IsIOS61orEarlier ? 83 : 112
// #define kRHTopBottomMargin 11
#define kRHDefaultCellHeight 44

#import "RHTextField.h"

@interface RHTableViewCell : UITableViewCell

typedef void (^RHReloadCellBlock)(RHTableViewCell *cell);

@property (nonatomic, copy) RHBoringBlock didSelectBlock;
@property (nonatomic, copy) RHReloadCellBlock reloadCellBlock;

@property (strong, nonatomic) IBOutlet UILabel *leftLabel;

@property (strong, nonatomic) IBOutlet UIView *labelSeparatorView;

@property (strong, nonatomic) IBOutlet UILabel *largeLabel;
@property (strong, nonatomic) IBOutlet RHTextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;

+(id)cellWithLabelText:(NSString *)labelText
                     detailLabelText:(NSString *)detailLabelText
                      didSelectBlock:(RHBoringBlock)block
                               style:(UITableViewCellStyle)style
                               image:(UIImage *)image
                       accessoryType:(UITableViewCellAccessoryType)accessoryType;

+(id)cellStyle1WithLabelText:(NSString *)labelText detailLabelText:(NSString *)detailLabelText;
+(id)cellStyle2WithLabelText:(NSString *)labelText detailLabelText:(NSString *)detailLabelText;
+(id)cellStyleSubtitleWithLabelText:(NSString *)labelText detailLabelText:(NSString *)detailLabelText;

+(id)cellWithTextField:(NSString *)labelText;
+(id)cellWithTextField:(NSString *)labelText initialValue:(NSString *)initialValue;
+(id)cellWithTextView:(NSString *)labelText;
+(id)cellWithSingleLabel:(NSString *)labelText;
+(id)cellWithLeftLabel:(NSString *)leftText largeLabel:(NSString *)largeText;
+(id)cellWithSwitch:(NSString *)labelText state:(BOOL)state block:(RHSwitchBlock)block;

-(CGFloat)heightWithTableView:(UITableView *)tableView;

@end