//
//  setDetailsViewController.m
//  PicLine
//
//  Created by students on 4/25/13.
//  Copyright (c) 2013 Painelli. All rights reserved.
//

#import "setDetailsViewController.h"
#import "Line.h"
#import "Picture.h"
#import "piclineAppDelegate.h"
#import "ImageStore.h"
#import "piclineViewController.h"

@interface setDetailsViewController ()

@end

@implementation setDetailsViewController
@synthesize imageDetail;
@synthesize picTitle;
@synthesize picDetails;
@synthesize emoticonSelection;
@synthesize toolbar;
@synthesize imageFromUser;
@synthesize piclineObject;
@synthesize pictureObject;
@synthesize fetchedResultsController = _fetchedResultsController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];// this will do the trick
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[self imageDetail]setImage:imageFromUser];
    self.navigationController.toolbarHidden = YES;
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidUnload
{
    [self setImageDetail:nil];
    [self setPicTitle:nil];
    [self setPicDetails:nil];
    [self setEmoticonSelection:nil];
    [self setToolbar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [imageDetail release];
    [picTitle release];
    [picDetails release];
    [emoticonSelection release];
    [toolbar release];
    [super dealloc];
}
- (IBAction)savePicture:(id)sender {
    
    //[imageView setImage:image];
    
    CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
    
    CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
    
    NSString *key = ( NSString *)newUniqueIDString;
    
    Line *currentLine = piclineObject;
    NSManagedObjectContext *context = [(piclineAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    Picture *newPicture = [NSEntityDescription insertNewObjectForEntityForName:@"Picture" inManagedObjectContext:context];
    [newPicture setValue:[NSDate date] forKey:@"timeStamp"];
    
    [newPicture setPictureId:key];
    NSLog(@"Selected Emoticon Indes %d",[emoticonSelection selectedSegmentIndex]);
    [newPicture setEmoticon:[NSNumber numberWithInt:[emoticonSelection selectedSegmentIndex]]];
    [newPicture setName:[NSString stringWithFormat:@"%@",[picTitle text]]];
    [newPicture setDetail:[NSString stringWithFormat:@"%@",[picDetails text]]];
    
    //newPictureObject.pictureId = key;
    NSLog(@"Setou Key %@",[newPicture pictureId]);
    [[ImageStore sharedStore]setImage:imageFromUser forKey:[newPicture pictureId]];
    
    CFRelease(newUniqueID);
    CFRelease(newUniqueIDString);
    
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    [currentLine addPicturesObject:newPicture];
    
    if (![context save:&error]) {
        NSLog(@"Unresolved error");
        abort();
    }
    NSLog(@"Salvou Imagem");
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancelPicture:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//move texts
#define kOFFSET_FOR_KEYBOARD 120.0

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:picTitle])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}



//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}



@end
