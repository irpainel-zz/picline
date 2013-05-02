//
//  takePictureViewController.h
//  PicLine
//
//  Created by students on 4/23/13.
//  Copyright (c) 2013 Painelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Line.h"

@interface takePictureViewController : UIViewController <UIImagePickerControllerDelegate>

@property (strong, retain) Line *piclineObject;
@property (strong, retain) UIImagePickerController *imagePickerReference;

@end
