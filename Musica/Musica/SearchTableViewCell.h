//
//  SearchTableViewCell.h
//  Musica
//
//  Created by Julieta Puente on 08/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageService.h"
#import "Item.h"
#import "SpinnerImageView.h"

@interface SearchTableViewCell : UITableViewCell <ImageResponse>
@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) IBOutlet UILabel *labelPrice;
@property (strong, nonatomic) IBOutlet SpinnerImageView *imageViewSearch;
@property (copy,nonatomic) NSString * itemId;
@property (copy,nonatomic) NSString * permalink;
@property (strong,nonatomic) ImageService * imageService;

-(void) completeCellWithContent: (Item *) content ;
-(void) cancelService;


@end
