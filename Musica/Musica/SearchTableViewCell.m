//
//  SearchTableViewCell.m
//  Musica
//
//  Created by Julieta Puente on 08/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "SearchTableViewCell.h"
@interface SearchTableViewCell ()
@property (strong,nonatomic) UIActivityIndicatorView * spinner;
@end
@implementation SearchTableViewCell

- (void)awakeFromNib
{
    self.imageService = [[FetchImageService alloc]init];
    self.imageService.delegate=self;
    self.spinner= [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.spinner.center = CGPointMake(self.imageView.center.x +270,self.imageView.center.y+30);
    [[self contentView] addSubview:self.spinner];
    [self.spinner startAnimating];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) loadImage:(NSData *) data {
    self.imageViewSearch.image= [UIImage imageWithData:data];
    [self.spinner stopAnimating];
}

-(void) noImageFound{
    self.imageViewSearch.image = [UIImage imageNamed:@"noimage.jpg"];
     [self.spinner stopAnimating];
}

@end
