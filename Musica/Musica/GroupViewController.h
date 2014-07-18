//
//  GroupViewController.h
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicLibrary.h"

@interface GroupViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (retain, nonatomic) IBOutlet UITextField *nameTextField;
@property (retain, nonatomic) IBOutlet UITextField *styleTextField;
@property (retain, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (retain,nonatomic) MusicLibrary * music;
@property (retain, nonatomic) IBOutlet UIScrollView * groupScrollView;
@property (retain, nonatomic) IBOutlet UIView *insideView;
@property (retain,nonatomic) UIView * firstResponder;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withLibrary: (MusicLibrary*) music;
- (IBAction)save:(UIButton *)sender;
@end
