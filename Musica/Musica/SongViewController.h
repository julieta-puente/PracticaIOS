//
//  SongViewController.h
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicLibrary.h"

@interface SongViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource,UITextViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField * nameTextField;
@property (strong, nonatomic) IBOutlet UITextField * durationTextField;
@property (strong, nonatomic) IBOutlet UIPickerView * albumPickerView;
@property (copy, nonatomic) NSString * pickerSelection;
@property (strong,nonatomic) MusicLibrary * music;
@property (strong, nonatomic) IBOutlet UIScrollView * songScrollView;
@property (strong, nonatomic) IBOutlet UIView * insideView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withLibrary: (MusicLibrary*) music;
- (IBAction)save:(UIButton *)sender;
@end
