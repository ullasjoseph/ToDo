//
//  TDMainViewController.m
//  ToDo
//
//  Created by admin on 15/07/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "TDMainViewController.h"
#import "TDTask.h"
#import "TDCoredataManager.h"
#import "TDDatePickerView.h"

@interface TDMainViewController ()
@property(nonatomic, strong)TDCoredataManager *coredataManager;
@end

@implementation TDMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, MMM dd yyyy hh:mm a"];//Wed, Dec 14 2011 1:50 PM
    if(!_task)
        _task = [TDTask new];
    _coredataManager = [[TDCoredataManager alloc] init];
    [self loadTaskInView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (int i = 101; i < 105; i++) {
        [self.view viewWithTag:i].layer.cornerRadius = 7;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    _task.title = [textField.text stringByReplacingCharactersInRange:range withString:string];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    _task.notes = [textView.text stringByReplacingCharactersInRange:range withString:text];
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - Utils

- (void)loadTaskInView {
    _txtFieldTitle.text = _task.title;
    _lblTime.text = _task.time ? [dateFormatter stringFromDate:_task.time] : @"Time";
    _txtViewNotes.text = _task.notes;
}

- (BOOL)validate {
    if (_task.title.length == 0) {
        [TDUtils showAlert:@"Enter Title" delegate:self];
        return NO;
    }
    if (!_task.time || _task.time < [NSDate date]) {
        [TDUtils showAlert:@"Enter valid time" delegate:self];
        return NO;
    }
    return YES;
}

- (void)showDatePicker {
    TDDatePickerView *datePicker = [[TDDatePickerView alloc] initWithFrame:self.view.bounds];
    [datePicker setDateSelectedBlock:^(NSDate *selectedDate){
        _task.time = selectedDate;
        [self loadTaskInView];
    }];
    [datePicker showViewInSuperview:self.view];
}

- (NSManagedObject *)getNewTask {
    
    NSManagedObject *data = [TDCoredataManager getCoredataObject];
    [data setValue:_task.title forKey:@"title"];
    [data setValue:_task.time forKey:@"time"];
    [data setValue:_task.notes forKey:@"notes"];
    return data;
}

- (void)resignKeyBoard {
    if([_txtFieldTitle isFirstResponder])
        [_txtFieldTitle resignFirstResponder];
    
    if([_txtViewNotes isFirstResponder])
        [_txtViewNotes resignFirstResponder];
}

- (void)createLocalNotification {
    // Schedule the notification
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil)
        return;
    localNotif.fireDate = _task.time;
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    
	// Notification details
    localNotif.alertBody = [_task title];
	// Set the action button
    localNotif.alertAction = @"View";
    
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
	// Specify custom data for the notification
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
    localNotif.userInfo = infoDict;
    
	// Schedule the notification
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
}

#pragma mark - IBActions

- (IBAction)btnTimeClicked:(id)sender {
    [self resignKeyBoard];
    [self showDatePicker];
}

- (IBAction)btnResetClicked:(id)sender {
    [self resignKeyBoard];
    _task = [[TDTask alloc] init];
    [self loadTaskInView];
}

- (IBAction)btnSaveClicked:(id)sender {
    [self resignKeyBoard];
    if ([self validate]) {
        [TDCoredataManager saveData:[self getNewTask]];
        [TDUtils showAlert:@"Saved" delegate:self];
        [self createLocalNotification];
        _task = [[TDTask alloc] init];
        [self loadTaskInView];
    }
}

- (IBAction)containerViewClciked:(id)sender {
    [self resignKeyBoard];
}

@end
