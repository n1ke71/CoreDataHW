//
//  TeacherTableViewController.h
//  CoreDataHW
//
//  Created by Kozaderov Ivan on 14/01/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Teacher+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface TeacherTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSFetchedResultsController<Teacher *> *fetchedResultsController;
@end

NS_ASSUME_NONNULL_END
