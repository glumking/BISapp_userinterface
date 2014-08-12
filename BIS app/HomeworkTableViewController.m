//
//  HomeworkTableViewController.m
//  BIS app
//
//  Created by phillips on 8/8/14.
//  Copyright (c) 2014 ICEHOUSE-internship. All rights reserved.
//

#import "HomeworkTableViewController.h"

@interface HomeworkTableViewController ()

@end

@implementation HomeworkTableViewController


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
    self.navigationItem.title = self.subjectName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeworkCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeworkCell"];
        
    }

    UIImageView *imageView = (UIImageView *)[cell viewWithTag: 304];
    imageView.image = [UIImage imageNamed:
        [NSString stringWithFormat:@"icon_calendar_@2x.png",indexPath.row]];
    
    return cell;
}


@end
