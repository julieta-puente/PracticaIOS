//
//  ProductDetailCell.m
//  Musica
//
//  Created by Julieta Puente on 22/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "ProductDetailCell.h"

@implementation ProductDetailCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     
        self= [[NSBundle mainBundle] loadNibNamed:@"CMFGalleryCell" owner:self options:nil][0];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
