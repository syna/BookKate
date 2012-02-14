//
//  TagUIViewController.m
//  BookKate
//
//  Created by Ivan Mochalov on 22.12.11.
//  Copyright (c) 2011 iva-mochalov@yandex.ru. All rights reserved.
//

#import "BKTagUIViewController.h"

@implementation BKTagUIViewController

@synthesize tag;

@synthesize delegate;

-(void)loadView
{
    [super loadView];
    
    if (textBox == nil) return;
    
    [textBox setUserInteractionEnabled: YES];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] 
                                          initWithTarget:self 
                                          action: @selector(labelTap:)];
    [textBox addGestureRecognizer:tapGesture];
}

- (void)labelTap:(UITapGestureRecognizer *)sender
{
    if ([sender state] != UIGestureRecognizerStateEnded || 
        [self delegate] == nil) 
    {
        return;
    }
    
    [[self delegate] clickTextHandler];
}

@end
