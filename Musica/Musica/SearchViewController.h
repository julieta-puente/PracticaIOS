//
//  SearchViewController.h
//  Musica
//
//  Created by Julieta Puente on 08/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView * tableViewSearch;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withData:(NSArray *) data;
@end
