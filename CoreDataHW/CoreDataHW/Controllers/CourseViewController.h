//
//  CourseViewController.h
//  CoreDataHW
//
//  Created by Kozaderov Ivan on 24/12/2018.
//  Copyright © 2018 n1ke71. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Course+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController<Course *> *fetchedResultsController;
@property (strong, nonatomic) NSPersistentContainer *persistentContainer;

@end

NS_ASSUME_NONNULL_END
