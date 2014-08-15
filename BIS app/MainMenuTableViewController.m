//
//  bisAppTableViewController.m
//  BIS app
//
//  Created by phillips on 6/10/14.
//  Copyright (c) 2014 ICEHOUSE-internship. All rights reserved.
//

#import "HomeworkTableViewController.h"
#import "MainMenuTableViewController.h"
#import "TeacherTableViewController.h"
#import "Menu.h"
#import <UIKit/UIKit.h>
#import "CalendarService.h"
#import <SVProgressHUD.h>
#import "NetworkService.h"
#import "UserService.h"

@interface MainMenuTableViewController ()

@end

@implementation MainMenuTableViewController

{
    
    NSArray *menuPics;

}

- (id)initWithStyle:(UITableViewStyle)style
{
    
    self = [super initWithStyle:style];
    
    if (self){
        
    }
    
    return self;

}

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"Welcome BIS";
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.navigationItem.title = @"Back";
    
}

- (void)viewDidLoad
{
    
    UIImage* image3 = [UIImage imageNamed:@"icon_logout_@2x.png"];
    CGRect frameimg = CGRectMake(15,5, 25,25);
    
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(Back_btn:)
         forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.leftBarButtonItem =mailbutton;
    [super viewDidLoad];
    menuPics = [NSArray arrayWithObjects: @"icon_homework_@2x.png", @"icon_teacher_@2x.png", nil];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

-(IBAction)Back_btn:(id)sender
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.menu count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainMenuCell"];
    
    if (!cell){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainMenuCell"];
        
    }
    
    Menu *menu = (self.menu)[indexPath.row];

    UIImageView *imageView = (UIImageView *)[cell viewWithTag: 102];
    imageView.image = [UIImage imageNamed:[menuPics objectAtIndex:indexPath.row]];
    
    UILabel *textLabel = (UILabel *)[cell viewWithTag:101];
    textLabel.text = menu.name;
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(indexPath.row == 0){
    
        [self performSegueWithIdentifier:@"homeworkSegue" sender:self];
        
    }else{
        
        [self performSegueWithIdentifier:@"teacherSegue" sender:self];
        
    }

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier  isEqual: @"homeworkSegue"]){
        
        [self prepareHomeworkSegue:segue];
        
    } else if([segue.identifier  isEqual: @"teacherSegue"]){
        
        [self prepareTeacherSegue:segue];
        
    }
    
}

- (void)prepareHomeworkSegue:(UIStoryboardSegue*)segue
{
    HomeworkTableViewController *homeworkVC = (HomeworkTableViewController*) [segue destinationViewController];
    
    [SVProgressHUD show];
    
    [NetworkService retrieveHomeworkOnSuccess:^(id responseObject) {
        
        homeworkVC.homework = responseObject;
        
        [homeworkVC.tableView reloadData];
        
        [CalendarService addEventsToCalendar:homeworkVC.homework];
        
        [SVProgressHUD dismiss];

    } onFail:^(id operation, NSError *error) {
        
        [SVProgressHUD dismiss];
        
    }];
    
     
}

-(void)prepareTeacherSegue:(UIStoryboardSegue *)segue
{
    TeacherTableViewController *teacherVC = (TeacherTableViewController*) [segue destinationViewController];
    
    [SVProgressHUD show];
    
    [NetworkService retrieveTeachersOnSuccess:^(id responseObject) {
        
        teacherVC.myteachers = [responseObject objectForKey:@"my_teacher"];
        
        teacherVC.otherteachers = [responseObject objectForKey:@"other_teachers"];
        
        [teacherVC.tableView reloadData];
        
        [SVProgressHUD dismiss];
        
    } onFail:^(id operation, NSError *error) {
        
        [SVProgressHUD dismiss];
        
    }];
    
}


@end
