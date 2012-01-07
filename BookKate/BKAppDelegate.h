//
//  BKAppDelegate.h
//  BookKate
//
//  Created by Ivan Mochalov on 10.12.11.
//  Copyright (c) 2011 iva-mochalov@yandex.ru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface BKAppDelegate : UIResponder <UIApplicationDelegate, UIPageViewControllerDelegate, UIPageViewControllerDataSource> {
@private 
    AVAudioPlayer *_newAudio;
    UIPageViewController *_rootController;
}

@property (strong, nonatomic) UIWindow *window;

+ (UIViewController *)getNextViewController:(UIViewController *)currentViewController
                                           : (BOOL)forward
                                           : (int) maxCount;

@end
