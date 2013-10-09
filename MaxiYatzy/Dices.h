//
//  Dices.h
//  MaxiYatzy
//
//  Created by Rikard Karlsson on 2013-08-14.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dices : NSObject

@property (nonatomic, strong) NSDictionary *firstDice;
@property (nonatomic, strong) NSDictionary *secondDice;
@property (nonatomic, strong) NSDictionary *thirdDice;
@property (nonatomic, strong) NSDictionary *fourthDice;
@property (nonatomic, strong) NSDictionary *fifthDice;
@property (nonatomic, strong) NSDictionary *sixthDice;

-(NSDictionary *)withValue:(NSNumber *)value image:(UIImage *)image chosenImage:(UIImage *)chosenImage;

@end
