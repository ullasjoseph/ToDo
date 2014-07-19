//
//  TDCoredataManager.h
//  ExpenseManager
//
//  Created by admin on 11/07/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface TDCoredataManager : NSObject

+ (NSManagedObject *)getCoredataObject;
+ (void)saveData:(NSManagedObject *)newTask;
+ (NSArray *)getAllExpenses:(NSPredicate *)predicate;
//+ (NSNumber *)getSumOfExpense:(NSPredicate *)predicate;
@end