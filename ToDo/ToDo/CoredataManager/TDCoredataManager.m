//
//  TDCoredataManager.m
//  ExpenseManager
//
//  Created by admin on 11/07/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "TDCoredataManager.h"
#import "TDAppDelegate.h"

@interface TDCoredataManager()

@end

@implementation TDCoredataManager

static NSManagedObjectContext *context;

+ (NSManagedObject *)getCoredataObject {
    
    NSManagedObject *newExpense = [NSEntityDescription insertNewObjectForEntityForName:@"Task"
                                                                inManagedObjectContext:self.context];
    return newExpense;
}

+ (NSManagedObjectContext *)context {
    if (!context) {
        TDAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        context = [appDelegate managedObjectContext];
    }
    return context;
}

+ (void)saveData:(NSManagedObject *)newTask {
    NSError *error;
    [self.context save:&error];
}

+ (NSArray *)getAllExpenses:(NSPredicate *)predicate {
    
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"Task"
                inManagedObjectContext:self.context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    if (predicate) {
        [request setPredicate:predicate];
    }
    
    NSError *error;
    NSArray *objects = [self.context executeFetchRequest:request
                                              error:&error];
    
    if ([objects count] == 0) {
        
    } else {
        return objects;
    }
    return nil;
}

//+ (NSNumber *)getSumOfExpense:(NSPredicate *)predicate {
//    
//    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ToDo"];
//    fetchRequest.resultType = NSDictionaryResultType;
//    NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
//    expressionDescription.name = @"sumOfExpense";
//    expressionDescription.expression = [NSExpression expressionForKeyPath:@"@sum.amount"];
//    expressionDescription.expressionResultType = NSDecimalAttributeType;
//    
//    fetchRequest.propertiesToFetch = @[expressionDescription];
//    if (predicate) {
//        [fetchRequest setPredicate:predicate];
//    }
//    NSError *error = nil;
//    NSArray *result = [self.context executeFetchRequest:fetchRequest error:&error];
//    if (result == nil)
//    {
//        NSLog(@"Error: %@", error);
//    }
//    else
//    {
//        return [[result objectAtIndex:0] objectForKey:@"sumOfExpense"];
//    }
//    return nil;
//}

@end
