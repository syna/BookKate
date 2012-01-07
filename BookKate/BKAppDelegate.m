//
//  BKAppDelegate.m
//  BookKate
//
//  Created by Ivan Mochalov on 10.12.11.
//  Copyright (c) 2011 iva-mochalov@yandex.ru. All rights reserved.
//

#import "BKAppDelegate.h"
#import "BKTagUIViewController.h"

@implementation BKAppDelegate

@synthesize window = _window;

- (id)init {
    self = [super init];
    if (self != nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"background" ofType:@"m4a"];
        _newAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    }
    return self;
}

- (void)initalizeRootViewController {
    
    _rootController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    [_rootController setDelegate: self];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    
    BKTagUIViewController *initViewController = [storyboard instantiateViewControllerWithIdentifier:@"ctrPage_0"];
    [initViewController setTag: @"ctrPage_0"];
    NSArray *viewControllers = [NSArray arrayWithObjects:
                                initViewController, 
                                nil];
    [_rootController setViewControllers:viewControllers 
                              direction:UIPageViewControllerNavigationDirectionForward 
                               animated:NO 
                             completion:NULL];
    [_rootController setDataSource:self];
}

- (void)initalizeWindow {
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_window setBackgroundColor: [UIColor whiteColor]];
    [_window addSubview:_rootController.view];
    [_window makeKeyAndVisible];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    //[_newAudio play];
    
    [self initalizeRootViewController];
    
    [self initalizeWindow];
    
    return YES;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    return [BKAppDelegate getNextViewController:viewController:TRUE:10];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    return [BKAppDelegate getNextViewController:viewController:FALSE:10];
}

+ (UIViewController *)getNextViewController:(UIViewController *)currentViewController
                                           : (BOOL)forward
                                           : (int) maxCount
{
    NSString *currentIdentifier = [(BKTagUIViewController *)currentViewController tag];
    NSArray *arr = [currentIdentifier componentsSeparatedByString:@"_"];
    if (arr != nil && [arr count] > 0)
    {
        NSInteger index = [[arr objectAtIndex:[arr count] - 1] integerValue];
        if ((forward ? index < 10 : index > 0))
        {
            if (forward) index++;
            else index--;
            NSString *nextIdetifier = [NSString stringWithFormat:@"ctrPage_%d", index];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            BKTagUIViewController *res = [storyboard instantiateViewControllerWithIdentifier:nextIdetifier];
            [res setTag:nextIdetifier];
            return res;
        }
        /*else if (forward && index == 10)
        {
            NSString *nextIdetifier = @"ctrPage_0";
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            BKTagUIViewController *res = [storyboard instantiateViewControllerWithIdentifier:nextIdetifier];
            [res setTag:nextIdetifier];
            return res;
        }*/
    }
    return nil;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
