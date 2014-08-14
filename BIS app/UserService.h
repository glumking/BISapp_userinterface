//
//  UserService.h
//  BIS app
//
//  Created by phillips on 8/14/14.
//  Copyright (c) 2014 ICEHOUSE-internship. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserService : NSObject

+(void)storeUserID: (NSString *)userID;

+(NSString *)retrieveUserID;

@end
