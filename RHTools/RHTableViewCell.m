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

// A style for a cell with a label on the left side of the cell with text that is right-aligned and blue; on the right side of the cell is another
// label with smaller text that is left-aligned and black. The Phone/Contacts application uses cells in this style.

// This cell style automatically grows to accomodate long text.
+(id)cellStyle2WithLabelText:(NSString *)labelText detailLabelText:(NSString *)detailLabelText {

    RHTableViewCell *cell = [self cellWithLabelText:labelText detailLabelText:detailLabelText didSelectBlock:nil style:UITableViewCellStyleValue2 image:nil accessoryType:UITableViewCellAccessoryNone];

	[cell.detailTextLabel setNumberOfLines:0];
	[cell.detailTextLabel setLineBreakMode:NSLineBreakByWordWrapping];

    return cell;
}

+(id)cellStyleSubtitleWithLabelText:(NSString *)labelText detailLabelText:(NSString *)detailLabelText {
    RHTableViewCell *cell = [self cellWithLabelText:labelText detailLabelText:detailLabelText didSelectBlock:nil style:UITableViewCellStyleSubtitle image:nil accessoryType:UITableViewCellAccessoryNone];

	[cell.detailTextLabel setNumberOfLines:0];
	[cell.detailTextLabel setLineBreakMode:NSLineBreakByWordWrapping];

    return cell;
}

// Left aligned label with form input field.
+(id)cellWithTextField:(NSString *)labelText {

    RHTableViewCell *cell = [self cellWithLabelText:labelText detailLabelText:nil didSelectBlock:nil style:UITableViewCellStyleValue1 image:nil accessoryType:UITableViewCellAccessoryNone];

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    cell.textField = [[RHTextField alloc] initWithFrame:CGRectZero];
    cell.textField.text = @"";
    cell.textField.adjustsFontSizeToFitWidth = YES;
    cell.textField.minimumFontSize = 12;
    cell.textField.textColor = [UIColor colorWithRed:0.196 green:0.31 blue:0.522 alpha:1.0 ];
    cell.textField.returnKeyType = UIReturnKeyDone;
    cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
	cell.textField.layer.cornerRadius = 4.0f;
	cell.textField.layer.masksToBounds = YES;
	cell.textField.backgroundColor = RGB(245, 245, 245);

	// http://stackoverflow.com/questions/3727068/set-padding-for-uitextfield-with-uitextborderstylenone
	UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
	cell.textField.leftView = paddingView;
	cell.textField.leftViewMode = UITextFieldViewModeAlways;

    [cell.contentView addSubview:cell.textField];

    return cell;
}

// Right aligned label with form input field.
+(id)cellWithTextField2:(NSString *)labelText {

    RHTableViewCell *cell = [self cellWithLabelText:labelText detailLabelText:nil didSelectBlock:nil style:UITableViewCellStyleValue2 image:nil accessoryType:UITableViewCellAccessoryNone];

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    cell.textField = [[RHTextField alloc] initWithFrame:CGRectZero];
    cell.textField.text = @"";
    cell.textField.adjustsFontSizeToFitWidth = YES;
	cell.textField.minimumFontSize = 12;
    cell.textField.textColor = [UIColor colorWithRed:0.196 green:0.31 blue:0.522 alpha:1.0 ];
    cell.textField.returnKeyType = UIReturnKeyDone;
    cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
	cell.textField.layer.cornerRadius = 4.0f;
	cell.textField.layer.masksToBounds = YES;
	cell.textField.backgroundColor = RGB(245, 245, 245);

	// http://stackoverflow.com/questions/3727068/set-padding-for-uitextfield-with-uitextborderstylenone
	UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
	cell.textField.leftView = paddingView;
	cell.textField.leftViewMode = UITextFieldViewModeAlways;

    [cell.contentView addSubview:cell.textField];

    return cell;
}


// Right aligned label with larger form textarea field.
+(id)cellWithTextView:(NSString *)labelText {

    RHTableViewCell *cell = [self cellWithLabelText:labelText detailLabelText:nil didSelectBlock:nil style:UITableViewCellStyleValue1 image:nil accessoryType:UITableViewCellAccessoryNone];

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

	cell.textView = [[UITextView alloc] initWithFrame:CGRectZero];
	cell.textView.text = @"";
	[cell.textView.layer setCornerRadius:4.0f];
	[cell.textView.layer setMasksToBounds:YES];
	[cell.textView setBackgroundColor:RGB(245, 245, 245)];

    [cell.contentView addSubview:cell.textView];

    return cell;
}

