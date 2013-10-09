 //
//  Dices.m
//  MaxiYatzy
//
//  Created by Rikard Karlsson on 2013-08-14.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import "Dices.h"

@implementation Dices


-(id)init
{
    self = [super init];
    
    if (self) {
        self.firstDice = [self withValue:[NSNumber numberWithInt:1]
                                   image:[UIImage imageNamed:@"dice1.png"]
                             chosenImage:[UIImage imageNamed:@"dice1chosen.png"]];
        
        self.secondDice = [self withValue:[NSNumber numberWithInt:2]
                                   image:[UIImage imageNamed:@"dice2.png"]
                             chosenImage:[UIImage imageNamed:@"dice2chosen.png"]];
        
        self.thirdDice = [self withValue:[NSNumber numberWithInt:3]
                                   image:[UIImage imageNamed:@"dice3.png"]
                             chosenImage:[UIImage imageNamed:@"dice3chosen.png"]];
        
        self.fourthDice = [self withValue:[NSNumber numberWithInt:4]
                                   image:[UIImage imageNamed:@"dice4.png"]
                             chosenImage:[UIImage imageNamed:@"dice4chosen.png"]];
        
        self.fifthDice = [self withValue:[NSNumber numberWithInt:5]
                                   image:[UIImage imageNamed:@"dice5.png"]
                             chosenImage:[UIImage imageNamed:@"dice5chosen.png"]];
        
        self.sixthDice = [self withValue:[NSNumber numberWithInt:6]
                                   image:[UIImage imageNamed:@"dice6.png"]
                             chosenImage:[UIImage imageNamed:@"dice6chosen.png"]];
    }
    
    return self;
}

-(NSDictionary *)withValue:(NSNumber *)value image:(UIImage *)image chosenImage:(UIImage *)chosenImage
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:value, image, chosenImage, nil]
                                                           forKeys:[NSArray arrayWithObjects:@"value", @"diceImage", @"diceChosenImage", nil]];
    
    return dictionary;
}

@end
