//
//  SpinnerImageView.m
//  Musica
//
//  Created by Julieta Puente on 25/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "SpinnerImageView.h"
#import "ImageService.h"
@interface SpinnerImageView ()
@property (strong,nonatomic) UIActivityIndicatorView * spinner;
@end
@implementation SpinnerImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     
    }
    return self;
}

-(void) serviceFinishedWithImageData:(NSData *)data forService:(ImageService *)service {
    self.image= [UIImage imageWithData:data];
    [self.spinner stopAnimating];
}

-(void) serviceFinishedWithNoImageData:(ImageService *)service{
    self.image = [UIImage imageNamed:@"noimage.jpg"];
    [self.spinner stopAnimating];
}

-(void) loadSpinner{
    
    self.spinner= [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.spinner.center = CGPointMake(self.frame.size.width/2,self.frame.size.height/2);
    [self addSubview:self.spinner];
    [self.spinner startAnimating];
}

-(UIImage *) getImage{
    return self.image;
}
@end
