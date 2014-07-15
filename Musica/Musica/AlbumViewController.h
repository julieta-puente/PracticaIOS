//
//  AlbumViewController.h
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicLibrary.h"

@interface AlbumViewController : UIViewController <UIPickerViewDelegate,UITextViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *NameTextField;
@property (strong, nonatomic) IBOutlet UITextField *YearTextField;
@property (strong, nonatomic) IBOutlet UIPickerView *GroupPickerView;
@property (nonatomic, copy) NSString * pickerSelection;
@property (strong,nonatomic) MusicLibrary * music;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withLibrary: (MusicLibrary*) music;
- (IBAction)save:(UIButton *)sender;

@end
