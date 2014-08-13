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
    [self addAlertView];
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
    
    //TODO : Change this part with the networking code
    
    NSDictionary *mathHomework = @{
                                   
                                    @"id": @0,
                                    @"subject": @"Math",
                                    @"title": @"Summer Homework",
                                    @"due_date": @"10/10/2014",
                                    @"description": @"summer homework so your brain wont rust",
                                    @"schedule_id": @2,
                                    @"sort_order": @0
                                   
                                   };
    
    NSDictionary *engishHomework = @{
                                     
                                     @"id": @0,
                                     @"subject": @"English",
                                     @"title": @"Summer Homework",
                                     @"due_date": @"10/10/2014",
                                     @"description": @"READ DR J AND MR HYDE",
                                     @"schedule_id": @2,
                                     @"sort_order": @0
                                     
                                     };
    
    homeworkVC.homework = @[mathHomework, engishHomework];
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

-(void)addAlertView{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Login failed" message:@"Please try again" delegate:self
    cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
}

#pragma mark - Alert view delegate


@end
