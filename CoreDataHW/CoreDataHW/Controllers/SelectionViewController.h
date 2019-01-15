//
//  SelectionViewController.h
//  CoreDataHW
//
//  Created by Kozaderov Ivan on 05/01/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Course+CoreDataClass.h"
#import "User+CoreDataClass.h"

typedef enum {
   SelectionTypeNone,
   SelectionTypeUser,
   SelectionTypeMentor
} SelectionType;

NS_ASSUME_NONNULL_BEGIN

@protocol SelectionViewControllerDelegate;

@interface SelectionViewController : UITableViewController<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController<User *> *fetchedResultsController;
@property (strong, nonatomic) Course* currentCourse;
@property (assign, nonatomic) SelectionType selectionType;
@property (weak,nonatomic) id <SelectionViewControllerDelegate> delegate;

- (IBAction)doneAction:(UIBarButtonItem *)sender;

@end

@protocol SelectionViewControllerDelegate
@optional
- (void) didSelectMentor:(User *)user;
- (void) didSelectUser:(NSMutableArray<User*> *)users;
@end
NS_ASSUME_NONNULL_END
