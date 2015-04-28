//
//  RHPopoverController.h
//  Pods
//
//  Created by Christopher Meyer on 21/04/15.
//
//

#import <UIKit/UIKit.h>

@interface RHPopoverController : UIPopoverController

+(RHPopoverController *)sharedInstance;
+(RHPopoverController *)popOverWithContentViewController:(UIViewController *)controller;
+(RHPopoverController *)popOverWithContentViewController:(UIViewController *)controller presentFromBarButtonItem:(UIBarButtonItem *)barButtonItem permittedArrowDirection:(UIPopoverArrowDirection)arrowDirections;

+(void)dismiss;



@end