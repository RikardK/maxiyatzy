//
//  DBConnectionController.m
//  MaxiYatzy
//
//  Created by Rikard Karlsson on 2013-09-01.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import "DBConnectionController.h"

NSString * const dataBaseURL = @"http://rkdev.iriscouch.com/maxiyatzyhighscore/";

@implementation DBConnectionController
{
    NSOperationQueue *queue;
}

-(void)postHighScoreData:(NSDictionary *)scoreData onCompletion:(OnCompletion)callback
{
    [self connectToDbWithMethod:@"POST" data:scoreData stringToAppendToURL:@"" onCompletion:callback];
}

-(void)getHighScoreDataOnLoadOnCompletion:(OnCompletion)callback
{
    [self connectToDbWithMethod:@"GET" data:nil stringToAppendToURL:@"_all_docs" onCompletion:callback];
}

-(void)getHighScoreDocumentWithId:(NSString *)documentId onCompletion:(OnCompletion)callback
{
    [self connectToDbWithMethod:@"GET" data:nil stringToAppendToURL:documentId onCompletion:callback];
}


-(void)connectToDbWithMethod:(NSString *)httpMethod data:(NSDictionary *)scoreData stringToAppendToURL:(NSString *)stringToAppend onCompletion:(OnCompletion)callback
{
    queue = [[NSOperationQueue alloc] init];
    NSURL *url = [NSURL URLWithString:[dataBaseURL stringByAppendingString:stringToAppend]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setTimeoutInterval:10];
    
    if ([httpMethod isEqualToString:@"POST"]) {
        NSError *error;
        NSData *data = [NSJSONSerialization dataWithJSONObject:scoreData options:0 error:&error];
        [request setHTTPBody:data];
    }
    
    [request setHTTPMethod:httpMethod];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:callback];
}

@end
