//
//  SearchTableViewCell.h
//  Musica
//
//  Created by Julieta Puente on 08/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FetchImageService.h"
#import "Item.h"
#import "SpinnerImageView.h"

@interface SearchTableViewCell : UITableViewCell <FetchImageResponse>
@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) IBOutlet UILabel *labelPrice;
@property (strong, nonatomic) IBOutlet SpinnerImageView *imageViewSearch;
@property (copy,nonatomic) NSString * itemId;
@property (copy,nonatomic) NSString * permalink;
@property (strong,nonatomic) FetchImageService * imageService;

-(void) completeCellWithContent: (Item *) content ;
-(void) cancelService;


@end
