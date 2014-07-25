//
//  AlbumViewController.m
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "AlbumViewController.h"
#import "AlbumImageViewPickerDelegate.h"

@interface AlbumViewController () <UIPickerViewDelegate,UITextViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UIScrollViewDelegate,ImageUpdate>
@property (copy, nonatomic) NSString * pickerSelection;
@property (retain,nonatomic) MusicLibrary * music;
@property (retain, nonatomic) UIView * fResponder;
@property (retain, nonatomic) AlbumImageViewPickerDelegate * imageViewPicker;
@end


@implementation AlbumViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withLibrary: (MusicLibrary*) music
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.music=music;
        self.imageViewPicker=[[AlbumImageViewPickerDelegate alloc]init];
        self.imageViewPicker.delegate=self;
        
    }
    return self;
}

- (IBAction)save:(id)sender {
    
//    self.pickerSelection = [[self.music getGroups] objectAtIndex:[self.groupPickerView selectedRowInComponent:0]];
    [self.music addAlbum:self.nameTextField.text withYear:self.yearTextField.text withGroup:self.pickerSelection withImageName:[self.imageViewPicker getSelection]];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title= @"Album";
    self.nameTextField.delegate=self;
    self.yearTextField.delegate=self;
    self.groupPickerView.delegate=self;
    self.albumImagePickerView.delegate=self.imageViewPicker;
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
    [self pickerSelectionWasMade:self.imageViewPicker];
    self.pickerSelection = [[self.music getGroups] firstObject];

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

#pragma mark - picker groups

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


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.pickerSelection =[self.music getGroups][row];
}
#pragma mark - gesture
-(void) onTapPressed:(id) sender{
    
    [self.fResponder resignFirstResponder];
}

#pragma mark - imageUpdate protocol

-(void) pickerSelectionWasMade: (AlbumImageViewPickerDelegate *) imagePicker{
    self.albumImageView.image = [UIImage imageNamed: [imagePicker getSelection]];
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
    [_albumImagePickerView release];
    [_albumImageView release];
    [_imageViewPicker release];
    [super dealloc];
}
@end
