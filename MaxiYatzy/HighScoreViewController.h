//
//  HighScoreViewController.h
//  MaxiYatzy
//
//  Created by Rikard Karlsson on 2013-07-31.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OnCompletion)(NSURLResponse *response, NSData *data, NSError *error);

@interface HighScoreViewController : UIViewController

-(NSArray *)sortArray:(NSMutableArray *)arrayToSort;

@end

