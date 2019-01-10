//
//  Course+CoreDataProperties.h
//  CoreDataHW
//
//  Created by Kozaderov Ivan on 05/01/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//
//

#import "Course+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Course (CoreDataProperties)

+ (NSFetchRequest<Course *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *courseName;
@property (nullable, nonatomic, copy) NSString *mentor;
@property (nullable, nonatomic, copy) NSString *sector;
@property (nullable, nonatomic, copy) NSString *subject;
@property (nullable, nonatomic, retain) NSSet<User *> *users;

@end

@interface Course (CoreDataGeneratedAccessors)

- (void)addUsersObject:(User *)value;
- (void)removeUsersObject:(User *)value;
- (void)addUsers:(NSSet<User *> *)values;
- (void)removeUsers:(NSSet<User *> *)values;

@end

NS_ASSUME_NONNULL_END
