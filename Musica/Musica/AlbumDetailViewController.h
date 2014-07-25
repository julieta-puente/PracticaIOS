//
//  AlbumDetailViewController.h
//  Musica
//
//  Created by Julieta Puente on 23/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumDetailViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIImageView *imageAlbum;
@property (retain, nonatomic) IBOutlet UILabel *labelName;
@property (retain, nonatomic) IBOutlet UILabel *labelGroup;
@property (retain, nonatomic) IBOutlet UILabel *labelYear;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withImage: (UIImage *) image withName: (NSString *) name withGroup: (NSString *) group withYear: (NSString *) year;
@end
