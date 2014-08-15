//
//  TeacherTableViewController.m
//  BIS app
//
//  Created by phillips on 8/13/14.
//  Copyright (c) 2014 ICEHOUSE-internship. All rights reserved.
//

#import "TeacherTableViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "MainMenuTableViewController.h"

@interface TeacherTableViewController () <MFMailComposeViewControllerDelegate>

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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *teacherEmail = [self.teachers[indexPath.row] objectForKey:@"email"];
    
    [self sendEmailWithDestination:teacherEmail];
    
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

-(void)sendEmailWithDestination: (NSString *)destinationEmail
{
    
    if ([MFMailComposeViewController canSendMail] ) {
        
        MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
        
        mailVC.mailComposeDelegate = self;
        
        [mailVC setToRecipients: @[destinationEmail]];
        
        [self presentViewController:mailVC animated:YES completion:nil];
        
    }
    
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
