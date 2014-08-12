//
//  HomeworkTableViewController.m
//  BIS app
//
//  Created by phillips on 6/10/14.
//  Copyright (c) 2014 ICEHOUSE-internship. All rights reserved.
//

#import "SubjectTableViewController.h"
#import "HomeworkTableViewController.h"

@interface SubjectTableViewController ()

@end

@implementation SubjectTableViewController

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
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

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    HomeworkTableViewController *homeworkVC = (HomeworkTableViewController*) [segue destinationViewController];
//    NSInteger selectedRow = [self.tableView indexPathForSelectedRow].row;
//    homeworkVC.subjectName = self.subjects[selectedRow];
//}

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
