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

@property (retain, nonatomic) IBOutlet UITextField * nameTextField;
@property (retain, nonatomic) IBOutlet UITextField * yearTextField;
@property (retain, nonatomic) IBOutlet UIPickerView * groupPickerView;
@property (retain, nonatomic) IBOutlet UIScrollView * albumScrollView;
@property (retain, nonatomic) IBOutlet UIView * insideView;

@property (retain, nonatomic) IBOutlet UIPickerView *albumImagePickerView;
@property (retain, nonatomic) IBOutlet UIImageView *albumImageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withLibrary: (MusicLibrary*) music;
- (IBAction)save:(id)sender;

@end
