//
//  NetworkService.m
//  BIS app
//
//  Created by phillips on 8/14/14.
//  Copyright (c) 2014 ICEHOUSE-internship. All rights reserved.
//

#import <AFNetworking.h>
#import <XMLDictionary.h>
#import "NetworkService.h"
#import "UserService.h"

@implementation NetworkService

+(void) loginWithData:(NSDictionary *)loginData OnSuccess:(void(^)(id))success onFail:(void(^)(id,NSError *))errorHandler
{
    
    NSURL *baseURL = [NSURL URLWithString:@"http://203.153.99.219/"];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    
    [manager POST:@"/bisdev/login-api.php"
       parameters:loginData
          success:^(AFHTTPRequestOperation *operation, NSXMLParser *responseParser){
              
              NSDictionary *responseObject = [NSDictionary dictionaryWithXMLParser:responseParser];
              success(responseObject);
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              errorHandler(operation,error);
              
          }];
}

+(void) retrieveHomeworkOnSuccess:(void(^)(id responseObject))success onFail:(void(^)(id operation,NSError *error))errorHandler
{
    
    
    NSURL *baseURL = [NSURL URLWithString:@"http://fauxhw.appspot.com"];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject: @"text/html"];
    
    NSString *userID = [UserService retrieveUserID];
    
    NSString *url = [NSString stringWithFormat: @"/homework/list/%@",userID];
    
    [manager GET:url
       parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject){
              
              success(responseObject);
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              errorHandler(operation,error);
              
          }];
    
}

+(void) retrieveTeachersOnSuccess:(void(^)(id responseObject))success onFail:(void(^)(id operation,NSError *error))errorHandler
{

    NSURL *baseURL = [NSURL URLWithString:@"http://fauxhw.appspot.com"];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject: @"text/html"];
    
    NSString *userID = [UserService retrieveUserID];
    
    NSString *url = [NSString stringWithFormat: @"/teacher/list/%@",userID];
    
    [manager GET:url
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject){
             
             success(responseObject);
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             errorHandler(operation,error);
             
         }];
}


@end
