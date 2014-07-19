//
//  TDToDoListTableViewController.h
//  ToDo
//
//  Created by admin on 15/07/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDToDoListTableViewController : UITableViewController
{
    NSDateFormatter *dateFormatter;
    int sections;
}
@property (strong, nonatomic) id dataObject;
@end
