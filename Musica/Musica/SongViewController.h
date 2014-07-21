//
//  SongViewController.h
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicLibrary.h"

@interface SongViewController : UIViewController 

@property (strong, nonatomic) IBOutlet UITextField * nameTextField;
@property (strong, nonatomic) IBOutlet UITextField * durationTextField;
@property (strong, nonatomic) IBOutlet UIPickerView * albumPickerView;
@property (strong, nonatomic) IBOutlet UIScrollView * songScrollView;
@property (strong, nonatomic) IBOutlet UIView * insideView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withLibrary: (MusicLibrary*) music;
- (IBAction)save:(id)sender;
@end
