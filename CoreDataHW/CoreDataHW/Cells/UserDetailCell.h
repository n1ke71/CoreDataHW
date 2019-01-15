//
//  UserDetailCell.h
//  CoreDataHW
//
//  Created by Kozaderov Ivan on 14/12/2018.
//  Copyright © 2018 n1ke71. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *detailTextField;
@property (weak, nonatomic) IBOutlet UILabel *detailText;

@end

NS_ASSUME_NONNULL_END
