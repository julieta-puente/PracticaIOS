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
    self.imageService = [[ImageService alloc]init];
    self.imageService.delegate=self;

}

-(void) completeCellWithContent: (Item *) content {
    [self.labelTitle setText:content.title];
    [self.labelPrice setText:[NSString stringWithFormat:@"$ %@", content.price ]];
    self.itemId=content.itemId;
    [self.imageViewSearch loadSpinner];
    if([content.thumbnail isEqual:@""]){
        [self.imageViewSearch serviceFinishedWithNoImageData:self.imageService];
    }else{        
        NSURL *url = [NSURL URLWithString:content.thumbnail];
        [self.imageService fetchImageWithURL:url forItem:self.itemId];
    }
}

-(void) cancelService{
    [self.imageService cancel];
}

-(void) serviceFinishedWithImageData:(NSData *) data forService:(ImageService *)service {
    [self.imageViewSearch serviceFinishedWithImageData:data forService:service];
    
}

-(void) serviceFinishedWithNoImageData: (ImageService *) service{
    [self.imageViewSearch serviceFinishedWithNoImageData:service];
}

-(void) dealloc{
    [self cancelService];
}
-(void) sacameLaFoto{
    self.imageViewSearch.image=nil;
}
@end
