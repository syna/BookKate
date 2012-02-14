//
//  BKAppDelegate.m
//  BookKate
//
//  Created by Ivan Mochalov on 10.12.11.
//  Copyright (c) 2011 iva-mochalov@yandex.ru. All rights reserved.
//

#import "BKAppDelegate.h"

@implementation BKAppDelegate

@synthesize window = _window;

/*- (id)init {
    self = [super init];
    if (self != nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"background" ofType:@"m4a"];
        _newAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    }
    return self;
}*/

- (void)initalizeRootViewController {
    
    _rootController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    [_rootController setDelegate: self];
    
    [_rootController setDataSource:self];
    
    [self openFirstPage];
}

- (void)openFirstPage
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    BKTagUIViewController *initViewController = [storyboard instantiateViewControllerWithIdentifier:@"ctrPage_0"];
    [initViewController setTag: @"ctrPage_0"];
    [initViewController setDelegate:self];
    NSArray *viewControllers = [NSArray arrayWithObjects:
                                initViewController, 
                                nil];
    [_rootController setViewControllers:viewControllers 
                              direction:UIPageViewControllerNavigationDirectionForward 
                               animated:NO 
                             completion:NULL];
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
    
    [self startReadPage:0];
    
    return YES;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed;
{    
    [self stopReadPage];
    
    [self startReadCurrentPage];
}

- (void)startReadCurrentPage
{
    NSInteger index = [BKAppDelegate calculateCurrentIndex: [[_rootController viewControllers] objectAtIndex:0]];
    [self startReadPage:index];
}

- (void)startReadPage: (NSInteger) pageIndex
{
    NSString *fileName = @"background";
    NSString *fileType = @"m4a";
    
    fileName = [NSString stringWithFormat: @"page_%d", pageIndex];
    fileType = @"mp3";
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
    _newAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    [_newAudio play];
    
}

- (void)stopReadPage
{
    if (_newAudio != nil)
        [_newAudio stop];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    return [self getNextViewController:viewController:TRUE:10];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    return [self getNextViewController:viewController:FALSE:10];
}

+ (int)calculateCurrentIndex:(id)viewController
{
    NSString *currentIdentifier = [(BKTagUIViewController *)viewController tag];
    NSArray *arr = [currentIdentifier componentsSeparatedByString:@"_"];
    if (arr != nil && [arr count] > 0)
    {
        return [[arr objectAtIndex:[arr count] - 1] integerValue];
    }
    return -1;
}

- (UIViewController *)getNextViewController:(UIViewController *)currentViewController
                                           : (BOOL)forward
                                           : (int) maxCount
{
    NSInteger index = [BKAppDelegate calculateCurrentIndex: currentViewController];
    if (index > -1)
    {
        if ((forward ? index < maxCount : index > 0))
        {
            if (forward) index++;
            else index--;
            NSString *nextIdetifier = [NSString stringWithFormat:@"ctrPage_%d", index];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            BKTagUIViewController *res = [storyboard instantiateViewControllerWithIdentifier:nextIdetifier];
            [res setTag:nextIdetifier];
            [res setDelegate:self];
            
            if (index == maxCount)
            {
                UIButton *btnExit = (UIButton *)[[res view] viewWithTag:1];
                [btnExit addTarget:self action:@selector(openFirstPageHandler:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            return res;
        }
    }
    return nil;
}

- (void)openFirstPageHandler:(id)sender
{
    [self stopReadPage];
    
    [self openFirstPage];
    
    [self startReadCurrentPage];
}

- (void)clickTextHandler
{
    [self stopReadPage];
    
    [self startReadCurrentPage];
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
    [self stopReadPage];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
    [self startReadCurrentPage];
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
