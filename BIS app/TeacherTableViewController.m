//
//  TeacherTableViewController.m
//  BIS app
//
//  Created by phillips on 8/13/14.
//  Copyright (c) 2014 ICEHOUSE-internship. All rights reserved.
//

#import "TeacherTableViewController.h"
#import "MainMenuTableViewController.h"

@interface TeacherTableViewController ()

@end

@implementation TeacherTableViewController


- (void)viewDidLoad
{
    
    [super viewDidLoad];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.teachers.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TeacherCell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TeacherCell"];
        cell.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        cell.clipsToBounds = YES;
    }
    
    UILabel *teacherName = (UILabel *)[cell viewWithTag:402];
    teacherName.text = [self.teachers[indexPath.row] objectForKey:@"name"];
    
    UILabel *email = (UILabel *)[cell viewWithTag:401];
    email.text = [self.teachers[indexPath.row] objectForKey:@"email"];
    
    return cell;
    
}

@end
