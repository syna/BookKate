//
//  TagUIViewController.h
//  BookKate
//
//  Created by Ivan Mochalov on 22.12.11.
//  Copyright (c) 2011 iva-mochalov@yandex.ru. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IClickablePageDelegate<NSObject>

-(void)clickTextHandler;

@end

@interface BKTagUIViewController : UIViewController
{
    IBOutlet UILabel *textBox;
    IBOutlet UILabel *textBox2;
}

@property (nonatomic,retain) id tag;

@property (nonatomic,retain) id<IClickablePageDelegate> delegate;

-(void)attachTapHandler: (id)label;
-(void)labelTap:(UITapGestureRecognizer *)sender;

@end
