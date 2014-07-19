//
//  TDUtils.m
//  ToDo
//
//  Created by admin on 15/07/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "TDUtils.h"

@implementation TDUtils

+ (void)showAlert:(NSString *)msg delegate:(id)delegate {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:msg delegate:delegate cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

@end
