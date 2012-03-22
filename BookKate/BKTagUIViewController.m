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
    
    [self attachTapHandler:textBox];
    [self attachTapHandler:textBox2];
}

-(void)attachTapHandler: (id)label
{
    if (label == nil) return;
    
    [label setUserInteractionEnabled: YES];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] 
                                          initWithTarget:self 
                                          action: @selector(labelTap:)];
    [label addGestureRecognizer:tapGesture];
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
