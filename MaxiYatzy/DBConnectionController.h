//
//  DBConnectionController.h
//  MaxiYatzy
//
//  Created by Rikard Karlsson on 2013-09-01.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^OnCompletion)(NSURLResponse *response, NSData *data, NSError *error);

@interface DBConnectionController : NSObject


-(void)postHighScoreData:(NSDictionary *)highScoreData onCompletion:(OnCompletion)callback;
-(void)getHighScoreDataOnLoadOnCompletion:(OnCompletion)callback;
-(void)getHighScoreDocumentWithId:(NSString *)documentId onCompletion:(OnCompletion)callback;
-(void)connectToDbWithMethod:(NSString *)httpMethod data:(NSDictionary *)scoreData stringToAppendToURL:(NSString *)stringToAppend onCompletion:(OnCompletion)callback;
 

@end

