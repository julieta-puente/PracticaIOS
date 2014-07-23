//
//  AlbumTableViewCell.h
//  Musica
//
//  Created by Julieta Puente on 21/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumTableViewCell : UITableViewCell



@property (retain, nonatomic) IBOutlet UIImageView * imageViewAlbum;
@property (retain, nonatomic) IBOutlet UILabel * labelName;
@property (retain, nonatomic) IBOutlet UILabel * labelYear;
@property (retain, nonatomic) IBOutlet UILabel * labelGroup;

@end
