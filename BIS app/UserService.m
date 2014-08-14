//
//  UserService.m
//  BIS app
//
//  Created by phillips on 8/14/14.
//  Copyright (c) 2014 ICEHOUSE-internship. All rights reserved.
//

#import "UserService.h"

@implementation UserService

+(void)storeUserID: (NSString *)userID
{
    
    [[NSUserDefaults standardUserDefaults] setObject:userID forKey:@"userID"];
    
}

+(NSString *)retrieveUserID
{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    
}

@end
