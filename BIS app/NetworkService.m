//
//  NetworkService.m
//  BIS app
//
//  Created by phillips on 8/14/14.
//  Copyright (c) 2014 ICEHOUSE-internship. All rights reserved.
//

#import <AFNetworking.h>
#import "NetworkService.h"

@implementation NetworkService

+(void) loginWithData:(NSDictionary *)loginData OnSuccess:(void(^)(id))success onFail:(void(^)(id,NSError *))errorHandler
{
    
    NSURL *baseURL = [NSURL URLWithString:@"http://fauxhw.appspot.com"];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject: @"text/html"];
    
    [manager POST:@"/login"
       parameters:loginData
          success:^(AFHTTPRequestOperation *operation, id responseObject){
              
              success(responseObject);
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              errorHandler(operation,error);
              
          }];
}

+(void) retrieveHomeworkOnSuccess:(void(^)(id))success onFail:(void(^)(id,NSError *))errorHandler
{
    
    
    
}

+(void) retrieveTeachersOnSuccess:(void(^)(id))success onFail:(void(^)(id,NSError *))errorHandler
{

    
    
}


@end
