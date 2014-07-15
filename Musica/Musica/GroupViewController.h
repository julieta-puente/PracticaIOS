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

@property (strong, nonatomic) IBOutlet UITextField *NameTextField;
@property (strong, nonatomic) IBOutlet UITextField *StyleTextField;
@property (strong, nonatomic) IBOutlet UITextView *DescriptionTextView;
@property (strong,nonatomic) MusicLibrary * music;

@property (strong, nonatomic) IBOutlet UIScrollView * GroupScrollView;

@property (strong, nonatomic) IBOutlet UIView *InsideView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withLibrary: (MusicLibrary*) music;
- (IBAction)save:(UIButton *)sender;
@end
