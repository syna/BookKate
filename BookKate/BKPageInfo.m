//
//  BKPageInfo.m
//  BookKate
//
//  Created by Ivan Mochalov on 10.12.11.
//  Copyright (c) 2011 iva-mochalov@yandex.ru. All rights reserved.
//

#import "BKPageInfo.h"

@implementation BKPageInfo

- (id)initWithText: (NSString *)text andImage: (UIImage *)image {
    self = [super init];
    if (self != nil) {
        _text = text;
        _img = image;
    }
    return self;
}

- (NSString *)Text {
    return _text;
}

- (UIImage *)Image {
    return _img;
}

@end
