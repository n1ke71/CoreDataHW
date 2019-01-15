//
//  CourseDetailTableViewController.h
//  CoreDataHW
//
//  Created by Kozaderov Ivan on 05/01/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Course+CoreDataClass.h"

typedef enum {
    DetailSelectionTypeNone,
    DetailSelectionTypeUser,
    DetailSelectionTypeMentor
} DetailSelectionType;

NS_ASSUME_NONNULL_BEGIN

@interface CourseDetailTableViewController : UITableViewController<UITextFieldDelegate>
@property (strong, nonatomic) Course* course;
@property (assign, nonatomic) DetailSelectionType selectionType;
@end

NS_ASSUME_NONNULL_END
