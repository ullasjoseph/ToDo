//
//  TDDatePickerView.h
//  ExpenseManager
//
//  Created by admin on 09/07/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DateSelectedBlock)(NSDate *selectedDate);

@interface TDDatePickerView : UIView

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property(readwrite, copy) DateSelectedBlock dateSelectedBlock;

- (IBAction)btnCancelClicked:(id)sender;
- (IBAction)btnDoneClicked:(id)sender;

- (void)showViewInSuperview:(UIView *)superView;

@end
