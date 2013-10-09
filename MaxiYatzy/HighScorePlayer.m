//
//  HighScorePlayer.m
//  MaxiYatzy
//
//  Created by Rikard Karlsson on 2013-08-13.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import "HighScorePlayer.h"

@implementation HighScorePlayer

-(id)initWithPlayerName:(NSString *)name score:(NSNumber *)score image:(UIImage *)image
{
    self = [super init];
    
    if (self) {
        self.name = name;
        self.score = score;
        self.image = image;
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.score forKey:@"score"];
    [aCoder encodeObject:self.image forKey:@"image"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.score = [aDecoder decodeObjectForKey:@"score"];
        self.image = [aDecoder decodeObjectForKey:@"image"];
    }
    return self;
}

@end
