//
//  GroupViewController.m
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "GroupViewController.h"

@interface GroupViewController () <UITextFieldDelegate, UITextViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    UITextField * _nameTextField;
    UITextField * _styleTextField;
    UITextView * _descriptionTextView;
    MusicLibrary * _music;
    UIScrollView * _groupScrollView;
    UIView * _insideView;
    UIView * _fResponder;
}
@property (retain,nonatomic) MusicLibrary * music;
@property (retain,nonatomic) UIView * fResponder;
@end

@implementation GroupViewController

@synthesize nameTextField=_nameTextField;
@synthesize styleTextField=_styleTextField;
@synthesize descriptionTextView=_descriptionTextView;
@synthesize music=_music;
@synthesize groupScrollView=_groupScrollView;
@synthesize insideView=_insideView;
@synthesize fResponder=_fResponder;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withLibrary: (MusicLibrary*) music
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.music= music;
    }
    return self;
}

- (IBAction)save:(id)sender {
    [self.music addGroup:self.nameTextField.text withStyle: self.styleTextField.text withDescription:self.descriptionTextView.text];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title= @"Grupo";
    self.navigationItem.rightBarButtonItem =[[[UIBarButtonItem alloc]
                                              initWithTitle:@"OK" style: UIBarButtonItemStyleDone target:self action:@selector(save:)] autorelease];
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
    
    UITapGestureRecognizer * tapGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapPressed:)]autorelease];
    [self.view addGestureRecognizer:tapGesture];

 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark -dealloc
-(void) dealloc {
    [_nameTextField release];
    [_styleTextField release];
    [_descriptionTextView release];
    [_groupScrollView release];
    [_insideView release];
    [_music release];
    [_fResponder release];
    [super dealloc];
}
@end
