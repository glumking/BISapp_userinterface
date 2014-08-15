//
//  NetworkService.h
//  BIS app
//
//  Created by phillips on 8/14/14.
//  Copyright (c) 2014 ICEHOUSE-internship. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkService : NSObject

+(void) loginWithData:(NSDictionary *)loginData OnSuccess:(void(^)(id responseObject))success onFail:(void(^)(id operation,NSError *error))errorHandler;

+(void) retrieveHomeworkOnSuccess:(void(^)(id responseObject))success onFail:(void(^)(id operation,NSError *error))errorHandler;

+(void) retrieveTeachersOnSuccess:(void(^)(id responseObject))success onFail:(void(^)(id operation,NSError *error))errorHandler;

@end
