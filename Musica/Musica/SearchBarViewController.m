//
//  SearchBarViewController.m
//  Musica
//
//  Created by Julieta Puente on 11/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "SearchBarViewController.h"
#import "SearchViewController.h"
#import "SearchService.h"
#import "MBProgressHUD.h"
#import "NoResultViewController.h"
#import "KeyboardToolbar.h"

@interface SearchBarViewController ()<UISearchBarDelegate, UISearchDisplayDelegate, ComunicatorResponse>

@property (strong, nonatomic) SearchService * service;
@property (strong, nonatomic) MBProgressHUD * HUD;
@end

@implementation SearchBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.searchBar.text = nil;
    self.searchBar.barTintColor = [UIColor yellowColor];
    [self.searchBar setPlaceholder:@"Buscar"];
    self.searchBar.delegate= self;
    self.searchBar.showsCancelButton = YES;
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapPressed:)];
    [self.view addGestureRecognizer:tapGesture];
    self.service= [[SearchService alloc]init];
    self.service.delegate=self;
    
    
    KeyboardToolbar *toolBar = [[KeyboardToolbar alloc] initWithFrame:CGRectMake(0.0f,
                                                                     0.0f,
                                                                     self.view.window.frame.size.width,
                                                                     35.0f)];
    toolBar.okButton.action=@selector(doneEditing);
    self.searchBar.inputAccessoryView = toolBar;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.searchBar.text = nil;
}

-(void) doneEditing{
    [self.searchBar resignFirstResponder];
}
-(void) onTapPressed: (id) sender{
    [self.searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString * searchString =[searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    [self.service searchApiWithString:searchString];
    if(self.HUD == nil){
        
        self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    }
    self.HUD.labelText = @"Buscando";
    self.HUD.detailsLabelText = @"Por favor espere";
    self.HUD.mode = MBProgressHUDModeIndeterminate;
    [self.HUD show:YES];
    [self.view addSubview:self.HUD];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
    [searchBar resignFirstResponder];
}

-(void) fetchFailed:(NSError *) error{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Se produjo un error en la conexión" message:@"Por favor inténtelo nuevamente" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [self.HUD hide:YES];
}

-(void) noResultsFound{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NoResultViewController * noResultView = [[NoResultViewController alloc]initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:noResultView animated:YES];
        [self.searchBar resignFirstResponder];
        [self.HUD hide:YES];
    });
}

-(void) resultsReceived:(NSArray *)results{
    dispatch_async(dispatch_get_main_queue(), ^{
        SearchViewController * searchView = [[SearchViewController alloc]initWithNibName:nil bundle:nil withData:results];
        [self.navigationController pushViewController:searchView animated:YES];
        [self.searchBar resignFirstResponder];
        [self.HUD hide:YES];
    });
}

@end
