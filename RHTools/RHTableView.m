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

#import "RHTableView.h"

@interface RHTableView()
@property (nonatomic, strong) NSMutableArray *inputFields;
@property (nonatomic, assign) CGFloat bottomInsetWithoutKeyboard;

-(void)addSection:(RHTableSection *)section;
@end


@implementation RHTableView

// TODO: get rid of this duplicated code

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
    self.textFields = [NSMutableArray array];
    self.textViews = [NSMutableArray array];
    self.inputFields = [NSMutableArray array];
}

-(void)observeKeyboard {
    // UIKeyboardWillChangeFrameNotification doesn't seem to really know the end frame of the keyboard in iOS8.  We therefore follow-up with
    // UIKeyboardDidChangeFrameNotification to make sure our bases our covered.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
}

#pragma mark -

-(void)addSectionWithSectionHeaderText:(NSString *)headerText {
    return [self addSectionWithSectionHeaderText:headerText footerText:nil];
}

-(void)addSectionWithSectionHeaderText:(NSString *)headerText footerText:(NSString *)footerText {
    RHTableSection *section = [[RHTableSection alloc] init];
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
    // [[self.textFields lastObject] setReturnKeyType:UIReturnKeyNext];
    
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

-(void)reloadData {
    [super reloadData];
    
    for (NSArray *section in self.tableRows) {
        for (RHTableViewCell *cell in section) {
            if (cell.reloadCellBlock) {
                cell.reloadCellBlock(cell);
            }
        }
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.tableRows count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.tableRows objectAtIndex:section] count];
}

-(UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self.tableRows objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RHTableViewCell *row = [[self.tableRows objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if (row.didSelectBlock) {
        row.didSelectBlock();
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

-(void)keyboardDidChangeFrame:(NSNotification *)notification {
    // We never know what the original bottom inset is...  We save it here for later.
    if (self.bottomInsetWithoutKeyboard == 0) {
        [self setBottomInsetWithoutKeyboard:self.contentInset.bottom];
    }
    
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardEndFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // This is the relative position of the keyboard within our tableView
    CGRect keyboardFrame = [self convertRect:keyboardEndFrame fromView:nil];
    CGFloat viewHeight = keyboardFrame.origin.y;
    CGFloat adjustedViewHeight = viewHeight - self.contentOffsetY;
    
    // NOTE: self.contentOffsetY is the same as self.bounds.size.
    
    UIEdgeInsets newInset = self.contentInset;
    newInset.bottom = MAX(self.height - adjustedViewHeight, self.bottomInsetWithoutKeyboard);
    
    //    self.contentInset = newInset;
    //   self.scrollIndicatorInsets = newInset;
    
    
    NSTimeInterval animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions animationCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:animationCurve
                     animations:^{
                         self.contentInset = newInset;
                         self.scrollIndicatorInsets = newInset;
                     }
                     completion:nil];



}

/**
 * iOS8.3 seems to have trouble with the "will" notifications in that the
 * converted keyboard frame to the table won't always be initially correct.
 *
 * This may need to be revisited in the future, but this seems to work on all devices in all orientations
 * with or without that auto suggest keyboard thing.
 */

/*
 -(void)keyboardWillShow:(NSNotification *)notification {
 
 NSDictionary *userInfo = [notification userInfo];
 
 CGRect keyboardEndFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
 
 // This is the relative position of the keyboard within our tableView
 CGRect keyboardFrame = [self convertRect:keyboardEndFrame fromView:nil];
 CGFloat viewHeight = keyboardFrame.origin.y;
 CGFloat adjustedViewHeight = viewHeight - self.contentOffsetY;
 
 //  CGFloat contentHeight = self.contentSize.height;
 
 NSLog(@"%@", @"-------");
 
 NSLog(@"Keyboard Original FRAME: %@", NSStringFromCGRect(keyboardEndFrame));
 NSLog(@"Keyboard Converted FRAME: %@", NSStringFromCGRect(keyboardFrame));
 NSLog(@"Table Bounds:: %@", NSStringFromCGRect(self.bounds));
 
 //  NSLog(@"** Content Height: %f", contentHeight);
 NSLog(@"** Content Offset Y: %f", self.contentOffsetY);
 // NSLog(@"Original Keyboard Height: %f", keyboardEndFrame.size.height);
 NSLog(@"** Keyboard Height: %f", viewHeight);
 
 // UIEdgeInsets adfadf = self.scrollIndicatorInsets;
 
 UIEdgeInsets newInset = self.contentInset;
 // newInset.bottom = MAX(contentHeight + self.contentInset.top - self.bounds.origin.y - viewHeight, 0);
 
 
 NSLog(@"Adjusted maybe?: %f", adjustedViewHeight);
 
 NSLog(@"Height: %f", self.height);
 NSLog(@"Bound Height: %f", self.bounds.size.height);
 
 UIEdgeInsets zzz = self.contentInset;
 
 newInset.bottom = MAX(self.height - adjustedViewHeight, 0);
 
 
 // newInset.bottom = MAX(viewHeight, 0);2
 
 
 NSLog(@"New Bottom: %f", newInset.bottom);
 
 self.contentInset = newInset;
 self.scrollIndicatorInsets = newInset;
 
 }
 
 -(void)keyboardWillHide:(NSNotification *)notification {
 UIEdgeInsets newInset = self.contentInset;
 newInset.bottom = 0;
 self.contentInset = newInset;
 self.scrollIndicatorInsets = newInset;
 
 // self.height = [self superview].bounds.size.height;
 }
 */

-(void)hideKeyboard {
    [self.inputFields makeObjectsPerformSelector:@selector(resignFirstResponder)];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end