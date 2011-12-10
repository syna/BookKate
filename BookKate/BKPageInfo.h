//
//  BKPageInfo.h
//  BookKate
//
//  Created by Ivan Mochalov on 10.12.11.
//  Copyright (c) 2011 iva-mochalov@yandex.ru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKPageInfo : NSObject {
@private
    NSString *_text;
    UIImage *_img;
    //Sound *_sound;
}

- (id)initWithText: (NSString *)text andImage: (UIImage *)image;
@property (readonly) NSString *Text;
@property (readonly) UIImage *Image;
@end
