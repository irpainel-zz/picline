//
//  takePictureViewController.m
//  PicLine
//
//  Created by students on 4/23/13.
//  Copyright (c) 2013 Painelli. All rights reserved.
//

#import "takePictureViewController.h"

@interface takePictureViewController ()

@end

@implementation takePictureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *navBackgroundImage = [UIImage imageNamed:@"navBar"];
    [[UINavigationBar appearance] setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.toolbar setBackgroundImage:navBackgroundImage forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takePicure:)] autorelease];
    UIBarButtonItem *flexSpacer = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil] autorelease];
    
    //self.navigationItem.rightBarButtonItem = addButton;
    NSArray* toolbarItems = [NSArray arrayWithObjects:flexSpacer, addButton, flexSpacer, nil];
    //[toolbarItems makeObjectsPerformSelector:@selector(release)];
    self.toolbarItems = toolbarItems;
    self.navigationController.toolbarHidden = YES;
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



@end
