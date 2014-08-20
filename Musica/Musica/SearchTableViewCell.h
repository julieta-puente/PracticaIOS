//
//  SearchTableViewCell.h
//  Musica
//
//  Created by Julieta Puente on 08/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FetchImageService.h"
#import "SearchedObject.h"
@interface SearchTableViewCell : UITableViewCell <FetchImageResponse>
@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) IBOutlet UILabel *labelPrice;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewSearch;
@property (strong,nonatomic) NSString * itemId;
@property (strong,nonatomic) FetchImageService * imageService;

-(void) completeCellWithContent: (SearchedObject *) content ;
-(void) cancelService;


@end
