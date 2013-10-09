//
//  HighScoreViewController.m
//  MaxiYatzy
//
//  Created by Rikard Karlsson on 2013-07-31.
//  Copyright (c) 2013 Rikard. All rights reserved.
//


#import "HighScoreViewController.h"
#import "HighScoreTableViewCell.h"
#import "HighScorePlayer.h"
#import "HighScorePlayerStorage.h"
#import "DBConnectionController.h"

#import "GlobalVariables.h"

@interface HighScoreViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    UITabBarItem *tbi;
    NSMutableArray *highScoreDataArray;
    NSDictionary *highScoreDataToPost;
    NSString *totalScoreString;
    NSMutableArray *documentIds;
    HighScorePlayerStorage *playerStorage;
    HighScorePlayer *player;
    DBConnectionController *DBConnection;
    UIAlertView *connectionFailureAlert;
}

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *highScoreLoadingIndicator;

@property (weak, nonatomic) IBOutlet UITableView *highScoreTableView;

@end

@implementation HighScoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        tbi = [self tabBarItem];
        [tbi setImage:[UIImage imageNamed:@"highScoreTabItemImage.png"]];
        [tbi setTitle:@"High Score"];
        highScoreDataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    DBConnection = [[DBConnectionController alloc] init];
    playerStorage = [[HighScorePlayerStorage alloc] init];
    
    UINib *nib = [UINib nibWithNibName:@"HighScoreTableViewCell" bundle:nil];
    
    self.backgroundImage.image = [UIImage imageNamed:@"highScoreBackgroundImage.png"];
    self.backgroundImage.contentMode = UIViewContentModeScaleToFill;
    self.highScoreTableView.backgroundColor = [UIColor colorWithRed:84.0 green:143.0 blue:239.0 alpha:0.0];
    
    self.highScoreTableView.delegate = self;
    self.highScoreTableView.dataSource = self;
    
    self.highScoreLoadingIndicator.hidesWhenStopped = YES;
    
    [self.highScoreTableView registerNib:nib forCellReuseIdentifier:@"HighScoreTableViewCell"];
    
    connectionFailureAlert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"Could not load high score data." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Try again", nil];
    
    [self.view addSubview:self.highScoreTableView];
    
    [self getAllHighScoreDataOnLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    NSDictionary *dictionary = [[NSDictionary alloc] init];
    NSString *path = [playerStorage playerStoragePath];
    
    if ([highScoreDataArray count] == 0) {
        [self performSelectorOnMainThread:@selector(startAnimating) withObject:nil waitUntilDone:NO];
    }
    
    dictionary = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    player = [dictionary objectForKey:playerName];
    
    
    NSData *imageData = UIImageJPEGRepresentation(player.image, 0.1);
    NSString *imageString = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    if (![player.name isEqualToString:@""] && player.name) {
        highScoreDataToPost = [[NSDictionary alloc] initWithObjectsAndKeys:player.name, @"name", player.score, @"score", imageString, @"image", nil];
        
        [highScoreDataArray addObject:highScoreDataToPost];
        [DBConnection postHighScoreData:highScoreDataToPost onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
            if (response == nil) {
                if (error) {
                    [self performSelectorOnMainThread:@selector(stopAnimating:) withObject:@"error" waitUntilDone:NO];
                }
            } else {
                [self performSelectorOnMainThread:@selector(stopAnimating:) withObject:nil waitUntilDone:NO];
            }
        }];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [playerStorage deleteData];
}


-(void)getAllHighScoreDataOnLoad
{
    [self performSelectorOnMainThread:@selector(startAnimating) withObject:nil waitUntilDone:NO];

    
    [DBConnection getHighScoreDataOnLoadOnCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (response == nil) {
            if (error) {
                [self performSelectorOnMainThread:@selector(stopAnimating:) withObject:@"error" waitUntilDone:NO];
            }
        } else {
            NSMutableDictionary *fetchedData = [[NSMutableDictionary alloc] init];
            fetchedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSArray *rows = [fetchedData objectForKey:@"rows"];
            
            if ([rows count] > 0) {
                for (NSDictionary *dict in rows) {
                    NSString *idOfDocument = [dict objectForKey:@"id"];
                    [DBConnection getHighScoreDocumentWithId:idOfDocument onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
                        if (response == nil) {
                            if (error) {
                                [connectionFailureAlert show];
                                [self performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:NO];
                            }
                        } else {
                            NSMutableDictionary *highScoreDocumentData = [[NSMutableDictionary alloc] init];
                            highScoreDocumentData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                            
                            if (highScoreDocumentData) {
                                [highScoreDataArray addObject:highScoreDocumentData];
                                [self performSelectorOnMainThread:@selector(stopAnimating:) withObject:nil waitUntilDone:NO];
                            }
                        }
                    }];
                }
            }
            
        }
    }];
}


-(void)startAnimating
{
    [self.highScoreLoadingIndicator startAnimating];
}

-(void)stopAnimating:(id)obj
{
    [self.highScoreLoadingIndicator stopAnimating];
    [self.highScoreTableView reloadData];
    
    if (obj) {
        [connectionFailureAlert show];
    }
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self getAllHighScoreDataOnLoad];
    }
}


#pragma mark - Sort array, descending order for score
-(NSArray *)sortArray:(NSMutableArray *)arrayToSort
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"score" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [arrayToSort sortedArrayUsingDescriptors:sortDescriptors];
    return sortedArray;
}


#pragma mark - UITableViewDataSource protocol methods


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [highScoreDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HighScoreTableViewCell *highScoreCell = [tableView dequeueReusableCellWithIdentifier:@"HighScoreTableViewCell"
                                                                            forIndexPath:indexPath];
    NSArray *highScoreDataArraySorted = [self sortArray:highScoreDataArray];
    HighScorePlayer *highScorePlayer = [[HighScorePlayer alloc] initWithPlayerName:[[highScoreDataArraySorted objectAtIndex:indexPath.row] objectForKey:@"name"] score:[[highScoreDataArraySorted objectAtIndex:indexPath.row] objectForKey:@"score"] image:[[highScoreDataArraySorted objectAtIndex:indexPath.row] objectForKey:@"image"]];
    
    NSData *imageDataFromBase64String = [[NSData alloc] initWithBase64EncodedString:[[highScoreDataArraySorted objectAtIndex:indexPath.row] objectForKey:@"image"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *playerImage = [UIImage imageWithData:imageDataFromBase64String];
    
    
    highScoreCell.position.text = [NSString stringWithFormat:@"%d.", [indexPath row] + 1];
    highScoreCell.playerName.text = highScorePlayer.name;
    highScoreCell.playerScore.text = [NSString stringWithFormat: @"%@", highScorePlayer.score];
    highScoreCell.playerImage.image = playerImage;
    highScoreCell.backgroundColor = [UIColor colorWithRed:84.0 green:143.0 blue:239.0 alpha:0.0];
    highScoreCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return highScoreCell;
}

@end
