//
//  AppDelegate.m
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LibraryViewController.h"
#import "SearchBarViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    MusicLibrary * music = [[MusicLibrary alloc] init];
    MainViewController * mainViewController=[[MainViewController alloc]initWithNibName:nil bundle:nil withLibrary:music];
    LibraryViewController * libraryViewController =[[LibraryViewController alloc]initWithNibName:nil bundle:nil withMusic:music];
    libraryViewController.title= @"Biblioteca";
    SearchBarViewController * searchBarController = [[SearchBarViewController alloc]initWithNibName:nil bundle:nil];
    searchBarController.title=@"Buscar";
    UINavigationController * navController =[[UINavigationController alloc]initWithRootViewController: mainViewController];
    UINavigationController * navControllerLibrary =[[UINavigationController alloc]initWithRootViewController: libraryViewController];
    UINavigationController * navControllerSearchBar =[[UINavigationController alloc]initWithRootViewController: searchBarController];
    UITabBarController * tabController = [[UITabBarController alloc] initWithNibName:nil bundle:nil];
    [tabController setViewControllers:@[navController, navControllerLibrary,navControllerSearchBar]];
//    [[UITabBar appearance] setBarTintColor:[UIColor yellowColor]];
//    [[UINavigationBar appearance] setBackgroundColor:[UIColor yellowColor]];
    self.window.rootViewController= tabController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
