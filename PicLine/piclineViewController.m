//
//  piclineViewController.m
//  PicLine
//
//  Created by students on 4/12/13.
//  Copyright (c) 2013 Painelli. All rights reserved.
//

#import "piclineViewController.h"
#import "Line.h"
#import "Picture.h"
#import "piclineAppDelegate.h"
#import "pictureViewCell.h"
#import "takePictureViewController.h"
#import "setDetailsViewController.h"
#import "ImageStore.h"

@interface piclineViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation piclineViewController

@synthesize piclineObject;
@synthesize pictureTableView;
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewWillAppear:(BOOL)animated{
    [self refreshFetchedResultsController];
    self.navigationController.toolbarHidden = NO;
    self.navigationController.navigationBarHidden = NO;
}

- (void)refreshFetchedResultsController {
    NSLog(@"refreshFetchedResultsController");
    
    
    Line *currentLine = piclineObject;
    // limit to those entities that belong to the particular item
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"lines.name like '%@'",currentLine.name]];
    NSLog(@"%@", predicate);
    
    NSString *cacheNameDetail = @"Detail";
    self.fetchedResultsController = nil;
    
    [[fetchedResultsController fetchRequest] setPredicate:predicate];

    [NSFetchedResultsController deleteCacheWithName:cacheNameDetail];
    
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:NSLocalizedString(@"Error loading data",
                                                              @"Error loading data")
                              message:[NSString stringWithFormat:
                                       
                                       
                                       
                                       NSLocalizedString(@"Error was: %@, quitting.", @"Error was: %@, quitting."),
                                       [error localizedDescription]]
                              delegate:self
                              cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel")
                              otherButtonTitles:nil];
        [alert show];
    }
    [self.tableView reloadData];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
        
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    app = (piclineAppDelegate*)[UIApplication sharedApplication].delegate;
    UINib *nib = [UINib nibWithNibName:@"PictureViewCell" bundle:nil];
    
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"PictureViewCell"];
    
    UIImage *navBackgroundImage = [UIImage imageNamed:@"navBar"];
    [[UINavigationBar appearance] setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.toolbar setBackgroundImage:navBackgroundImage forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(segueToTakePicure:)] autorelease];
    UIBarButtonItem *flexSpacer = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil] autorelease];
    
    //self.navigationItem.rightBarButtonItem = addButton;
    NSArray* toolbarItems = [NSArray arrayWithObjects:flexSpacer, addButton, flexSpacer, nil];
    //[toolbarItems makeObjectsPerformSelector:@selector(release)];
    self.toolbarItems = toolbarItems;
    self.navigationController.toolbarHidden = NO;
    
    
    
    
}


- (void)segueToTakePicure:(id)sender
{
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        imagePicker.showsCameraControls = NO;
        imagePicker.navigationBarHidden = YES;
        imagePicker.toolbarHidden = YES;
        imagePicker.wantsFullScreenLayout = YES;
        
        // Insert the overlay
        takePictureViewController *overlay = [[takePictureViewController alloc] initWithNibName:@"takePictureViewController" bundle:nil];
        overlay.imagePickerReference = imagePicker;
        imagePicker.cameraOverlayView = overlay.view;
        imagePicker.delegate = overlay;
        [self presentModalViewController:imagePicker animated:YES];
    } else {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [imagePicker setDelegate:self];
        [self presentModalViewController:imagePicker animated:YES];
        
    }
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];

    setDetailsViewController *setDetailViewController = [[[setDetailsViewController alloc] initWithNibName:@"setDetailsViewController" bundle:nil] autorelease];
    [setDetailViewController setImageFromUser:image];
    [setDetailViewController setPiclineObject:piclineObject];
    [self.navigationController pushViewController:setDetailViewController animated:YES];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self presentModalViewController:setDetailViewController animated:YES];
}

- (void)viewDidUnload
{
    [self setPictureTableView:nil];
    [super viewDidUnload];
    NSLog(@"unload");
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PictureViewCell";
    
    PictureViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[PictureViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (!self.detailViewController) {
 self.detailViewController = [[[piclineDetailViewController alloc] initWithNibName:@"piclineDetailViewController" bundle:nil] autorelease];
 }
 NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
 self.detailViewController.detailItem = object;
 [self.navigationController pushViewController:self.detailViewController animated:YES];
 }
 */
#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        NSLog(@"Returning the same result");
        return _fetchedResultsController;
    }
    
    Line *currentLine = piclineObject;
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Picture" inManagedObjectContext:app.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // limit to those entities that belong to the particular item
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"lines.name like '%@'",currentLine.name]];
    [fetchRequest setPredicate:predicate];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO] autorelease];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    
    NSString *cacheNameDetail = @"Detail";
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:app.managedObjectContext sectionNameKeyPath:nil cacheName:cacheNameDetail] autorelease];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    NSLog(@"did change Object");
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

- (void)configureCell:(PictureViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [[cell titleLabel]setText:[[object valueForKey:@"name"] description]];
    [[cell detailsLabel]setText:[[object valueForKey:@"detail"] description]];
    [[cell dateLabel]setText:[[object valueForKey:@"timeStamp"] description]];
    NSString *emoname = [NSString stringWithFormat:@"%@",[[object valueForKey:@"emoticon"] description]];
    UIImage *image = [UIImage imageNamed:emoname];
    [[cell emoticonImage]setImage:image];
    UIImage *imageMain = [[ImageStore sharedStore]imageForKey:[[object valueForKey:@"pictureId"] description]];
    [[cell mainImage]setImage:imageMain];                              
}

- (void)dealloc {
    [pictureTableView release];
    [super dealloc];
}
@end
