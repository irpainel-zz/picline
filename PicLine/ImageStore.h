//
//  BNRImageStore.h
//  Homepwner
//
//  Created by students on 4/4/13.
//  Copyright (c) 2013 irp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageStore : NSObject
{
    NSMutableDictionary *dictionary;
}
+ (ImageStore *)sharedStore;

- (void)setImage:(UIImage *)i forKey:(NSString *)s;
- (UIImage *)imageForKey:(NSString *)s;
- (void)delegateImageForKey:(NSString *)s;
- (NSString *)imagePathForKey: (NSString *)key;
- (void)deleteImageForKey:(NSString *)s;



@end
