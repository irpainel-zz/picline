//
//  piclineViewController.h
//  PicLine
//
//  Created by students on 4/12/13.
//  Copyright (c) 2013 Painelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "piclineAppDelegate.h"
#import "Line.h"
#import "Picture.h"

@class takePictureViewController;

@interface piclineViewController : UITableViewController <NSFetchedResultsControllerDelegate, UIAlertViewDelegate>
{
    NSFetchedResultsController *fetchedResultsController;
    
    piclineAppDelegate *app;
}

@property (strong, nonatomic) takePictureViewController *takePictureViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, retain) Line *piclineObject;
@property (retain, nonatomic) IBOutlet UITableView *pictureTableView;

@end
