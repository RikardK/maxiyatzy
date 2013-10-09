//
//  throwDicesViewController.h
//  MaxiYatzy
//
//  Created by Rikard Karlsson on 7/22/13.
//  Copyright (c) 2013 Rikard. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "GlobalVariables.h"

@interface throwDicesViewController : UIViewController

-(void)resetThrowDicesView;
-(void)diceWasChosen:(UIImageView *)diceImageView forButton:(UIButton *)button;
-(void)throwDices;
-(NSArray *)sortArrayOfDices;
-(void)updateScoreSheetForItem:(UIButton *)button withScore:(int)scoreForItem forSection:(int)section;
-(void)updateScoreSheetForItem:(UIButton *)button;
-(void)checkScore:(int)theScore forItem:(UIButton *)button forSection:(int)section;
-(int)scoreForItem:(UIButton *)button withValue:(int)val;
-(NSArray *)sortArrayOfPairs;
-(void)disableAllButtons;
-(void)enableAllButtonsThatShouldBeEnabled;
-(void)restartGame;
-(void)saveScore;
-(void)setImageForDice:(NSMutableArray *)arrayOfArguments;
-(NSMutableArray *)createArrayOfArgumentsForDiceImageView:(UIImageView *)diceImageView;

@end
