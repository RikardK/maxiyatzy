//
//  HighScorePlayer.h
//  MaxiYatzy
//
//  Created by Rikard Karlsson on 2013-08-13.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HighScorePlayer : NSObject <NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic) NSNumber *score;
@property (strong, nonatomic) UIImage *image;

-(id)initWithPlayerName:(NSString *)name score:(NSNumber *)score image:(UIImage *)image;

@end
