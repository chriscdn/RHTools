//
//  RHPopoverController.m
//  Pods
//
//  Created by Christopher Meyer on 21/04/15.
//
//

#import "RHPopoverController.h"

static RHPopoverController *_sharedInstance;

@implementation RHPopoverController

+(RHPopoverController *)sharedInstance {
    return _sharedInstance;
}

+(RHPopoverController *)popOverWithContentViewController:(UIViewController *)controller {
    
    RHPopoverController *popover = [[RHPopoverController alloc] initWithContentViewController:controller];
    
    _sharedInstance = popover;
    
    return [self sharedInstance];
}

+(RHPopoverController *)popOverWithContentViewController:(UIViewController *)controller presentFromBarButtonItem:(UIBarButtonItem *)barButtonItem permittedArrowDirection:(UIPopoverArrowDirection)arrowDirections {
    
    RHPopoverController *popover = [self popOverWithContentViewController:controller];
    [popover presentPopoverFromBarButtonItem:barButtonItem permittedArrowDirections:arrowDirections animated:YES];
    
    return popover;
}

+(void)dismiss {
    [[self sharedInstance] dismissPopoverAnimated:YES];
}


@end