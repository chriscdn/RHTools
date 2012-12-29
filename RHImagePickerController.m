//
//  RHImagePickerController.m
//  Version: 0.1
//
//  Copyright (C) 2012 by Christopher Meyer
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

#import "RHImagePickerController.h"

@interface RHImagePickerController ()
@end

@implementation RHImagePickerController
@synthesize block;
@synthesize dismissCompletionBlock;
@synthesize imageInfo;
@synthesize popoverController;

+(BOOL)isCameraAvailable {
	return [self isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

+(RHImagePickerController *)imagePickerControllerWithSource:(UIImagePickerControllerSourceType)_source block:(RHImagePickerControllerBlock)_block {
	RHImagePickerController *picker = [[RHImagePickerController alloc] init];
	[picker setDelegate:picker];
	[picker setBlock:_block];
	[picker setSourceType:_source];
	
	return picker;
}

-(void)imagePickerController:(RHImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	
	self.imageInfo = info;
	
	if (popoverController) { // if popover is defined and then we're in an iPad app

		[self.popoverController dismissPopoverAnimated:YES];
		
		if (picker.dismissCompletionBlock) {
			picker.dismissCompletionBlock(self);
			self.dismissCompletionBlock = nil;
		}
		
	} else {
		[picker dismissViewControllerAnimated:YES completion:^{
			// We need to use picker instead of self in order to retain the object in the block.
			if (picker.dismissCompletionBlock) {
				picker.dismissCompletionBlock(self);
				self.dismissCompletionBlock = nil;
			}
		}];
	}
	
	if (picker.block) {
		picker.block(self);
	}
	
	self.block = nil;
	self.popoverController = nil;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[self dismissViewControllerAnimated:YES completion:nil];
	
	if ([popoverController isPopoverVisible]) {
		[self.popoverController dismissPopoverAnimated:YES];
	}
	
	self.block = nil;
	self.popoverController = nil;
}

#pragma mark -
#pragma mark UIPopoverController and UIPopoverControllerDelegate

-(UIPopoverController *)popoverController {
	if (popoverController == nil) {
		self.popoverController = [[UIPopoverController alloc] initWithContentViewController:self];
		[popoverController setDelegate:self];
	}
	return popoverController;
}

// From the Apple Docs:
// The popover controller does not call this method in response to programmatic calls to the dismissPopoverAnimated: method.
-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
	self.block = nil;
	self.popoverController = nil;
	self.dismissCompletionBlock = nil;
}

#pragma mark -
-(BOOL)isCameraImage {
	return ( self.sourceType == UIImagePickerControllerSourceTypeCamera );
}

-(UIImage *)originalImage {
	return [self.imageInfo objectForKey:UIImagePickerControllerOriginalImage];
}

-(UIImage *)editedImage {
	return [self.imageInfo objectForKey:UIImagePickerControllerEditedImage];
}

-(NSDictionary *)metadata {
	return [self.imageInfo objectForKey:UIImagePickerControllerMediaMetadata];
}

-(void)saveOriginalImage:(ALAssetsLibraryWriteImageCompletionBlock)_block {
	if ([self isCameraImage]) {
		ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
		UIImage *image = [self originalImage];
		NSDictionary *metadata = [self metadata];
		
		[library writeImageToSavedPhotosAlbum:image.CGImage metadata:metadata completionBlock:_block];
	}
}

-(void)dealloc {
	NSLog(@"%@", @"dealloc called rhimagepicker");
}

@end

