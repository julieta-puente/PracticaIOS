//
//  KeyboardToolbar.m
//  Musica
//
//  Created by Julieta Puente on 13/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "KeyboardToolbar.h"

@implementation KeyboardToolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tintColor = [UIColor lightGrayColor];
        self.translucent = YES;
        UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        self.okButton = [[UIBarButtonItem alloc]initWithTitle:@"OK" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.okButton.tintColor= [UIColor blueColor];
        self.items =   @[flexibleSpaceLeft, self.okButton];
    }
    return self;
}

@end
