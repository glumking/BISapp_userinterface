//
//  HomeworkTableViewController.m
//  BIS app
//
//  Created by phillips on 6/10/14.
//  Copyright (c) 2014 ICEHOUSE-internship. All rights reserved.
//

#import "SubjectTableViewController.h"
#import "UIScrollView+SVPullToRefresh.h"

@interface SubjectTableViewController ()

@end

@implementation SubjectTableViewController

-(void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [self.tableView addPullToRefreshWithActionHandler:^{}];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    return self.subjects.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubjectCell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SubjectCell"];
        cell.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        cell.clipsToBounds = YES;
        
    }
    
    UILabel *textLabel = (UILabel *)[cell viewWithTag:201];
    textLabel.text = self.subjects[indexPath.row];
    
    UILabel *textLabel2 = (UILabel *)[cell viewWithTag:206];
    textLabel2.text = @"example homework description : read textbooks from page 34 to sjkdbasdbkksnkasd play dota 3 for 3 hours";
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag: 202];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_course_@2x.png",indexPath.row]];
    
    UIImageView *imageView2 = (UIImageView *)[cell viewWithTag: 205];
    imageView2.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_calendar_@2x.png",indexPath.row]];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([self.selectedIndexPath isEqual:indexPath]){
    
        self.selectedIndexPath = nil;
    
    }else{
        
        self.selectedIndexPath = indexPath;
        
    }
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(self.selectedIndexPath && indexPath.row == self.selectedIndexPath.row){
        
        return [UIScreen mainScreen].bounds.size.height - 100;
        
    }else{
        
        return 60;
        
    }
    
}


@end
