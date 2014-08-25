//
//  AlbumDetailViewController.m
//  Musica
//
//  Created by Julieta Puente on 23/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "AlbumDetailViewController.h"

@interface AlbumDetailViewController () <UIScrollViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>{
    BOOL saved;
}
@property (strong, nonatomic) Album * album;
@property (copy, nonatomic) NSString * group;
@property (strong,nonatomic) UIView * fResponder;


@end

@implementation AlbumDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withAlbum: (Album *) album withGroup: (NSString *) group;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.album=album;
        self.group=group;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.labelGroup.text=self.group;
    self.textFieldName.text = [self.album getName];
    self.textFieldName.enabled =NO;
    self.textFieldName.delegate=self;
    self.textFieldYear.text = [self.album getYear];
    self.textFieldYear.enabled=NO;
    self.textFieldYear.delegate=self;
    self.imageAlbum.image = [UIImage imageNamed:[self.album getImageName]];
    self.scrollViewDetail.delegate=self;
    [self.scrollViewDetail setScrollEnabled:YES];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"Editar" style: UIBarButtonItemStyleDone target:self action:@selector(edit:)] ;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithTitle:@"Biblioteca" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    saved = YES;

}

#pragma mark - RightBarButtonItem
-(void) edit:(id) sender{
  
    self.textFieldName.enabled=YES;
    [self.textFieldName setBorderStyle:UITextBorderStyleRoundedRect];
    self.textFieldYear.enabled=YES;
    [self.textFieldYear setBorderStyle:UITextBorderStyleRoundedRect];
    self.navigationItem.rightBarButtonItem.action=@selector(save:);
    self.navigationItem.rightBarButtonItem.title=@"Guardar";
    saved=NO;
    
}
-(void) save:(id) sender{
    self.textFieldName.enabled=NO;
    [self.textFieldName setBorderStyle:UITextBorderStyleNone];
    self.textFieldYear.enabled=NO;
    [self.textFieldYear setBorderStyle:UITextBorderStyleNone];
    self.navigationItem.rightBarButtonItem.action=@selector(edit:);
    self.navigationItem.rightBarButtonItem.title=@"Editar";
    
    self.album.name= self.textFieldName.text;
    self.album.year= self.textFieldYear.text;
    saved=YES;
}

#pragma mark - LeftBarButtonItem
-(void) back: (id) sender{
    if(!saved){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Cambios sin guardar" message:@"¿Desea salir de todas formas?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Si", nil];
        [alert show];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == alertView.firstOtherButtonIndex){
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - First Responder
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.fResponder= textField;
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
    self.scrollViewDetail.contentInset = contentInsets;
    self.scrollViewDetail.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.innerView.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.fResponder.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, self.fResponder.frame.origin.y-kbSize.height);
        [self.scrollViewDetail setContentOffset:scrollPoint animated:YES];
    }
    
}

//ASADO: no vuelve a la posicion original
-(void) keyboardWillHide: (NSNotification *) notification{
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(64.0, 0.0, 0.0, 0.0);;
    self.scrollViewDetail.contentInset = contentInsets;
    self.scrollViewDetail.scrollIndicatorInsets = contentInsets;
}

@end
