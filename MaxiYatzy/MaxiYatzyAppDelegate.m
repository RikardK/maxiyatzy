//
//  MaxiYatzyAppDelegate.m
//  MaxiYatzy
//
//  Created by Rikard Karlsson on 7/22/13.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import "MaxiYatzyAppDelegate.h"
#import "throwDicesViewController.h"
#import "HighScoreViewController.h"
#import "saveHighScoreViewController.h"

@implementation MaxiYatzyAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    throwDicesViewController *tdvc = [[throwDicesViewController alloc] initWithNibName:nil bundle:nil];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:tdvc];
    
    HighScoreViewController *hsvc = [[HighScoreViewController alloc] initWithNibName:nil bundle:nil];
    
    NSArray *viewControllers = [NSArray arrayWithObjects:navController, hsvc, nil];
    
    [tabBarController setViewControllers:viewControllers];
    
    [self.window setRootViewController:tabBarController];
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
