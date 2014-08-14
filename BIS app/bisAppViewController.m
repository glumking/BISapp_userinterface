//
//  bisAppViewController.m
//  BIS app
//
//  Created by phillips on 6/10/14.
//  Copyright (c) 2014 ICEHOUSE-internship. All rights reserved.
//

#import "bisAppViewController.h"
#import "MainMenuTableViewController.h"
#import "Menu.h"
#import <AFNetworking.h>
#import "UserService.h"

@interface bisAppViewController () <UITextFieldDelegate>

@end

@implementation bisAppViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	[self setNeedsStatusBarAppearanceUpdate];
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
    [self.passwordField setSecureTextEntry:YES];
    
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    
    return UIStatusBarStyleLightContent;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewDidDisappear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    NSMutableArray *_menuData = [NSMutableArray arrayWithCapacity:20];

    Menu *menu = [[Menu alloc] init];
    menu.name = @"Homework";
    [_menuData addObject:menu];

    Menu *menu2 = [[Menu alloc] init];
    menu2.name = @"Teachers";
    [_menuData addObject:menu2];
    
    MainMenuTableViewController *bisAppTVC = (MainMenuTableViewController *) [segue destinationViewController];
    bisAppTVC.menu =  _menuData;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35f];
    CGRect frame = self.view.frame;
    frame.origin.y = -150;
    [self.view setFrame:frame];
    [UIView commitAnimations];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [textField resignFirstResponder];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35f];
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    [self.view setFrame:frame];
    [UIView commitAnimations];
    
    return YES;

}

-(void)addAlertView{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Login failed" message:@"Please try again" delegate:self
                                             cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
}

-(void)login
{
    NSURL *baseURL = [NSURL URLWithString:@"http://fauxhw.appspot.com"];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject: @"text/html"];

    NSDictionary *loginData = @{@"username": self.usernameField.text, @"password": self.passwordField.text};
    
    [manager POST:@"/login" parameters:loginData
     
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSString *userID = [responseObject objectForKey:@"id"];
              
              [UserService storeUserID:userID];
              
              [self performSegueWithIdentifier:@"loginSegue" sender:self];
        }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
        [self addAlertView];
    }];
}

@end
