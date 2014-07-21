//
//  AlbumViewController.m
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "AlbumViewController.h"

@interface AlbumViewController () <UIPickerViewDelegate,UITextViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UIScrollViewDelegate>{
    UITextField * _nameTextField;
    UITextField * _yearTextField;
    UIPickerView * _groupPickerView;
    NSString * _pickerSelection;
    MusicLibrary * _music;
    UIScrollView * _albumScrollView;
    UIView * _insideView;
    UIView * _fResponder;
}
@property (copy, nonatomic) NSString * pickerSelection;
@property (retain,nonatomic) MusicLibrary * music;
@property (retain, nonatomic) UIView * fResponder;
@end


@implementation AlbumViewController

@synthesize nameTextField=_nameTextField;
@synthesize yearTextField=_yearTextField;
@synthesize groupPickerView=_groupPickerView;
@synthesize pickerSelection=_pickerSelection;
@synthesize music=_music;
@synthesize albumScrollView=_albumScrollView;
@synthesize insideView=_insideView;
@synthesize fResponder=_fResponder;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withLibrary: (MusicLibrary*) music
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.music=music;
    }
    return self;
}

- (IBAction)save:(id)sender {
    [self.music addAlbum:self.nameTextField.text withYear:self.yearTextField.text withGroup:self.pickerSelection];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title= @"Album";
    self.nameTextField.delegate=self;
    self.yearTextField.delegate=self;
    self.groupPickerView.delegate=self;
    self.navigationItem.rightBarButtonItem =[[[UIBarButtonItem alloc]
                                              initWithTitle:@"OK" style: UIBarButtonItemStyleDone target:self action:@selector(save:)] autorelease];
    self.albumScrollView.delegate=self;
    [self.albumScrollView setScrollEnabled:YES];
    self.albumScrollView.contentSize = CGSizeMake(self.insideView.frame.size.width, self.insideView.frame.size.height);
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


-(void) keyboardWillShow: (NSNotification *) notification{
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(64.0, 0.0, kbSize.height, 0.0);
    self.albumScrollView.contentInset = contentInsets;
    self.albumScrollView.scrollIndicatorInsets = contentInsets;
    
    
}

-(void) keyboardWillHide: (NSNotification *) notification{
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(64.0, 0.0, 0.0, 0.0);;
    self.albumScrollView.contentInset = contentInsets;
    self.albumScrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark - picker

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [[self.music getGroups] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.music getGroups][row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
   self.pickerSelection = [self.music getGroups][row];
}

#pragma mark - gesture
-(void) onTapPressed:(id) sender{
    
    [self.fResponder resignFirstResponder];
}

#pragma mark -dealloc
-(void) dealloc{
    [_nameTextField release];
    [_yearTextField release];
    [_groupPickerView release];
    [_music release];
    [_albumScrollView release];
    [_insideView release];
    [_fResponder release];
    [_pickerSelection release];
    [super dealloc];
}
@end
