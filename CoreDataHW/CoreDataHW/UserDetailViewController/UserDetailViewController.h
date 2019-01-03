//
//  DetailViewController.h
//  CoreDataHW
//
//  Created by Kozaderov Ivan on 07/12/2018.
//  Copyright © 2018 n1ke71. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "User+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
   UsersAttributeFirstName,
   UsersAttributeLastName,
   UsersAttributeEmail
} UsersAttribute;

@interface UserDetailViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) User* user;
@property (assign, nonatomic) UsersAttribute usersAttribute;

@end

NS_ASSUME_NONNULL_END
