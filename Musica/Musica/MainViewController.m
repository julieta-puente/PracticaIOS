//
//  MainViewController.m
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "MainViewController.h"
#import "GroupViewController.h"
#import "AlbumViewController.h"
#import "SongViewController.h"


@interface MainViewController (){
    MusicLibrary * _music;
}

@end

@implementation MainViewController

@synthesize music=_music;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.music= [[[MusicLibrary alloc]init]autorelease];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"Menu";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushAlbumViewController:(UIButton *)sender {
    AlbumViewController * albumVC= [[[AlbumViewController alloc]initWithNibName:nil bundle:nil withLibrary: self.music]autorelease];
    [self.navigationController pushViewController:albumVC animated:YES];
}

- (IBAction)pushGroupViewController:(UIButton *)sender {
    GroupViewController * groupVC= [[[GroupViewController alloc]initWithNibName:nil bundle:nil withLibrary:self.music]autorelease];
    [self.navigationController pushViewController:groupVC animated:YES];
}

- (IBAction)pushSongViewController:(UIButton *)sender {
    SongViewController * songVC= [[[SongViewController alloc]initWithNibName:nil bundle:nil withLibrary: self.music]autorelease];
    [self.navigationController pushViewController:songVC animated:YES];
}
@end
