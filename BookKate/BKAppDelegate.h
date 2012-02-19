//
//  BKAppDelegate.h
//  BookKate
//
//  Created by Ivan Mochalov on 10.12.11.
//  Copyright (c) 2011 iva-mochalov@yandex.ru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "BKTagUIViewController.h"

@interface BKAppDelegate : UIResponder <UIApplicationDelegate, UIPageViewControllerDelegate, UIPageViewControllerDataSource, IClickablePageDelegate> {
@private 
    AVAudioPlayer *_newAudio;
    AVAudioPlayer *_backgroundAudio;
    UIPageViewController *_rootController;
}

@property (strong, nonatomic) UIWindow *window;

- (UIViewController *)getNextViewController:(UIViewController *)currentViewController
                                           : (BOOL)forward
                                           : (int) maxCount;
-(void)startReadCurrentPage;

-(void)stopReadPage;

-(void)startReadPage: (NSInteger) pageIndex;

-(void)openFirstPage;

-(void)openFirstPageHandler:(id)sender;

+ (int)calculateCurrentIndex:(id)viewController;

-(void)startMusic;

-(void)stopMusic;

@end
