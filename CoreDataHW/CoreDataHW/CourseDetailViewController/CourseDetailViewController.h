//
//  CourseDetailViewController.h
//  CoreDataHW
//
//  Created by Kozaderov Ivan on 24/12/2018.
//  Copyright © 2018 n1ke71. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Course+CoreDataClass.h"

typedef enum {
    CourseAttributeCourseName,
    CourseAttributeSubject,
    CourseAttributeSector,
    CourseAttributeMentor
} CourseAttribute;

NS_ASSUME_NONNULL_BEGIN

@interface CourseDetailViewController : UITableViewController<UITextFieldDelegate>

@property (strong, nonatomic) Course* course;
@property (assign, nonatomic) CourseAttribute courseAttribute;

@end

NS_ASSUME_NONNULL_END
