//
//  AlbumTableViewCell.h
//  Musica
//
//  Created by Julieta Puente on 21/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView * imageViewAlbum;
@property (strong, nonatomic) IBOutlet UILabel * labelName;
@property (strong, nonatomic) IBOutlet UILabel * labelYear;
@property (strong, nonatomic) IBOutlet UILabel * labelGroup;

@end
