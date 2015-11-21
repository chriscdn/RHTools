//
//  RHTableView.m
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

#import "RHTableView.h"

@interface RHTableView()

-(void)addSection:(RHTableSection *)section;
-(void)scrollToView:(UIView *)view;

@end


@implementation RHTableView

-(id)init {
    if (self=[super init]) {
        [self reset];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        [self reset];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self=[super initWithCoder:aDecoder]) {
        [self reset];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self=[super initWithFrame:frame style:style]) {
        [self reset];
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self reset];
}

-(void)reset {
    self.delegate = self;
    self.dataSource = self;
    
    self.tableSections = [NSMutableArray array];
    self.tableRows = [NSMutableArray array];
    self.textLabels = [NSMutableArray array];
    self.textFields = [NSMutableArray array];
    self.textViews = [NSMutableArray array];
    self.inputFields = [NSMutableArray array];
    self.deselectRowAfterSelect = YES;
    
    // trial and error indicates a low number here improves the changes of autolayout
    // correctly setting the cell height based on an expanding UILabel
    [self setEstimatedRowHeight:44.0f];
    [self setRowHeight:UITableViewAutomaticDimension];
    
    // required for iOS9 and our custom tableviewcells
    if ([self respondsToSelector:@selector(setCellLayoutMarginsFollowReadableWidth:)]) {
        [self setCellLayoutMarginsFollowReadableWidth:NO];
    }
}

-(RHTableViewCellLayout *)tableViewCellLayout {
    if (_tableViewCellLayout == nil) {
        _tableViewCellLayout = [RHTableViewCellLayout new];
    }
    return _tableViewCellLayout;
}

#pragma mark -

-(void)addSectionWithSectionHeaderText:(NSString *)headerText {
    return [self addSectionWithSectionHeaderText:headerText footerText:nil];
}

-(void)addSectionWithSectionHeaderText:(NSString *)headerText footerText:(NSString *)footerText {
    RHTableSection *section = [RHTableSection new];
    section.headerText = headerText;
    section.footerText = footerText;
    [self addSection:section];
}

-(void)addSection:(RHTableSection *)section {
    [self.tableSections addObject:section];
    [self.tableRows addObject:[NSMutableArray array]];
}

-(RHTableViewCell *)addCell:(RHTableViewCell *)cell {
    [[self.tableRows lastObject] addObject:cell];
    
    // It's quite important to apply this here and early such that autolayout will properly accomodate for any changes in font and font size. 2015-05-31
    [self.tableViewCellLayout applyToTableViewCell:cell];
    
    if (cell.textField) {
        
        RHTextField *textField = cell.textField;
        
        __weak RHTableView *bself = self;
        [textField setDidBeginEditingBlock:^(RHTextField *textField) {
            [bself scrollToView:textField];
        }];
        
        [self.textFields addObject:textField];
        [self.inputFields addObject:textField];
        
    } else if (cell.textView) {
        // [cell.textView setDelegate:self];
        [self.textViews addObject:cell.textView];
        [self.inputFields addObject:cell.textView];
    }
    
    if (cell.leftLabel) {
        [self.textLabels addObject:cell.leftLabel];
    }
    
    return cell;
}

-(RHTableViewCell *)addCell:(NSString *)labelText detailText:(NSString *)detailText {
    RHTableViewCell *cell = [RHTableViewCell cellWithLabelText:labelText
                                               detailLabelText:detailText
                                                didSelectBlock:nil
                                                         style:UITableViewCellStyleValue1
                                                         image:nil
                                                 accessoryType:UITableViewCellAccessoryNone];
    [self addCell:cell];
    
    return cell;
}

-(RHTableViewCell *)addCell:(NSString *)labelText didSelectBlock:(RHBoringBlock)block {
    RHTableViewCell *cell = [RHTableViewCell cellWithLabelText:labelText
                                               detailLabelText:nil
                                                didSelectBlock:block
                                                         style:UITableViewCellStyleDefault
                                                         image:nil
                                                 accessoryType:UITableViewCellAccessoryNone];
    [self addCell:cell];
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate & UITableViewDataSource delegate methods

-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat labelWidth = 0;
    
    // get the max label width
    for (UILabel *label in self.textLabels) {
        CGSize labelSize = [label sizeThatFits:CGSizeMake(CGFLOAT_MAX, label.height)];
        labelWidth = fmaxf(labelSize.width, labelWidth);
    }
    
    for (NSArray *section in self.tableRows) {
        for (RHTableViewCell *cell in section) {
            [[cell.leftLabel constraintForAttribute:NSLayoutAttributeWidth] setConstant:labelWidth];
        }
    }
}


-(void)reloadData {

    for (NSArray *section in self.tableRows) {
        for (RHTableViewCell *cell in section) {
            if (cell.reloadCellBlock) {
                cell.reloadCellBlock(cell);
            }
        }
    }
    
    [super reloadData];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.tableRows count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.tableRows objectAtIndex:section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self.tableRows objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RHTableViewCell *cell = [[self.tableRows objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if (cell.didSelectBlock) {
        cell.didSelectBlock(cell);
    }
    
    if (self.deselectRowAfterSelect) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    RHTableSection *rhsection = [self.tableSections objectAtIndex:section];
    return rhsection.headerText;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    RHTableSection *rhsection = [self.tableSections objectAtIndex:section];
    return rhsection.footerText;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    RHTableViewCell *cell = [[self.tableRows objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    return [cell heightWithTableView:tableView];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.willDisplayCellBlock) {
        self.willDisplayCellBlock(tableView, cell, indexPath);
    }
}

#pragma mark -
-(void)advanceFirstResponder:(UIView *)textFieldorTextView {
    NSUInteger index = [self.inputFields indexOfObject:textFieldorTextView];
    
    id nextTextFieldorTextView = [self.inputFields objectAtIndex:index+1 defaultValue:nil];
    
    if (nextTextFieldorTextView) {
        [nextTextFieldorTextView becomeFirstResponder];
    } else {
        [self hideKeyboard];
    }
}

-(void)scrollToView:(UIView *)view {
    UITableViewCell *cell = (UITableViewCell *)[view superViewWithClass:@"UITableViewCell"];
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

-(void)setTextFieldsKeyboardReturnToNext {
    __weak RHTableView *bself = self;
    for (RHTextField *textField in self.textFields) {
        
        [textField setReturnKeyType:UIReturnKeyNext];
        
        [textField setShouldReturnBlock:^BOOL(RHTextField *textField) {
            [bself advanceFirstResponder:textField];
            return YES;
        }];
        
    }
}

#pragma mark -
-(void)hideKeyboard {
    [self.inputFields makeObjectsPerformSelector:@selector(resignFirstResponder)];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end