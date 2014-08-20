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
    self.imageView.image=nil;
    self.imageService = [[FetchImageService alloc]init];
    self.imageService.delegate=self;
    self.spinner= [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.spinner.center = CGPointMake(self.imageView.center.x +270,self.imageView.center.y+30);
    [[self contentView] addSubview:self.spinner];
    [self.spinner startAnimating];
}

-(void) completeCellWithContent: (SearchedObject *) content {
    [self.labelTitle setText:content.title];
    [self.labelPrice setText:[NSString stringWithFormat:@"$ %@", content.price ]];
    self.itemId=content.id;
    NSURL *url = [NSURL URLWithString:content.thumbnail];
    [self.imageService fetchImageWithURL:url forItem:self.itemId];
}

-(void) cancelService{
    [self.imageService cancel];
}

-(void) loadImage:(NSData *) data {
    self.imageViewSearch.image= [UIImage imageWithData:data];
    [self.spinner stopAnimating];
}

-(void) noImageFound{
    self.imageViewSearch.image = [UIImage imageNamed:@"noimage.jpg"];
     [self.spinner stopAnimating];
}

-(void) dealloc{
    [self cancelService];
}

@end
