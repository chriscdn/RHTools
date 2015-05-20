//
//  RHKeyboardScrunchView.m
//  Pods
//
//  Created by Christopher Meyer on 16/05/15.
//
//

#import "RHKeyboardScrunchView.h"

@interface RHKeyboardScrunchView()
@property (nonatomic, strong) NSLayoutConstraint *bottomConstraint;
@end

@implementation RHKeyboardScrunchView

// CODE

-(id)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        
    }
    return self;
}


// NIB
-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self=[super initWithCoder:aDecoder]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
    }
    return self;
}


-(void)didMoveToSuperview {
    [super didMoveToSuperview];
 
    if (self.superview) {
    [self.superview addConstraint:self.bottomConstraint];
    
    
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self.superview attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0]];
    
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self.superview attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:0]];
    
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self.superview attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:0]];
    }

    
}


-(NSLayoutConstraint *)bottomConstraint {
    if (_bottomConstraint == nil) {
        self.bottomConstraint = [NSLayoutConstraint
                                 constraintWithItem:self.superview
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:self
                                 attribute:NSLayoutAttributeBottom
                                 multiplier:1.0f
                                 constant:0];
    }
    
    return _bottomConstraint;
    
}

-(void)keyboardDidChangeFrame:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardEndFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect keyboardFrame = [self.superview convertRect:keyboardEndFrame fromView:nil];
    
    self.bottomConstraint.constant = (self.superview.height-keyboardFrame.origin.y);
    [self.superview setNeedsUpdateConstraints];
    
    NSTimeInterval animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions animationCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:animationCurve
                     animations:^{
                         [self.superview layoutIfNeeded];
                     }
                     completion:nil];
    
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
