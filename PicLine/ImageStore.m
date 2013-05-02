//
//  BNRImageStore.m
//  Homepwner
//
//  Created by students on 4/4/13.
//  Copyright (c) 2013 irp. All rights reserved.
//

#import "ImageStore.h"

@implementation ImageStore

+(id)allocWithZone:(NSZone *)zone{
    return [self sharedStore];
}

+ (ImageStore *)sharedStore
{
    static ImageStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:NULL]init];
    }
    return sharedStore;
}

- (id)init{
    self = [super init];
    if (self) {
        dictionary = [[NSMutableDictionary alloc]init];
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(clearCache:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

- (void)clearCache: (NSNotification *)note {
    NSLog(@"flushing cache");
    [dictionary removeAllObjects];
}

- (void)setImage:(UIImage *)i forKey:(NSString *)s{
    [dictionary setObject:i forKey:s];
    NSString *imagePath = [self imagePathForKey:s];
    NSData *d = UIImageJPEGRepresentation(i, 0.5);
    [d writeToFile:imagePath atomically:YES];
}

- (void)deleteImageForKey:(NSString *)s
{
    if (!s) {
        return;
    }
    [dictionary removeObjectForKey:s];
    
    NSString *path = [self imagePathForKey:s];
    [[NSFileManager defaultManager]removeItemAtPath:path error:NULL];
    
}
- (UIImage *)imageForKey:(NSString *)s
{
    UIImage *result = [dictionary objectForKey:s];
    if (!result) {
        result = [UIImage imageWithContentsOfFile:[self imagePathForKey:s]];
        if (result) {
            [dictionary setObject:result forKey:s];
        }
        else {
            NSLog(@"Error: unable to find %@", [self imagePathForKey:s]);
        }
    }
    return result;  
}

- (void)delegateImageForKey:(NSString *)s
{
    if (!s) {
        return;
    }
    [dictionary removeObjectForKey:s];
}

- (NSString *)imagePathForKey:(NSString *)key
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:key];
}


@end
