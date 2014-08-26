//
//  SearchTableViewCell.m
//  Musica
//
//  Created by Julieta Puente on 08/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "SearchTableViewCell.h"

//@interface SearchTableViewCell ()
//@property (strong,nonatomic) UIActivityIndicatorView * spinner;
//@end
@implementation SearchTableViewCell

- (void)awakeFromNib
{
    self.imageViewSearch.image=nil;
    self.imageService = [[FetchImageService alloc]init];
    self.imageService.delegate=self;

}

-(void) completeCellWithContent: (SearchedObject *) content {
    [self.labelTitle setText:content.title];
    [self.labelPrice setText:[NSString stringWithFormat:@"$ %@", content.price ]];
    self.itemId=content.id;
    [self.imageViewSearch loadSpinner];
    NSURL *url = [NSURL URLWithString:content.thumbnail];
    [self.imageService fetchImageWithURL:url forItem:self.itemId];
}

-(void) cancelService{
    [self.imageService cancel];
}

-(void) loadImage:(NSData *) data {
    [self.imageViewSearch loadImage:data];
    
}

-(void) noImageFound{
    [self.imageViewSearch noImageFound];
}

-(void) dealloc{
    [self cancelService];
}

@end
