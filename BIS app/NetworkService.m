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

NSString * const kBaseURLString = @"http://203.153.99.219/";
NSString * const kLoginPathString = @"/bisdev/login-api.php";
NSString * const kHomeworkPathString = @"/bisdev/hw-api.php?q=getCurrentHomeworkList";
NSString * const kTeacherEmailsPathString = @"/bisdev/hw-api.php?q=getEmailList";

@implementation NetworkService

+(void) loginWithData:(NSDictionary *)loginData OnSuccess:(void(^)(id))success onFail:(void(^)(id,NSError *))errorHandler
{
    
    NSURL *baseURL = [NSURL URLWithString:kBaseURLString];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    
    [manager POST:kLoginPathString
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
    
    
    NSURL *baseURL = [NSURL URLWithString:kBaseURLString];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    
    [manager GET:kHomeworkPathString
       parameters:nil
          success:^(AFHTTPRequestOperation *operation, NSXMLParser *responseParser){
              
              NSDictionary *responseObject = [NSDictionary dictionaryWithXMLParser:responseParser];
              success(responseObject);
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              errorHandler(operation,error);
              
          }];
    
}

+(void) retrieveTeachersOnSuccess:(void(^)(id responseObject))success onFail:(void(^)(id operation,NSError *error))errorHandler
{

    NSURL *baseURL = [NSURL URLWithString:kTeacherEmailsPathString];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    
    [manager GET:kTeacherEmailsPathString
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, NSXMLParser *responseParser){
             
             NSDictionary *responseObject = [NSDictionary dictionaryWithXMLParser:responseParser];
             success(responseObject);
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             errorHandler(operation,error);
             
         }];
}


@end
