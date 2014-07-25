//
//  AlbumTableViewCell.m
//  Musica
//
//  Created by Julieta Puente on 21/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "AlbumTableViewCell.h"

@implementation AlbumTableViewCell

- (void)awakeFromNib
{
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_imageViewAlbum release];
    [_labelName release];
    [_labelYear release];
    [_labelGroup release];
    [super dealloc];
}
@end
