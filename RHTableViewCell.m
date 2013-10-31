//
//  RHTableViewCell.m
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

#import "RHTableViewCell.h"

@interface RHTableViewCell()
@property (nonatomic, assign) UITableViewCellStyle cellStyle;
-(CGFloat)leftMarginForTableView:(UITableView *)tableView;
@end

@implementation RHTableViewCell

+(id)cellWithLabelText:(NSString *)labelText
	   detailLabelText:(NSString *)detailLabelText
		didSelectBlock:(RHBoringBlock)block
				 style:(UITableViewCellStyle)style
				 image:(UIImage *)image
		 accessoryType:(UITableViewCellAccessoryType)accessoryType {

    RHTableViewCell *cell = [[self alloc] initWithStyle:style reuseIdentifier:nil];
    [cell.textLabel setText:labelText];
    [cell.detailTextLabel setText:detailLabelText];
    [cell setDidSelectBlock:block];
    [cell.imageView setImage:image];
    [cell setAccessoryType:accessoryType];
	[cell setCellStyle:style]; // since it's not visible to UITableViewCell

    return cell;
}

+(id)cellStyle2WithLabelText:(NSString *)labelText detailLabelText:(NSString *)detailLabelText {

    RHTableViewCell *cell = [self cellWithLabelText:labelText detailLabelText:detailLabelText didSelectBlock:nil style:UITableViewCellStyleValue2 image:nil accessoryType:UITableViewCellAccessoryNone];
	[cell.detailTextLabel setFont:[UIFont systemFontOfSize:13]];
	[cell.detailTextLabel setNumberOfLines:0];
	[cell.detailTextLabel setLineBreakMode:NSLineBreakByWordWrapping];

    return cell;
}

+(id)cellWithInputField:(NSString *)labelText {

    RHTableViewCell *cell = [self cellWithLabelText:labelText detailLabelText:nil didSelectBlock:nil style:UITableViewCellStyleDefault image:nil accessoryType:UITableViewCellAccessoryNone];

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    cell.textField = [[UITextField alloc] initWithFrame:CGRectZero];
    cell.textField.text = @"";
    cell.textField.adjustsFontSizeToFitWidth = YES;
    cell.textField.minimumFontSize = 12;
    cell.textField.textColor = [UIColor colorWithRed:0.196 green:0.31 blue:0.522 alpha:1.0 ];
    cell.textField.returnKeyType = UIReturnKeyDone;
    cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;

    [cell.contentView addSubview:cell.textField];

    return cell;
}

-(void)setDidSelectBlock:(RHBoringBlock)didSelectBlock {
     _didSelectBlock = didSelectBlock;
    
    if (didSelectBlock) {
        [self setSelectionStyle:UITableViewCellSelectionStyleBlue];
    } else {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
}

-(CGFloat)heightWithTableView:(UITableView *)tableView {

	NSLineBreakMode lineBreakMode = self.detailTextLabel.lineBreakMode;

	if ( (self.cellStyle == UITableViewCellStyleValue2) && (lineBreakMode == NSLineBreakByWordWrapping) ) {
		NSString *text = self.detailTextLabel.text;
		UIFont *font   = self.detailTextLabel.font;

		CGFloat detailLabelWidth = [self detailLabelWidth:tableView];

		CGSize withinSize = CGSizeMake(detailLabelWidth, MAXFLOAT);
		CGSize size = [text sizeWithFont:font constrainedToSize:withinSize lineBreakMode:lineBreakMode];

		return MAX(kRHDefaultCellHeight, size.height + kRHTopBottomMargin*2);
	}

	return 44;
}

-(CGFloat)leftMarginForTableView:(UITableView *)tableView {
    if (tableView.style != UITableViewStyleGrouped) return 0;
    CGFloat widthTable = tableView.bounds.size.width;
    if (IsIPhone)             return (10.0f);
    if (widthTable <= 400.0f) return (10.0f);
    if (widthTable <= 546.0f) return (31.0f);
    if (widthTable >= 720.0f) return (45.0f);
    return (31.0f + ceilf((widthTable - 547.0f)/13.0f));
}

-(CGFloat)detailLabelWidth:(UITableView *)tableView {
	CGFloat width = tableView.frame.size.width;
	CGFloat margin = [self leftMarginForTableView:tableView];
	CGFloat margins = margin * 2;
	CGFloat detailWidth = 93; // must test this parameter with iphone
	return width-margins-detailWidth;
}

-(void)layoutSubviews {
	[super layoutSubviews];
    if ( self.textField ) {

		static CGFloat FORM_CELL_PAD_LEFT_IPHONE = 124;
		static CGFloat FORM_CELL_PAD_RIGHT = 10;
		static CGFloat TEXTFIELD_HEIGHT = 24;

        [self.contentView bringSubviewToFront:self.textField];

        self.textField.frame = CGRectMake( FORM_CELL_PAD_LEFT_IPHONE,
                                          round(self.contentView.bounds.size.height/2 - TEXTFIELD_HEIGHT/2),
                                          self.contentView.bounds.size.width - FORM_CELL_PAD_RIGHT - FORM_CELL_PAD_LEFT_IPHONE,
                                          TEXTFIELD_HEIGHT);
    }
}

@end


@implementation RHTableSection
@synthesize headerText;
@synthesize footerText;

-(id)init {
	if (self=[super init]) {
		self.headerText = @"";
		self.footerText = @"";
	}

	return self;
}

@end