// Right aligned label with larger form textarea field.
+(id)cellWithTextView2:(NSString *)labelText {

    RHTableViewCell *cell = [self cellWithLabelText:labelText detailLabelText:nil didSelectBlock:nil style:UITableViewCellStyleValue2 image:nil accessoryType:UITableViewCellAccessoryNone];

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

	cell.textView = [[UITextView alloc] initWithFrame:CGRectZero];
	cell.textView.text = @"";
	[cell.textView.layer setCornerRadius:4.0f];
	[cell.textView.layer setMasksToBounds:YES];
	[cell.textView setBackgroundColor:RGB(245, 245, 245)];

    [cell.contentView addSubview:cell.textView];

    return cell;
}

+(id)cellWithSwitch:(NSString *)labelText state:(BOOL)state block:(RHSwitchBlock)block{
	RHTableViewCell *cell = [[RHTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	[cell.textLabel setText:labelText];
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];

	RHSwitch *switcher = [[RHSwitch alloc] initWithBlock:block state:state];
	[cell setAccessoryView:switcher];
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

	if ( (self.cellStyle == UITableViewCellStyleSubtitle) && (lineBreakMode == NSLineBreakByWordWrapping) ) {

		NSString *text = self.detailTextLabel.text;
		UIFont *font   = self.detailTextLabel.font;

//		CGFloat detailLabelWidth = [self detailLabelWidth:tableView];
		CGFloat widthTable = tableView.bounds.size.width;
		CGSize withinSize = CGSizeMake(widthTable, MAXFLOAT);
		// CGSize size = [text sizeWithFont:font constrainedToSize:withinSize lineBreakMode:lineBreakMode];

		CGRect textRect = [text boundingRectWithSize:withinSize
											 options:NSStringDrawingUsesLineFragmentOrigin
										  attributes:@{NSFontAttributeName:font}
											 context:nil];

		CGSize size = textRect.size;


		return MAX(kRHDefaultCellHeight, size.height + kRHTopBottomMargin*4);

	} else if ( (self.cellStyle == UITableViewCellStyleValue2) && (lineBreakMode == NSLineBreakByWordWrapping) ) {

		NSString *text = self.detailTextLabel.text;
		UIFont *font   = self.detailTextLabel.font;

		CGFloat detailLabelWidth = [self detailLabelWidth:tableView];
		CGSize withinSize = CGSizeMake(detailLabelWidth, MAXFLOAT);
		// CGSize size = [text sizeWithFont:font constrainedToSize:withinSize lineBreakMode:lineBreakMode];

		CGRect textRect = [text boundingRectWithSize:withinSize
											 options:NSStringDrawingUsesLineFragmentOrigin
										  attributes:@{NSFontAttributeName:font}
											 context:nil];

		CGSize size = textRect.size;

		return MAX(kRHDefaultCellHeight, size.height + kRHTopBottomMargin*2);

	} else if (self.textView) {

		return 100;

	}

	return kRHDefaultCellHeight;

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
	// The assumption is a subtitle otherwise
	CGFloat detailWidth = (self.cellStyle == UITableViewCellStyleValue2) ? 93 : 0;
	return width-margins-detailWidth;
}

-(void)layoutSubviews {
	[super layoutSubviews];

	static CGFloat FORM_CELL_PAD_LEFT_IPHONE = 110;
	static CGFloat FORM_CELL_PAD_RIGHT = 10;

	if ( self.textField ) {

		// With a default 44 pixel cell we have a 10px margin top and bottom
		static CGFloat TEXTFIELD_HEIGHT = 24;

        [self.contentView bringSubviewToFront:self.textField];

        self.textField.frame = CGRectMake( FORM_CELL_PAD_LEFT_IPHONE,
                                          round(self.contentView.bounds.size.height/2 - TEXTFIELD_HEIGHT/2),
                                          self.contentView.bounds.size.width - FORM_CELL_PAD_RIGHT - FORM_CELL_PAD_LEFT_IPHONE,
                                          TEXTFIELD_HEIGHT);
    } else if (self.textView) {

		// With a default 100 pixel cell we have a 10px margin top and bottom
		static CGFloat TEXTVIEW_HEIGHT = 80;

		[self.contentView bringSubviewToFront:self.textView];

		self.textView.frame = CGRectMake( FORM_CELL_PAD_LEFT_IPHONE,
										 round(self.contentView.bounds.size.height/2 - TEXTVIEW_HEIGHT/2),
										 self.contentView.bounds.size.width - FORM_CELL_PAD_RIGHT - FORM_CELL_PAD_LEFT_IPHONE,
										 TEXTVIEW_HEIGHT);
	}
}

-(void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
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