//
//  AlbumViewController.m
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "AlbumViewController.h"
#import "AlbumImageViewPickerDelegate.h"
#import "MBProgressHUD.h"


@interface AlbumViewController () <UIPickerViewDelegate,UITextViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UIScrollViewDelegate,ImageUpdate>
@property (copy, nonatomic) NSString * pickerSelection;
@property (strong,nonatomic) MusicLibrary * music;
@property (strong, nonatomic) UIView * fResponder;
@property (strong, nonatomic) AlbumImageViewPickerDelegate * imageViewPicker;
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

- (void)viewDidLoad
{
   
    [super viewDidLoad];
    
    self.title= @"Album";
    self.nameTextField.delegate=self;
    self.yearTextField.delegate=self;
    self.groupPickerView.delegate=self;
    self.albumImagePickerView.delegate=self.imageViewPicker;
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]
                                              initWithTitle:@"OK" style: UIBarButtonItemStyleDone target:self action:@selector(save:)];
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
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapPressed:)];
    [self.view addGestureRecognizer:tapGesture];
    [self pickerSelectionWasMade:self.imageViewPicker];
    self.pickerSelection = [[self.music getGroups] firstObject];

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
    [self.music  addAlbum:self.nameTextField.text withYear:self.yearTextField.text withImageName: [self.imageViewPicker getSelection] forGroup:self.pickerSelection];
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

@end
