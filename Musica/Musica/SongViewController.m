//
//  SongViewController.m
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "SongViewController.h"

@interface SongViewController (){
    UITextField * _nameTextField;
    UITextField * _durationTextField;
    UIPickerView * _albumPickerView;
    NSString * _pickerSelection;
    MusicLibrary * _music;
    UIScrollView * _songScrollView;
    UIView * _insideView;
    UIView * _fResponder;
}

@end

@implementation SongViewController

@synthesize nameTextField=_nameTextField;
@synthesize durationTextField=_durationTextField;
@synthesize albumPickerView=_albumPickerView;
@synthesize music=_music;
@synthesize songScrollView=_songScrollView;
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

- (IBAction)save:(UIButton *)sender {
    [self.music addSong:self.nameTextField.text withDur:self.durationTextField.text withAlbum:self.pickerSelection];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title= @"Canción";
    self.nameTextField.delegate=self;
    self.albumPickerView.delegate=self;
    self.durationTextField.delegate=self;
    self.navigationItem.rightBarButtonItem =[[[UIBarButtonItem alloc]
                                              initWithTitle:@"OK" style: UIBarButtonItemStyleDone target:self action:@selector(save:)] autorelease];
    self.songScrollView.delegate=self;
    [self.songScrollView setScrollEnabled:YES];
    self.songScrollView.contentSize = CGSizeMake(self.insideView.frame.size.width, self.insideView.frame.size.height);
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
    self.songScrollView.contentInset = contentInsets;
    self.songScrollView.scrollIndicatorInsets = contentInsets;
    
    
}

-(void) keyboardWillHide: (NSNotification *) notification{
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(64.0, 0.0, 0.0, 0.0);;
    self.songScrollView.contentInset = contentInsets;
    self.songScrollView.scrollIndicatorInsets = contentInsets;
}


#pragma mark - Picker
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [[self.music getAlbums] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[self.music getAlbums] objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.pickerSelection = [[[self.music getAlbums] objectAtIndex:row] copy];
}

#pragma mark - gesture
-(void) onTapPressed:(id) sender{
    
    [self.fResponder resignFirstResponder];
}

#pragma mark -dealloc
-(void) dealloc{
    [_nameTextField release];
    [_durationTextField release];
    [_albumPickerView release];
    [_pickerSelection release];
    [_music release];
    [_songScrollView release];
    [_insideView release];
    [_fResponder release];
    [super dealloc];
}
@end
