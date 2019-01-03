//
//  UserViewController.h
//  CoreDataHW
//
//  Created by Kozaderov Ivan on 20/12/2018.
//  Copyright © 2018 n1ke71. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "User+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController<User *> *fetchedResultsController;
@property (strong, nonatomic) NSPersistentContainer *persistentContainer;

@end

NS_ASSUME_NONNULL_END
