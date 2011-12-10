//
//  BKModelController.m
//  BookKate
//
//  Created by Ivan Mochalov on 10.12.11.
//  Copyright (c) 2011 iva-mochalov@yandex.ru. All rights reserved.
//

#import "BKModelController.h"

#import "BKDataViewController.h"

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */

@interface BKModelController()
@end

@implementation BKModelController

- (id)init
{
    self = [super init];
    if (self) {
        _pages = [NSArray arrayWithObjects:
                  [BKModelController getFirstPage], 
                  nil];
    }
    return self;
}

+ (BKPageInfo *)getFirstPage {
    NSString *text = @"my text";
    UIImage *img = [UIImage imageNamed:@"page0.jpg"];
    BKPageInfo *res = [[BKPageInfo alloc] initWithText:text andImage:img];
    return res;
}

- (BKDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{   
    // Return the data view controller for the given index.
    if (([_pages count] == 0) || (index >= [_pages count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    BKDataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"BKDataViewController"];
    dataViewController.dataObject = [_pages objectAtIndex:index];
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(BKDataViewController *)viewController
{   
    /*
     Return the index of the given data view controller.
     For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
     */
    return [_pages indexOfObject:viewController.dataObject];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(BKDataViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(BKDataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index >= [_pages count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
