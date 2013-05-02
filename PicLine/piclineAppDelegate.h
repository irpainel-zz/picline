//
//  piclineAppDelegate.h
//  PicLine
//
//  Created by students on 4/12/13.
//  Copyright (c) 2013 Painelli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface piclineAppDelegate : UIResponder <UIApplicationDelegate>{
    // Core Data stuff
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (strong, nonatomic) UINavigationController *navigationController;

@end
