//
//  MainViewController.h
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicLibrary.h"

@interface MainViewController : UIViewController

@property (nonatomic,strong) MusicLibrary * music;

- (IBAction)pushAlbumViewController:(UIButton *)sender;
- (IBAction)pushGroupViewController:(UIButton *)sender;
- (IBAction)pushSongViewController:(UIButton *)sender;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withLibrary:(MusicLibrary *)music;

@end
