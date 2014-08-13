//
//  HomeworkTableViewController.h
//  BIS app
//
//  Created by phillips on 6/10/14.
//  Copyright (c) 2014 ICEHOUSE-internship. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeworkTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *homework;

@property (nonatomic,strong) NSIndexPath *selectedIndexPath;

@end
