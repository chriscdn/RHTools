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

#define kRHDetailLabelLeftMargin IsIOS61orEarlier ? 83 : 112
#define kRHTopBottomMargin 11
#define kRHDefaultCellHeight 44

#import "RHTextField.h"

@interface RHTableViewCell : UITableViewCell

typedef void (^RHReloadCellBlock)(RHTableViewCell *cell);

@property (nonatomic, copy) RHBoringBlock didSelectBlock;
@property (nonatomic, copy) RHReloadCellBlock reloadCellBlock;
@property (nonatomic, strong) RHTextField *textField;
@property (nonatomic, strong) UITextView *textView;

+(id)cellWithLabelText:(NSString *)labelText
                     detailLabelText:(NSString *)detailLabelText
                      didSelectBlock:(RHBoringBlock)block
                               style:(UITableViewCellStyle)style
                               image:(UIImage *)image
                       accessoryType:(UITableViewCellAccessoryType)accessoryType;

+(id)cellStyle2WithLabelText:(NSString *)labelText detailLabelText:(NSString *)detailLabelText;
+(id)cellStyleSubtitleWithLabelText:(NSString *)labelText detailLabelText:(NSString *)detailLabelText;
+(id)cellWithInputField:(NSString *)labelText;
+(id)cellWithInputField2:(NSString *)labelText;
+(id)cellWithTextView:(NSString *)labelText;
+(id)cellWithTextView2:(NSString *)labelText;
+(id)cellWithSwitch:(NSString *)labelText block:(RHSwitchBlock)block state:(BOOL)state;

-(CGFloat)heightWithTableView:(UITableView *)tableView;
-(CGFloat)leftMarginForTableView:(UITableView *)tableView;
-(CGFloat)detailLabelWidth:(UITableView *)tableView;

@end