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
#import "SearchedObject.h"
#import "NoResultViewController.h"

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
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.searchBar.text = nil;
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
    NSLog(@"Se rompio todo %@",error);
    [self.HUD hide:YES];
}
-(void) receivedJSON:(NSData *) data{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
    
    if (localError != nil) {
        NSLog(@"%@", localError);
        return;
    }
    
    NSMutableArray * objects = [[NSMutableArray alloc] init];
    
    NSArray *results = [parsedObject valueForKey:@"results"];
    
    if( [results count]==0){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NoResultViewController * noResultView = [[NoResultViewController alloc]initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:noResultView animated:YES];
            [self.searchBar resignFirstResponder];
            [self.HUD hide:YES];
        });
    }else{
        for (NSDictionary * objDic in results) {
            SearchedObject * obj = [[SearchedObject alloc] init];
            
            for (NSString *key in objDic) {
                if ([obj respondsToSelector:NSSelectorFromString(key)]) {
                    [obj setValue:[objDic valueForKey:key] forKey:key];
                }
            }
            
            [objects addObject:obj];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            SearchViewController * searchView = [[SearchViewController alloc]initWithNibName:nil bundle:nil withData:objects];
            [self.navigationController pushViewController:searchView animated:YES];
            [self.searchBar resignFirstResponder];
            [self.HUD hide:YES];
        });
        
    }
    
}

@end
