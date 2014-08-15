//
//  HomeworkTableViewController.m
//  BIS app
//
//  Created by phillips on 6/10/14.
//  Copyright (c) 2014 ICEHOUSE-internship. All rights reserved.
//

#import "HomeworkTableViewController.h"
#import "ISRefreshControl.h"
#import "NetworkService.h"
#import "CalendarService.h"

@interface HomeworkTableViewController ()

@property (nonatomic,strong) UILabel *dummylabel;

@end

@implementation HomeworkTableViewController

-(void)viewDidLoad
{



    
    [super viewDidLoad];
    
    [self.refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    
    self.dummylabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 257, 17)];
    
    [self.dummylabel setFont:[UIFont systemFontOfSize:14]];
    
    [self.dummylabel setNumberOfLines:0];
    
}

#pragma mark - Table view data source
                               


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    return self.homework.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeworkCell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeworkCell"];
        cell.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        cell.clipsToBounds = YES;
    }
    
    UILabel *subjectLabel = (UILabel *)[cell viewWithTag:201];
    subjectLabel.text = [self.homework[indexPath.row] objectForKey:@"subject_id"];
    
    UILabel *homeworkDescription = (UILabel *)[cell viewWithTag:206];
    homeworkDescription.text = [self.homework[indexPath.row] objectForKey:@"description"];;
    
    UILabel *homeworkTitle = (UILabel *)[cell viewWithTag:203];
    homeworkTitle.text = [self.homework[indexPath.row] objectForKey:@"title"];;
    
    UILabel *homeworkdate = (UILabel *)[cell viewWithTag:204];
    homeworkdate.text = [self.homework[indexPath.row] objectForKey:@"due_date"];;
    
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
    
    if(self.selectedIndexPath && indexPath.row == self.selectedIndexPath.row)
    {
        
        self.dummylabel.text = [self.homework[indexPath.row] objectForKey:@"description"];;
        
        NSInteger height = [self.dummylabel sizeThatFits:self.dummylabel.frame.size].height;
        
        NSLog(@"The height of dummy label : %d",height);
        
        return 110 + height;
    
    }else{
        
        return 60;
        
    }
    
}

-(void)refreshData
{
    
    [NetworkService retrieveHomeworkOnSuccess:^(id responseObject) {
        
        self.homework = responseObject;
        
        [self.tableView reloadData];
        
        [CalendarService addEventsToCalendar:self.homework];
        
        [self.refreshControl endRefreshing];
        
        
    } onFail:^(id operation, NSError *error) {
        
        [self.refreshControl endRefreshing];

    }];
    
}


@end
