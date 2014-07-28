//
//  AlbumDetailViewController.m
//  Musica
//
//  Created by Julieta Puente on 23/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "AlbumDetailViewController.h"

@interface AlbumDetailViewController ()
@property (retain, nonatomic) UIImage * image;
@property (copy, nonatomic) NSString * name;
@property (copy, nonatomic) NSString * group;
@property (copy, nonatomic) NSString * year;
@end

@implementation AlbumDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withImage: (UIImage *) image withName: (NSString *) name withGroup: (NSString *) group withYear: (NSString *) year
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.image=image;
        self.name=name;
        self.year=year;
        self.group=group;
    }
    return self;
}

- (void)viewDidLoad
{
    self.imageAlbum.image=self.image;
    self.labelName.text=self.name;
    self.labelYear.text=self.year;
    self.labelGroup.text=self.group;

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_imageAlbum release];
    [_labelName release];
    [_labelGroup release];
    [_labelYear release];
    [_name release];
    [_group release];
    [_year release];
    [_image release];
    [super dealloc];
}
@end
