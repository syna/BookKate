//
//  BKDataViewController.h
//  BookKate
//
//  Created by Ivan Mochalov on 10.12.11.
//  Copyright (c) 2011 iva-mochalov@yandex.ru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BKPageInfo.h"

@interface BKDataViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) IBOutlet UIImageView *dataBackgroundImage;
@property (strong, nonatomic) BKPageInfo *dataObject;
@end
