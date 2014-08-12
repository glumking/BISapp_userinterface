//
//  bisAppTableViewController.m
//  BIS app
//
//  Created by phillips on 6/10/14.
//  Copyright (c) 2014 ICEHOUSE-internship. All rights reserved.
//
#import "SubjectTableViewController.h"
#import "MainMenuTableViewController.h"
#import "Menu.h"
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
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    menuPics = [NSArray arrayWithObjects: @"icon_homework_@2x.png", @"icon_teacher_@2x.png", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.players count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainMenuCell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainMenuCell"];
        
    }
    
    Menu *menu = (self.players)[indexPath.row];

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
        
        SubjectTableViewController *subjectVC = (SubjectTableViewController*) [segue destinationViewController];
        subjectVC.subjects = @[@"Math",@"Chinese",@"English",@"Physics",@"Biology",@"Chemistry",@"Global Perspective"];
        
    }else{
        
        
        
    }
}

@end
