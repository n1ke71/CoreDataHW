//
//  DataManager.h
//  CoreDataHW
//
//  Created by Kozaderov Ivan on 03/12/2018.
//  Copyright © 2018 n1ke71. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

+(DataManager *)sharedManager;
- (NSArray *) getUsersArray;
- (void)saveContext;


@end

NS_ASSUME_NONNULL_END
