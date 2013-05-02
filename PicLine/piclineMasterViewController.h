//
//  piclineMasterViewController.h
//  PicLine
//
//  Created by students on 4/12/13.
//  Copyright (c) 2013 Painelli. All rights reserved.
//

#import <UIKit/UIKit.h>

@class piclineViewController;

#import <CoreData/CoreData.h>
#import "piclineAppDelegate.h"

@interface piclineMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate, UIAlertViewDelegate>{
    NSFetchedResultsController *fetchedResultsController;
    
    piclineAppDelegate *app;
}

@property (strong, nonatomic) piclineViewController *piclineViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;



@end
