//
//  RHTableView.h
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

typedef void (^RHWillDisplayCellBlock)(UITableView * _Nonnull tableView, UITableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath);
@class RHTableViewCellLayout;
@class RHTableViewCell;

@interface RHTableView : UITableView<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) RHWillDisplayCellBlock _Nullable willDisplayCellBlock;
@property (nonatomic, assign) BOOL deselectRowAfterSelect;
@property (nonatomic, strong) RHTableViewCellLayout * _Nonnull tableViewCellLayout;

@property (nonatomic, strong) NSMutableArray * _Nonnull tableSections;
@property (nonatomic, strong) NSMutableArray * _Nonnull tableRows;
@property (nonatomic, strong) NSMutableArray * _Nonnull textLabels;
@property (nonatomic, strong) NSMutableArray * _Nonnull inputFields;
@property (nonatomic, strong) NSMutableArray * _Nonnull textFields;
@property (nonatomic, strong) NSMutableArray * _Nonnull textViews;


-(void)addSectionWithSectionHeaderText:(NSString *_Nullable)headerText;
-(void)addSectionWithSectionHeaderText:(NSString *_Nullable)headerText footerText:(NSString *_Nullable)footerText;

// -(RHTableViewCell *)addCell:(NSString *)labelText didSelectBlock:(RHBoringBlock)block;
-(RHTableViewCell *_Nonnull)addCell:(NSString *_Nonnull)labelText didSelectBlock:(void (^ __nullable)(RHTableViewCell * _Nullable cell))block;
-(RHTableViewCell *_Nonnull)addCell:(NSString *_Nonnull)labelText detailText:(NSString *_Nonnull)detailText;
-(RHTableViewCell *_Nonnull)addCell:(RHTableViewCell *_Nonnull)row;

-(void)cell:(RHTableViewCell *_Nonnull)cell setHidden:(BOOL)hidden;
-(NSIndexPath *_Nonnull)visibleIndexPath:(RHTableViewCell *_Nonnull)cell;

-(void)advanceFirstResponder:(UIView *_Nonnull)textFieldorTextView;
-(void)setTextFieldsKeyboardReturnToNext;
-(void)hideKeyboard;
-(void)reset;

@end


@interface RHTableSection : NSObject

@property (nonatomic, strong) NSString * _Nullable headerText;
@property (nonatomic, strong) NSString * _Nullable footerText;

@end
