//
//  ModelManager.h
//  Tabby
//
//  Created by Pablo Collins on 5/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ModelManager : NSObject {
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
}

+ (ModelManager *)sharedInstance;

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (NSManagedObjectContext *)managedObjectContext;
- (NSManagedObjectModel *)managedObjectModel;

- (void)save;
- (NSArray *)findAll:(NSString *)name;
- (void)delete:(NSManagedObject *)managedObject;

@end
