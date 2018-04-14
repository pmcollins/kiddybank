//
//  ModelManager.m
//  Tabby
//
//  Created by Pablo Collins on 5/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ModelManager.h"


@implementation ModelManager

+ (ModelManager *)sharedInstance {
    static ModelManager *me;
    if (me == nil) {
        me = [[self alloc] init];
    }
    return me;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    NSURL *storeUrl = [NSURL fileURLWithPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
                                              stringByAppendingPathComponent:@"model.sqlite"]];
    NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    return persistentStoreCoordinator;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];    
    return managedObjectModel;
}

- (void)save {
    NSError *e;
    BOOL ok = [[self managedObjectContext] save:&e];
    if (!ok) {
        NSLog(@"NSManagedObject: %@", e);
    }
}

- (void)delete:(NSManagedObject *)managedObject {
    [[self managedObjectContext] deleteObject:managedObject];
    [self save];
}

- (NSArray *)findAll:(NSString *)name {
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:name inManagedObjectContext:[self managedObjectContext]];
    [req setEntity:entity];
    NSError *e;
    NSArray *out = [[self managedObjectContext] executeFetchRequest:req error:&e];
    return out;
}

@end
