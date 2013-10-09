//
//  HighScorePlayerStorage.h
//  MaxiYatzy
//
//  Created by Rikard Karlsson on 2013-08-13.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  HighScorePlayer;
@interface HighScorePlayerStorage : NSObject

-(void)savePlayer:(HighScorePlayer *)player;
-(void)deleteData;
-(HighScorePlayer *)getPlayerWithName:(NSString *)playerName;
-(NSString *)playerStoragePath;
-(BOOL)persist;

@end
