//
//  AppDelegate.m
//  greekSingScoring
//
//  Created by Kevin Karol on 1/16/14.
//  Copyright (c) 2014 Kevin Karol. All rights reserved.
//

#import "AppDelegate.h"



@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    splitViewController.delegate = (id)navigationController.topViewController;
    
    DetailViewController *detailViewController =(DetailViewController *) [splitViewController.viewControllers lastObject];
    MasterViewController *masterViewController = (MasterViewController *) [[splitViewController.viewControllers objectAtIndex:0] topViewController];

    masterViewController.delegate = [[detailViewController childViewControllers] objectAtIndex:0];
    
    //On app being opened, prompt with a login box
    if(![LoginManager isLoggedIn]){
        [self getLogin];
    }
    
    return YES;
}

-(void)getLogin{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Who Are You?" message:@"Please enter your Judge ID" delegate:self cancelButtonTitle:@"Login" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField* alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeDefault;
    alertTextField.placeholder = @"Enter your Judge ID";
    [alert show];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString* judgeID = [[alertView textFieldAtIndex:0] text];
    [LoginManager setName:judgeID];
}

@end
