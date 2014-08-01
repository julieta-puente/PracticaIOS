//
//  AlbumDetailViewController.h
//  Musica
//
//  Created by Julieta Puente on 23/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"

@interface AlbumDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *imageAlbum;
@property (strong, nonatomic) IBOutlet UITextField *textFieldName;
@property (strong, nonatomic) IBOutlet UILabel *labelGroup;
@property (strong, nonatomic) IBOutlet UITextField *textFieldYear;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewDetail;
@property (strong, nonatomic) IBOutlet UIView *innerView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withAlbum: (Album *) album withGroup: (NSString *) group;
@end

