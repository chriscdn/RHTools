//
//  RHImagePickerController.h
//  Version: 0.2
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

#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>

@interface RHImagePickerController : UIImagePickerController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverControllerDelegate>

typedef void (^RHImagePickerControllerBlock)(RHImagePickerController *_picker);

@property (nonatomic, strong) NSDictionary *imageInfo;
@property (nonatomic, copy) RHImagePickerControllerBlock block;
@property (nonatomic, strong) UIPopoverController *pickerPopoverController;

+(BOOL)isCameraAvailable;
+(RHImagePickerController *)imagePickerControllerWithSource:(UIImagePickerControllerSourceType)source block:(RHImagePickerControllerBlock)block;

-(BOOL)isCameraImage;
-(UIImage *)originalImage;
-(UIImage *)editedImage;
-(NSDictionary *)metadata;

-(void)saveOriginalImage:(ALAssetsLibraryWriteImageCompletionBlock)_block;
-(void)saveOriginalImageWithLocation:(CLLocation *)location block:(ALAssetsLibraryWriteImageCompletionBlock)_block;

@end