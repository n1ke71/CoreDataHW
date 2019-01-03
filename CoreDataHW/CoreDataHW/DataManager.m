//
//  DataManager.m
//  CoreDataHW
//
//  Created by Kozaderov Ivan on 03/12/2018.
//  Copyright © 2018 n1ke71. All rights reserved.
//

#import "DataManager.h"
#import "User+CoreDataClass.h"
#import "Course+CoreDataClass.h"
#import "Utils.h"
@implementation DataManager

+(DataManager *)sharedManager{
    
    static DataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataManager alloc]init];
    });
    
return manager;
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"CoreDataHW"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

- (void)deleteAllEntities:(NSString *)nameEntity
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:nameEntity];
    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError *error;
    NSArray *fetchedObjects = [self.persistentContainer.viewContext executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *object in fetchedObjects)
    {
        [self.persistentContainer.viewContext deleteObject:object];
    }
    
    error = nil;
    [self.persistentContainer.viewContext save:&error];
}

- (void) createRandomUser{
   
        User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                                   inManagedObjectContext:self.persistentContainer.viewContext];
    
        user.firstName = firstNames[arc4random_uniform(50)];
        user.lastName = lastNames[arc4random_uniform(50)];
        user.email = adresses[arc4random_uniform(50)];
        [self saveContext];
}

- (void) createRandomCourse{
    
    Course *course = [NSEntityDescription insertNewObjectForEntityForName:@"Course"
                                               inManagedObjectContext:self.persistentContainer.viewContext];
    uint32_t randomNumber = arc4random_uniform(100) % 50;
    randomTechCourseName = arc4random_uniform(5) + 1;
    randomHumCourseName = arc4random_uniform(5) + 1;;
    course.courseName = randomNumber ? nameOfTechCourse(randomTechCourseName):nameOfHumCourse(randomHumCourseName);
    course.mentor = [NSString stringWithFormat:@"%@ %@",firstNames[arc4random_uniform(50)],lastNames[arc4random_uniform(50)]];
    course.sector = randomNumber ? @"Technical Sector":@"Humanitarian Sector";
    course.subject = randomNumber ? technicalSubjects[arc4random_uniform(8)]:humanitarianSubjects[arc4random_uniform(8)]; 
    [self saveContext];
}
@end
