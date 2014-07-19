//
//  TDModelController.m
//  ToDo
//
//  Created by admin on 15/07/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "TDModelController.h"


/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */

@interface TDModelController()
@end

@implementation TDModelController

- (id)init
{
    self = [super init];
    if (self) {
        // Create the data model.
    }
    return self;
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    NSString *viewControllerName = nil;

    switch (index) {
        case 0:
            viewControllerName = @"ToDoListViewController";
            break;
        case 1:
            viewControllerName = @"ToDoMainViewController";
            break;
        case 2:
            viewControllerName = @"ToDoListViewController";
            break;
            
        default:
            return nil;
    }
    // Create a new view controller and pass suitable data.
    UIViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:viewControllerName];
    dataViewController.view.tag = index;
    return dataViewController;

}


#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = viewController.view.tag;
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = viewController.view.tag;
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
