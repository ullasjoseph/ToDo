//
//  TDDatePickerView.m
//  ExpenseManager
//
//  Created by admin on 09/07/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "TDDatePickerView.h"

@implementation TDDatePickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"TDDatePickerView" owner:self options:nil] objectAtIndex:0];
        [_datePicker setMinimumDate:[NSDate date]];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    [[[self viewWithTag:1] layer] setCornerRadius:10];
    [[[self viewWithTag:2] layer] setCornerRadius:10];
    [_datePicker setMinimumDate:[NSDate date]];
}


#pragma mark - IBActions

- (IBAction)btnCancelClicked:(id)sender {
    [self removeViewFromSuperview];
}

- (IBAction)btnDoneClicked:(id)sender {
    if (_dateSelectedBlock)
        _dateSelectedBlock([_datePicker date]);
    [self removeViewFromSuperview];

}


#pragma mark - Utils 

- (void)showViewInSuperview:(UIView *)superView {
    [superView addSubview:self];
    [UIView animateWithDuration: 0.3
                     animations:^{
                         self.alpha = 0.0;
                         self.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                     }];
}

- (void)removeViewFromSuperview {
    [UIView animateWithDuration: 0.3
                     animations:^{
                         self.alpha = 1.0;
                         self.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

@end
