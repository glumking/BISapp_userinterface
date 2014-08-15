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

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"Teachers";
    
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 ) {
        
        return self.myteachers.count;
    
    }else{
        
        return self.otherteachers.count;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *teacherEmail = @"";
    
    if (indexPath.section == 0){
        
        teacherEmail = [self.myteachers[indexPath.row] objectForKey:@"email"];
        
    }else{
            
        teacherEmail = [self.otherteachers[indexPath.row] objectForKey:@"email"];
        
    }
    
    [self sendEmailWithDestination:teacherEmail];
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section == 0){
        
        return @"My Teachers";
        
    }else{
        
        return @"Other Teachers";
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TeacherCell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TeacherCell"];
        cell.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        cell.clipsToBounds = YES;
    }
    
    if (indexPath.section ==0){
    
        UILabel *teacherName = (UILabel *)[cell viewWithTag:402];
        teacherName.text = [self.myteachers[indexPath.row] objectForKey:@"name"];
    
        UILabel *email = (UILabel *)[cell viewWithTag:401];
        email.text = [self.myteachers[indexPath.row] objectForKey:@"email"];
        
    }else{
        
        
        UILabel *teacherName = (UILabel *)[cell viewWithTag:402];
        teacherName.text = [self.otherteachers[indexPath.row] objectForKey:@"name"];
        
        UILabel *email = (UILabel *)[cell viewWithTag:401];
        email.text = [self.otherteachers[indexPath.row] objectForKey:@"email"];
        
    }
    
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
