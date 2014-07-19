//
//  TDMainViewController.h
//  ToDo
//
//  Created by admin on 15/07/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TDTask;

@interface TDMainViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>
{
    NSDateFormatter *dateFormatter;
}
@property (weak, nonatomic) IBOutlet UITextField *txtFieldTitle;
@property (weak, nonatomic) IBOutlet UITextView *txtViewNotes;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;

@property (strong, nonatomic) TDTask *task;

- (IBAction)btnTimeClicked:(id)sender;
- (IBAction)btnResetClicked:(id)sender;
- (IBAction)btnSaveClicked:(id)sender;
- (IBAction)containerViewClciked:(id)sender;

@end
