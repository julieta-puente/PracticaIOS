//
//  AlbumViewController.h
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicLibrary.h"

@interface AlbumViewController : UIViewController 

@property (strong, nonatomic) IBOutlet UITextField * nameTextField;
@property (strong, nonatomic) IBOutlet UITextField * yearTextField;
@property (strong, nonatomic) IBOutlet UIPickerView * groupPickerView;
@property (strong, nonatomic) IBOutlet UIScrollView * albumScrollView;
@property (strong, nonatomic) IBOutlet UIView * insideView;

@property (strong, nonatomic) IBOutlet UIPickerView *albumImagePickerView;
@property (strong, nonatomic) IBOutlet UIImageView *albumImageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withLibrary: (MusicLibrary*) music;
- (IBAction)save:(id)sender;

@end
