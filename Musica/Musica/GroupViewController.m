//
//  GroupViewController.m
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "GroupViewController.h"
#import "MBProgressHUD.h"

@interface GroupViewController () <UITextFieldDelegate, UITextViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (strong,nonatomic) MusicLibrary * music;
@property (strong,nonatomic) UIView * fResponder;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title= @"Grupo";
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]
                                              initWithTitle:@"OK" style: UIBarButtonItemStyleDone target:self action:@selector(save:)] ;
    self.nameTextField.delegate=self;
    self.styleTextField.delegate=self;
    self.descriptionTextView.delegate=self;
    self.groupScrollView.delegate=self;

    [self.groupScrollView setScrollEnabled:YES];
    self.groupScrollView.contentSize = CGSizeMake(self.insideView.frame.size.width, self.insideView.frame.size.height);
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapPressed:)];
    [self.view addGestureRecognizer:tapGesture];

 
}
#pragma mark- Save Object

- (IBAction)save:(id)sender {
    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.labelText = @"Guardando";
    HUD.detailsLabelText = @"Por favor espere";
    HUD.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:HUD];
    [HUD showWhileExecuting:@selector(popView) onTarget:self withObject:nil animated:YES];
}
-(void) popView{
    [self.music addGroup:self.nameTextField.text withStyle: self.styleTextField.text withDescription:self.descriptionTextView.text];
    sleep(1.5);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - First Responder
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.fResponder= textField;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    self.fResponder=textView;
    return YES;
}

#pragma mark - Keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField;  {
    [textField resignFirstResponder];
    return YES;
}

-(void) keyboardWillShow: (NSNotification *) notification{
    NSDictionary * info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    UIEdgeInsets contentInsets = UIEdgeInsetsMake(64.0, 0.0, kbSize.height, 0.0);
    self.groupScrollView.contentInset = contentInsets;
    self.groupScrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.insideView.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.fResponder.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, self.fResponder.frame.origin.y-kbSize.height);
        [self.groupScrollView setContentOffset:scrollPoint animated:YES];
    }
 
}

-(void) keyboardWillHide: (NSNotification *) notification{
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(64.0, 0.0, 0.0, 0.0);;
    self.groupScrollView.contentInset = contentInsets;
    self.groupScrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark - gesture
-(void) onTapPressed:(id) sender{
    
    [self.fResponder resignFirstResponder];
}

@end
