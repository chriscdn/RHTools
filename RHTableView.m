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


@end


@implementation RHTableView


-(id)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        
		self.tableSections = [NSMutableArray array];
		self.tableRows = [NSMutableArray array];
        self.textFields = [NSMutableArray array];
    }
    
    return self;
}


-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self=[super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        
		self.tableSections = [NSMutableArray array];
		self.tableRows = [NSMutableArray array];
        self.textFields = [NSMutableArray array];
    }
    
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    self.delegate = self;
    self.dataSource = self;
    
	self.tableSections = [NSMutableArray array];
	self.tableRows = [NSMutableArray array];
}

#pragma mark -

-(void)addSectionWithSectionHeaderName:(NSString *)headerText {
	RHTableSection *section = [[RHTableSection alloc] init];
	section.headerText = headerText;
	[self addSection:section];
}

-(void)addSection:(RHTableSection *)section {
	[self.tableSections addObject:section];
	[self.tableRows addObject:[NSMutableArray array]];
}

-(void)addCell:(RHTableViewCell *)cell {
	[[self.tableRows lastObject] addObject:cell];
    
    UITextField *textField = cell.textField;
    
    if (textField) {
        [textField setReturnKeyType:UIReturnKeyGo];
        [textField setDelegate:self];
        
        UITextField *lastTextField = [self.textFields lastObject];
        [lastTextField setReturnKeyType:UIReturnKeyNext];
        
        [self.textFields addObject:textField];
    }
}

-(void)addCell:(NSString *)labelText didSelectBlock:(RHBoringBlock)block {
    RHTableViewCell *cell = [RHTableViewCell cellWithLabelText:labelText
                                               detailLabelText:nil
                                                didSelectBlock:block
                                                         style:UITableViewCellStyleSubtitle
                                                         image:nil
                                                 accessoryType:UITableViewCellAccessoryNone];
    [self addCell:cell];
}

#pragma mark -
#pragma mark UITableViewDelegate & UITableViewDataSource delegate methods
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
}

-(NSString *)tableView:(UITableView *)_tableView titleForHeaderInSection:(NSInteger)section {
	RHTableSection *_section = [self.tableSections objectAtIndex:section];
	return _section.headerText;
}

-(NSString *)tableView:(UITableView *)_tableView titleForFooterInSection:(NSInteger)section {
	RHTableSection *_section = [self.tableSections objectAtIndex:section];
	return _section.footerText;
}

-(CGFloat)tableView:(UITableView *)_tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	RHTableViewCell *cell = [[self.tableRows objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	return [cell heightWithTableView:_tableView];
}

#pragma mark -
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSUInteger index = [self.textFields indexOfObject:textField];
    
    UITextField *nextTextField = [self.textFields objectAtIndex:index+1 defaultValue:nil];
    
    if (nextTextField) {
        [nextTextField becomeFirstResponder];
    } else if (self.didTapGoBlock) {
        self.didTapGoBlock(self.textFields);
    } else {
        [self resignFirstResponder];
    }
    
    return YES;
}

-(void)hideKeyboard {
    [self.textFields makeObjectsPerformSelector:@selector(resignFirstResponder)];
}

@end
