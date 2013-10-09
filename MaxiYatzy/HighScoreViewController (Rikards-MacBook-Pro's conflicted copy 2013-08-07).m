//
//  HighScoreViewController.m
//  MaxiYatzy
//
//  Created by Rikard Karlsson on 2013-07-31.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

NSString * const dataBaseURL = @"http://127.0.0.1:5984/maxiyatzyhighscore/";

#import "HighScoreViewController.h"
#import "GlobalVariables.h"

@interface HighScoreViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UITabBarItem *tbi;
    NSMutableArray *highScoreDataArray;
    NSDictionary *highScoreData;
    UITableView *highScoreTableView;
    
    NSOperationQueue *queue;
}

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
    
    highScoreTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, 305, 320) style:UITableViewStylePlain];
    highScoreTableView.delegate = self;
    highScoreTableView.dataSource = self;
    
    [self.view addSubview:highScoreTableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    if (!([playerName isEqualToString:@""])) {
        highScoreData = [[NSDictionary alloc] initWithObjectsAndKeys:playerName, @"name", [NSString stringWithFormat:@"%d", totalScoreValueGlobal], @"score", nil];
        [highScoreDataArray addObject:highScoreData];
        [self postHighScoreData:highScoreData onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
            NSMutableDictionary *savedData = [[NSMutableDictionary alloc] init];
            savedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSLog(@"Data: %@", savedData);
        }];
        [highScoreTableView reloadData];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    playerName = @"";
    playerAvatar = nil;
}


-(void)postHighScoreData:(NSDictionary *)scoreData onCompletion:(OnCompletion)callback
{
    queue = [[NSOperationQueue alloc] init];
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:scoreData options:0 error:&error];
    NSURL *url = [NSURL URLWithString:dataBaseURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/xml; application/json; charset=utf-8" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:data];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:callback];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [highScoreDataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    NSLog(@"%d", [indexPath row]);
    
    
    // Sorting array for highest score.
    if ([highScoreDataArray count] > 1) {
        for (int i = 0; i < [highScoreDataArray count]; i++) {
            for (int j = i+1; j < [highScoreDataArray count]; j++) {
                NSLog(@"%d, %d", [[[highScoreDataArray objectAtIndex:i] valueForKey:@"score"] intValue], [[[highScoreDataArray objectAtIndex:j] valueForKey:@"score"] intValue]);
                if ([[[highScoreDataArray objectAtIndex:i] valueForKey:@"score"] intValue] < [[[highScoreDataArray objectAtIndex:j] valueForKey:@"score"] intValue]) {
                    [highScoreDataArray exchangeObjectAtIndex:i withObjectAtIndex:j];
                }
            }
        }
    }
    
    // image
//    cell.imageView.image = playerAvatar;
    cell.textLabel.text = [[[highScoreDataArray objectAtIndex:[indexPath row]] valueForKey:@"name"] stringByAppendingString:[NSString stringWithFormat:@" - %@", [[highScoreDataArray objectAtIndex:[indexPath row]] valueForKey:@"score"]]];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;


    return cell;
}


@end
