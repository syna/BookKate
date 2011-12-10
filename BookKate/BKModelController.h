//
//  BKModelController.h
//  BookKate
//
//  Created by Ivan Mochalov on 10.12.11.
//  Copyright (c) 2011 iva-mochalov@yandex.ru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BKPageInfo.h"

@class BKDataViewController;

@interface BKModelController : NSObject <UIPageViewControllerDataSource> {
@private 
    NSArray *_pages;
}
- (BKDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(BKDataViewController *)viewController;

+ (BKPageInfo *)getFirstPage;
+ (BKPageInfo *)getSecondPage;
+ (BKPageInfo *)getThirdPage;
+ (BKPageInfo *)getFourthPage;
+ (BKPageInfo *)getFifthPage;
+ (BKPageInfo *)getSixthPage;
+ (BKPageInfo *)getSeventhPage;
+ (BKPageInfo *)getEighthPage;
+ (BKPageInfo *)getNinthPage;
+ (BKPageInfo *)getTenthPage;
+ (BKPageInfo *)getEleventhPage;

@end
