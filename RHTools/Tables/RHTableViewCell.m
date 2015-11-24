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
//

#import "RHTableViewCell.h"

static UIColor *textFieldBackgroundColour;
static UIColor *textViewBackgroundColour;

@interface RHTableViewCell()
@end

@implementation RHTableViewCell

+(void)initialize {
    if (self == [RHTableViewCell class]) {
        textFieldBackgroundColour =  RGB(245, 245, 245);
        textViewBackgroundColour = RGB(245, 245, 245);
    }
}

+(void)setTextFieldBackgroundColour:(UIColor *)backgroundColor {
    textFieldBackgroundColour = backgroundColor;
}

+(id)cellWithLabelText:(NSString *)labelText
       detailLabelText:(NSString *)detailLabelText
        didSelectBlock:(void(^)(RHTableViewCell *cell))block
                 style:(UITableViewCellStyle)style
                 image:(UIImage *)image
         accessoryType:(UITableViewCellAccessoryType)accessoryType {
    
    RHTableViewCell *cell = [[self alloc] initWithStyle:style reuseIdentifier:nil];
    [cell.imageView setImage:image];
    [cell.textLabel setText:labelText];
    [cell.detailTextLabel setText:detailLabelText];
    [cell setAccessoryType:accessoryType];
    [cell setDidSelectBlock:block];
    
    return cell;
}

+(id)cellWithLabelText:(NSString *)labelText
       detailLabelText:(NSString *)detailLabelText
        didSelectBlock:(void(^)(RHTableViewCell *cell))block
           reloadBlock:(RHReloadCellBlock)reloadBlock
                 style:(UITableViewCellStyle)style
                 image:(UIImage *)image
         accessoryType:(UITableViewCellAccessoryType)accessoryType {
    
    RHTableViewCell *cell = [self cellWithLabelText:labelText detailLabelText:detailLabelText didSelectBlock:block style:style image:image accessoryType:accessoryType];
    
    [cell setReloadCellBlock:reloadBlock];
    
    return cell;
}

+(id)cellStyleDefaultWithLabelText:(NSString *)labelText {
   return [self cellWithLabelText:labelText detailLabelText:nil didSelectBlock:nil style:UITableViewCellStyleDefault image:nil accessoryType:UITableViewCellAccessoryNone];
}

// A style for a cell with a label on the left side of the cell with text that is right-aligned and blue; on the right side of the cell is another
// label with smaller text that is left-aligned and black. The Phone/Contacts application uses cells in this style.

+(id)cellStyle1WithLabelText:(NSString *)labelText detailLabelText:(NSString *)detailLabelText {
    return [self cellWithLabelText:labelText detailLabelText:detailLabelText didSelectBlock:nil style:UITableViewCellStyleValue1 image:nil accessoryType:UITableViewCellAccessoryNone];
}

+(id)cellStyle2WithLabelText:(NSString *)labelText detailLabelText:(NSString *)detailLabelText {
    return [self cellWithLabelText:labelText detailLabelText:detailLabelText didSelectBlock:nil style:UITableViewCellStyleValue2 image:nil accessoryType:UITableViewCellAccessoryNone];
}

+(id)cellStyleSubtitleWithLabelText:(NSString *)labelText detailLabelText:(NSString *)detailLabelText {
    return [self cellWithLabelText:labelText detailLabelText:detailLabelText didSelectBlock:nil style:UITableViewCellStyleSubtitle image:nil accessoryType:UITableViewCellAccessoryNone];
}

// Left aligned label with form input field.
+(id)cellWithTextField:(NSString *)labelText {
    return [self cellWithTextField:labelText initialValue:nil];
}

+(id)cellWithButtonLabel:(NSString *)label colour:(UIColor *)colour didSelectBlock:(void(^)(RHTableViewCell *cell))block {
    RHTableViewCell *cell = [self cellStyleDefaultWithLabelText:label];
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    [cell.textLabel setTextColor:colour];
    [cell setDidSelectBlock:block];
    return cell;
}

+(id)cellWithTextField:(NSString *)labelText initialValue:(NSString *)initialValue {
    RHTableViewCell *cell = [UIView viewFromNibNamed:@"RHTextFieldTableViewCell" owner:nil bundle:[NSBundle bundleForClass:[self class]]];
    cell.leftLabel.text = labelText;
    cell.textField.text = initialValue;
    cell.textField.adjustsFontSizeToFitWidth = YES;
    cell.textField.textColor = [UIColor colorWithRed:0.196 green:0.31 blue:0.522 alpha:1.0 ];
    cell.textField.returnKeyType = UIReturnKeyDone;
    cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    cell.textField.borderStyle = UITextBorderStyleNone;
    
    // TODO: make this configurable
    cell.textField.backgroundColor = textFieldBackgroundColour;
    
    return cell;
}

+(id)cellWithTextView:(NSString *)labelText {
    RHTableViewCell *cell = [UIView viewFromNibNamed:@"RHTextViewTableViewCell"];
   
    cell.leftLabel.text = labelText;
    // give the textview a light gray background
    // TODO: make this configurable
    cell.textView.backgroundColor = textViewBackgroundColour;
    // cell.textView.text = nil;
    
    return cell;
}

+(id)cellWithSwitch:(NSString *)labelText state:(BOOL)state block:(void (^)(RHSwitch *rhswitch))block {
    RHTableViewCell *cell = [[RHTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    [cell setDidSelectBlock:nil];
    [cell.textLabel setText:labelText];
    
    RHSwitch *switcher = [[RHSwitch alloc] initWithBlock:block state:state];
    [cell setAccessoryView:switcher];
    return cell;
}

+(id)cellWithSingleLabel:(NSString *)labelText {
    RHTableViewCell *cell = [UIView viewFromNibNamed:@"RHSingleLabelTableViewCell" owner:nil bundle:[NSBundle bundleForClass:self]];
    [cell.largeLabel setText:labelText];
    return cell;
}

+(id)cellWithLeftLabel:(NSString *)leftText largeLabel:(NSString *)largeText {
    RHTableViewCell *cell = [UIView viewFromNibNamed:@"RHLabelTableViewCell" owner:nil bundle:[NSBundle bundleForClass:self]];
    [cell.leftLabel setText:leftText];
    [cell.largeLabel setText:largeText];
    return cell;
}

+(id)cellWithImage:(UIImage *)image label:(NSString *)labelText {
    RHTableViewCell *cell = [UIView viewFromNibNamed:@"RHImageLabelTableViewCell" owner:nil bundle:[NSBundle bundleForClass:self]];
    [cell.imageView2 setImage:image];
    [cell.largeLabel setText:labelText];
    return cell;
}


-(void)setDidSelectBlock:(void(^)(RHTableViewCell *cell))didSelectBlock {
    _didSelectBlock = didSelectBlock;
    
    if (didSelectBlock) {
        [self setSelectionStyle:UITableViewCellSelectionStyleBlue];
    } else {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
}

-(CGFloat)heightWithTableView:(UITableView *)tableView {
    if (self.heightBlock) {
        return self.heightBlock();
    } else if (self.textView) {
        return 100.0f;
    } else {
        return UITableViewAutomaticDimension;
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