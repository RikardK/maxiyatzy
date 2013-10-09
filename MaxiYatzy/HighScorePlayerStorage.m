//
//  HighScorePlayerStorage.m
//  MaxiYatzy
//
//  Created by Rikard Karlsson on 2013-08-13.
//  Copyright (c) 2013 Rikard. All rights reserved.
//


// Want to create an array of NSDictionaries containing a high score player.

#import "HighScorePlayerStorage.h"
#import "HighScorePlayer.h"

@implementation HighScorePlayerStorage
{
    NSMutableDictionary *playerStorage;
}

-(id)init
{
    self = [super init];
    
    if (self) {
        playerStorage = [NSKeyedUnarchiver unarchiveObjectWithFile:[self playerStoragePath]];
        
        if (playerStorage == nil) {
            playerStorage = [NSMutableDictionary new];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(persist:)
                                                     name:@"SaveHighScore"
                                                   object:nil];
    
    }
    
    return self;
}

-(void)savePlayer:(HighScorePlayer *)player
{
    playerStorage[player.name] = player;
}

-(HighScorePlayer *)getPlayerWithName:(NSString *)name
{
    return playerStorage[name];
}

-(void)persist:(NSNotification *)notification
{
    [NSKeyedArchiver archiveRootObject:playerStorage toFile:[self playerStoragePath]];
}

-(BOOL)persist
{
    return [NSKeyedArchiver archiveRootObject:playerStorage toFile:[self playerStoragePath]];
}


-(NSString *)playerStoragePath
{
    NSString *directory = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES)[0];
    return [directory stringByAppendingString:@"player.data"];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
