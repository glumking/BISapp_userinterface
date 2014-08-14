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
#import <AFNetworking.h>
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
    if (self) {
        
        
        
    }
    
    return self;

}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    menuPics = [NSArray arrayWithObjects: @"icon_homework_@2x.png", @"icon_teacher_@2x.png", nil];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
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
    if ([segue.identifier  isEqual: @"homeworkSegue"]) {
        
        [self prepareHomeworkSegue:segue];
        
    } else if([segue.identifier  isEqual: @"teacherSegue"]){
        
        [self prepareTeacherSegue:segue];
        
    }
    
}

- (void)prepareHomeworkSegue:(UIStoryboardSegue*)segue
{
    HomeworkTableViewController *homeworkVC = (HomeworkTableViewController*) [segue destinationViewController];
    
    [SVProgressHUD show];
    NSURL *baseURL = [NSURL URLWithString:@"http://fauxhw.appspot.com"];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject: @"text/html"];
    
    NSString *userID = [UserService retrieveUserID];
    
    NSString *url = [NSString stringWithFormat: @"/homework/list/%@",userID];
    
    [manager GET:url parameters:nil
     
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              
              homeworkVC.homework = responseObject;
              
              [homeworkVC.tableView reloadData];
              
              [CalendarService addEventsToCalendar:homeworkVC.homework];
              
              [SVProgressHUD dismiss];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              [SVProgressHUD dismiss];
              
          }];
}

-(void)prepareTeacherSegue:(UIStoryboardSegue *)segue
{
    TeacherTableViewController *teacherVC = (TeacherTableViewController*) [segue destinationViewController];
    
    NSDictionary *teacher1 = @{
                               
                               @"id":@0,
                               @"name":@"Philippe",
                               @"email":@"17pangestup@bis.or.id"
                               
                               };
    
    NSDictionary *teacher2 = @{
                               
                               @"id":@1,
                               @"name":@"Hans",
                               @"email":@"17Wahonoh@bis.or.id"
                               
                               };
    
    
    teacherVC.teachers = @[teacher1, teacher2];
    
}



#pragma mark - Alert view delegate


@end
