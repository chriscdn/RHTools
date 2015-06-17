//
//  RHImagePickerController.m
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

#import "RHImagePickerController.h"
#import <ImageIO/CGImageProperties.h>

@interface RHImagePickerController ()
+(void)saveImage:(UIImage *)image metadata:(NSDictionary *)metadata block:(ALAssetsLibraryWriteImageCompletionBlock)_block;
+(NSDictionary *)exifFromLocation:(CLLocation *)location;
@end

@implementation RHImagePickerController

+(BOOL)isCameraAvailable {
	return [self isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

+(RHImagePickerController *)imagePickerControllerWithSource:(UIImagePickerControllerSourceType)source block:(RHImagePickerControllerBlock)block {
	RHImagePickerController *picker = [[RHImagePickerController alloc] init];
	[picker setDelegate:picker];
	[picker setBlock:block];
	[picker setSourceType:source];
	
	return picker;
}


+(void)saveImage:(UIImage *)image metadata:(NSDictionary *)metadata block:(ALAssetsLibraryWriteImageCompletionBlock)_block {
	ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
	[library writeImageToSavedPhotosAlbum:image.CGImage metadata:metadata completionBlock:_block];
}


// Thanks: http://masthigamerz.blogspot.ch/2012/08/save-image-with-geodata-using-alassets.html
+(NSDictionary *)exifFromLocation:(CLLocation *)location {
	
	NSMutableDictionary *locDict = [[NSMutableDictionary alloc] init];
	
	CLLocationDegrees exifLatitude = location.coordinate.latitude;
	CLLocationDegrees exifLongitude = location.coordinate.longitude;
	
	[locDict setObject:location.timestamp forKey:(NSString *)kCGImagePropertyGPSTimeStamp];
	
	if (exifLatitude < 0.0) {
		exifLatitude = exifLatitude*(-1);
		[locDict setObject:@"S" forKey:(NSString *)kCGImagePropertyGPSLatitudeRef];
	} else {
		[locDict setObject:@"N" forKey:(NSString *)kCGImagePropertyGPSLatitudeRef];
	}
	
	[locDict setObject:[NSNumber numberWithFloat:exifLatitude] forKey:(NSString *)kCGImagePropertyGPSLatitude];
	
	if (exifLongitude < 0.0) {
		exifLongitude=exifLongitude*(-1);
		[locDict setObject:@"W" forKey:(NSString *)kCGImagePropertyGPSLongitudeRef];
	} else {
		[locDict setObject:@"E" forKey:(NSString *)kCGImagePropertyGPSLongitudeRef];
	}
	
	[locDict setObject:[NSNumber numberWithFloat:exifLongitude] forKey:(NSString *)kCGImagePropertyGPSLongitude];
	
	return locDict;
}

-(void)imagePickerController:(RHImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	
	self.imageInfo = info;
    
	// do not use self.pickerPopoverController here!
	if (_pickerPopoverController) { // if popover is defined then we're in an iPad app
		
		[self.pickerPopoverController dismissPopoverAnimated:YES];
		
		if (picker.block) {
			picker.block(self);
		}
		picker.block = nil;
		
	} else {
		[picker dismissViewControllerAnimated:YES completion:^{
			if (picker.block) {
				picker.block(self);
			}
			picker.block = nil;
		}];
	}
	
	self.pickerPopoverController = nil;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[self dismissViewControllerAnimated:YES completion:nil];
	
    if (_pickerPopoverController) {
        if ([self.pickerPopoverController isPopoverVisible]) {
            [self.pickerPopoverController dismissPopoverAnimated:YES];
        }
    }
	
	self.block = nil;
	self.pickerPopoverController = nil;
}

#pragma mark -
#pragma mark UIpickerPopoverController and UIpickerPopoverControllerDelegate

// Wrap the controller in a popover, assign a delegate, and return it.
-(UIPopoverController *)pickerPopoverController {
	if ( IsIPad && (_pickerPopoverController == nil) ) {
		self.pickerPopoverController = [[UIPopoverController alloc] initWithContentViewController:self];
		[_pickerPopoverController setDelegate:self];
	}
    
	return _pickerPopoverController;
}

// From the Apple Docs:
// The popover controller does not call this method in response to programmatic calls to the dismissPopoverAnimated: method.
-(void)pickerPopoverControllerDidDismissPopover:(UIPopoverController *)pickerPopoverController {
	self.block = nil;
	self.pickerPopoverController = nil;
	// self.dismissCompletionBlock = nil;
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

-(void)saveOriginalImage:(ALAssetsLibraryWriteImageCompletionBlock)block {
	if ([self isCameraImage]) {
		[RHImagePickerController saveImage:[self originalImage] metadata:[self metadata] block:block];
	}
}

-(void)saveOriginalImageWithLocation:(CLLocation *)location block:(ALAssetsLibraryWriteImageCompletionBlock)block {
	if ([self isCameraImage]) {
		if (location) {
			NSMutableDictionary *_metadata = [NSMutableDictionary dictionaryWithDictionary:[self metadata]];
			NSDictionary *geotag = [RHImagePickerController exifFromLocation:location];
			[_metadata setObject:geotag forKey:(NSString*)kCGImagePropertyGPSDictionary];
			[RHImagePickerController saveImage:[self originalImage] metadata:_metadata block:block];
		} else {
			[self saveOriginalImage:block];
		}
	}
}

-(void)dealloc {
	// NSLog(@"%@", @"dealloc called rhimagepickercontroller");
}

@end