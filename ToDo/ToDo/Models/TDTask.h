//
//  TDTask.h
//  ToDo
//
//  Created by admin on 15/07/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDTask : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSDate *time;
@property (strong, nonatomic) NSString *notes;

@end
