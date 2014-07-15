//
//  SongViewController.h
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicLibrary.h"

@interface SongViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource,UITextViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *NameTextField;
@property (strong, nonatomic) IBOutlet UITextField *DurationTextField;
@property (strong, nonatomic) IBOutlet UIPickerView *AlbumPickerView;
@property (copy, nonatomic) NSString * pickerSelection;
@property (strong,nonatomic) MusicLibrary * music;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withLibrary: (MusicLibrary*) music;
- (IBAction)save:(UIButton *)sender;
@end
