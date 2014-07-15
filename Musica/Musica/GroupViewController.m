//
//  GroupViewController.m
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "GroupViewController.h"

@interface GroupViewController ()

@end

@implementation GroupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withLibrary: (MusicLibrary*) music
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.music= music;
    }
    return self;
}

- (IBAction)save:(UIButton *)sender {
    [self.music addGroup:self.NameTextField.text withStyle: self.StyleTextField.text withDesc:self.DescriptionTextView.text];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.NameTextField.delegate=self;
    self.StyleTextField.delegate=self;
    self.DescriptionTextView.delegate=self;
    self.GroupScrollView.delegate=self;

    [self.GroupScrollView setScrollEnabled:YES];
    self.GroupScrollView.contentSize = CGSizeMake(self.InsideView.frame.size.width, self.InsideView.frame.size.height);
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] init];
    [tapGesture setDelegate:self];
    [self.GroupScrollView addGestureRecognizer:tapGesture];

 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Keyboard

- (BOOL)textFieldShouldReturn:(UITextField *)textField;  {
    [textField resignFirstResponder];
    return YES;
}


//no funciona con el scroll view
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

-(void) keyboardWillShow: (NSNotification *) notification{
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.InsideView.frame.origin.x, 0.0, kbSize.height, 0.0);
    self.GroupScrollView.contentInset = contentInsets;
    self.GroupScrollView.scrollIndicatorInsets = contentInsets;

 
}

-(void) keyboardWillHide: (NSNotification *) notification{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.GroupScrollView.contentInset = contentInsets;
    self.GroupScrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark - gesture

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    NSLog(@"Gesture tap %@",gestureRecognizer);
    return YES;
}
@end
