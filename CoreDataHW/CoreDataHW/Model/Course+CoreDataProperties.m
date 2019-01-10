//
//  Course+CoreDataProperties.m
//  CoreDataHW
//
//  Created by Kozaderov Ivan on 05/01/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//
//

#import "Course+CoreDataProperties.h"

@implementation Course (CoreDataProperties)

+ (NSFetchRequest<Course *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Course"];
}

@dynamic courseName;
@dynamic mentor;
@dynamic sector;
@dynamic subject;
@dynamic users;

@end
