//
//  HighScoreTableViewCell.h
//  MaxiYatzy
//
//  Created by Rikard Karlsson on 2013-08-13.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HighScoreTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *position;
@property (weak, nonatomic) IBOutlet UILabel *playerName;
@property (weak, nonatomic) IBOutlet UILabel *playerScore;
@property (weak, nonatomic) IBOutlet UIImageView *playerImage;


@end
