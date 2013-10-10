//
//  throwDicesViewController.m
//  MaxiYatzy
//
//  Created by Rikard Karlsson on 7/22/13.
//  Copyright (c) 2013 Rikard. All rights reserved.
//


// Constants
static NSString *const qmd = @"questionMarkDice.png";

#import "throwDicesViewController.h"
#import "saveHighScoreViewController.h"
#import "Dices.h"

@interface throwDicesViewController () <UITabBarControllerDelegate, UINavigationBarDelegate, UIAlertViewDelegate>
{
    int numberOfThrows;
    NSArray *dices;
    NSArray *thrownDices;
    NSMutableArray *tempDices;
    NSMutableArray *imagesOfDices;
    NSMutableArray *randomOrderOfImagesForDices;
    NSMutableArray *dicesImageViewArray;
    NSNumber *count;
    
    Dices *dicesDictionary;
    
    NSString *valueOfDicesString;
    
    NSDictionary *diceOne;
    NSDictionary *diceTwo;
    NSDictionary *diceThree;
    NSDictionary *diceFour;
    NSDictionary *diceFive;
    NSDictionary *diceSix;
    
    NSNumber *dice1value;
    NSNumber *dice2value;
    NSNumber *dice3value;
    NSNumber *dice4value;
    NSNumber *dice5value;
    NSNumber *dice6value;
    
    UIImage *diceOneImage;
    UIImage *diceOneChosenImage;
    UIImage *diceTwoImage;
    UIImage *diceTwoChosenImage;
    UIImage *diceThreeImage;
    UIImage *diceThreeChosenImage;
    UIImage *diceFourImage;
    UIImage *diceFourChosenImage;
    UIImage *diceFiveImage;
    UIImage *diceFiveChosenImage;
    UIImage *diceSixImage;
    UIImage *diceSixChosenImage;
    
    UIImageView *scoreSheetHeaderImage;
    UIImageView *scoreSheetScrollViewBackgroundImage;

    UITabBarItem *tbi;
    
    NSMutableArray *upperSectionData;
    NSMutableArray *lowerSectionData;
    NSMutableArray *totalSectionData;
    NSMutableArray *valueOfPairsArray;
    NSMutableArray *valueOf3OfAKindsArray;
    NSArray *arrayOfButtons;
    NSMutableArray *arrayOfButtonsAlreadyUsed;
    NSArray *scoreLabels;
    
    UIButton *onesButton;
    UIButton *twosButton;
    UIButton *threesButton;
    UIButton *foursButton;
    UIButton *fivesButton;
    UIButton *sixesButton;
    UILabel *upperSectionScore;
    UILabel *upperSectionBonus;
    UILabel *upperSectionTotal;
    UIButton *onePairButton;
    UIButton *twoPairsButton;
    UIButton *threePairsButton;
    UIButton *threeOfAKindButton;
    UIButton *fourOfAKindButton;
    UIButton *fiveOfAKindButton;
    UIButton *smallStraightButton;
    UIButton *largeStraightButton;
    UIButton *fullStraightButton;
    UIButton *fullHouseButton;
    UIButton *villaButton;
    UIButton *towerButton;
    UIButton *chanceButton;
    UIButton *yahtzeeButton;
    UILabel *lowerSectionScore;
    UILabel *upperSectionScoreTotal;
    UILabel *totalScore;
    UIButton *restart;
    
    UIAlertView *restartAlert;
    UIAlertView *saveScoreOrNewGame;
    
    int score;
    int valueOfDice;
    int value;
    int value2;
    int value3;
    int value4;
    int scoreOfUpperSection;
    int scoreOfLowerSection;
    int totalScoreForLabel;
    int bonusRecieved;
    int tracker;
}

@property (weak, nonatomic) IBOutlet UIButton *dice1;
@property (weak, nonatomic) IBOutlet UIButton *dice2;
@property (weak, nonatomic) IBOutlet UIButton *dice3;
@property (weak, nonatomic) IBOutlet UIButton *dice4;
@property (weak, nonatomic) IBOutlet UIButton *dice5;
@property (weak, nonatomic) IBOutlet UIButton *dice6;
@property (weak, nonatomic) IBOutlet UIImageView *diceOneImageView;
@property (weak, nonatomic) IBOutlet UIImageView *diceTwoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *diceThreeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *diceFourImageView;
@property (weak, nonatomic) IBOutlet UIImageView *diceFiveImageView;
@property (weak, nonatomic) IBOutlet UIImageView *diceSixImageView;



@property (weak, nonatomic) IBOutlet UIButton *throwDicesButton;
@property (weak, nonatomic) IBOutlet UILabel *numberOfThrowsLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *waitForPlayerToSaveIndicator;
@property (weak, nonatomic) IBOutlet UIScrollView *scoreSheetScrollView;

- (IBAction)dice1chosen:(id)sender;
- (IBAction)dice2chosen:(id)sender;
- (IBAction)dice3chosen:(id)sender;
- (IBAction)dice4chosen:(id)sender;
- (IBAction)dice5chosen:(id)sender;
- (IBAction)dice6chosen:(id)sender;
- (IBAction)throwDicesWithButton:(id)sender;



@end

@implementation throwDicesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        tbi = [self tabBarItem];
        [tbi setTitle:@"Throw Dices"];
        [tbi setImage:[UIImage imageNamed:@"throwDicesTabBarImage.png"]];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
        
        dicesDictionary = [[Dices alloc] init];
    }
    return self;
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.waitForPlayerToSaveIndicator.hidesWhenStopped = YES;
    
    valueOfDicesString = @"";
    
    [self.scoreSheetScrollView setContentSize:CGSizeMake(239, 960)];
    
    scoreSheetHeaderImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 25, 239, 30)];
    scoreSheetHeaderImage.image = [UIImage imageNamed:@"scoreSheetHeader.png"];
    scoreSheetHeaderImage.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:scoreSheetHeaderImage];
    
    scoreSheetScrollViewBackgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 239, 1000)];
    scoreSheetScrollViewBackgroundImage.image = [UIImage imageNamed:@"ScoreSheetBackgroundImage.png"];
    scoreSheetScrollViewBackgroundImage.contentMode = UIViewContentModeScaleToFill;
    
    [self.scoreSheetScrollView addSubview:scoreSheetScrollViewBackgroundImage];
    
    
    
    self.numberOfThrowsLabel.text = @"'SHAKE'";
    count = [NSNumber numberWithInt:0];
    
    diceOne = dicesDictionary.firstDice;
    diceTwo = dicesDictionary.secondDice;
    diceThree = dicesDictionary.thirdDice;
    diceFour = dicesDictionary.fourthDice;
    diceFive = dicesDictionary.fifthDice;
    diceSix = dicesDictionary.sixthDice;
    
    thrownDices = [NSArray arrayWithObjects:diceOne, diceTwo, diceThree, diceFour, diceFive, diceSix, nil];
    
    imagesOfDices = [[NSMutableArray alloc] initWithObjects:
                     [diceOne objectForKey:@"diceImage"],
                     [diceTwo objectForKey:@"diceImage"],
                     [diceThree objectForKey:@"diceImage"],
                     [diceFour objectForKey:@"diceImage"],
                     [diceFive objectForKey:@"diceImage"],
                     [diceSix objectForKey:@"diceImage"],
                     nil];
    
    dicesImageViewArray = [[NSMutableArray alloc] initWithObjects:self.diceOneImageView, self.diceTwoImageView, self.diceThreeImageView, self.diceFourImageView, self.diceFiveImageView, self.diceSixImageView, nil];
    
    
    dices = [NSArray arrayWithObjects:self.dice1, self.dice2, self.dice3, self.dice4, self.dice5, self.dice6, nil];
    for (int i=0; i<6; i++) {
        UIImageView *currentImageView = [dicesImageViewArray objectAtIndex:i];
        currentImageView.image = [UIImage imageNamed:qmd];
    }
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:nil
                                                                            action:nil];
    
    restartAlert = [[UIAlertView alloc] initWithTitle:@"New Game"
                                              message:@"Are you sure you want to start a new game?"
                                             delegate:self
                                    cancelButtonTitle:@"Yes"
                                    otherButtonTitles:@"Cancel", nil];

    bonusRecieved = 0;
    scoreOfUpperSection = 0;
    scoreOfLowerSection = 0;
    totalScoreForLabel = 0;
    
    
#pragma mark - Score sheet buttons
    
    onesButton = [[UIButton alloc] initWithFrame:CGRectMake(185, 30, 50, 29)];
    [onesButton setTitle:@"0" forState:UIControlStateNormal];
    [onesButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [onesButton setUserInteractionEnabled:YES];
    [onesButton addTarget:self action:@selector(onesButton:) forControlEvents:UIControlEventTouchUpInside];
    
    twosButton = [[UIButton alloc] initWithFrame:CGRectMake(185, 61, 50, 29)];
    [twosButton setTitle:@"0" forState:UIControlStateNormal];
    [twosButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [twosButton setUserInteractionEnabled:YES];
    [twosButton addTarget:self action:@selector(twosButton:) forControlEvents:UIControlEventTouchUpInside];
    
    threesButton = [[UIButton alloc] initWithFrame:CGRectMake(185, 91, 50, 29)];
    [threesButton setTitle:@"0" forState:UIControlStateNormal];
    [threesButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [threesButton setUserInteractionEnabled:YES];
    [threesButton addTarget:self action:@selector(threesButton:) forControlEvents:UIControlEventTouchUpInside];
    
    foursButton = [[UIButton alloc] initWithFrame:CGRectMake(185, 121, 50, 29)];
    [foursButton setTitle:@"0" forState:UIControlStateNormal];
    [foursButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [foursButton setUserInteractionEnabled:YES];
    [foursButton addTarget:self action:@selector(foursButton:) forControlEvents:UIControlEventTouchUpInside];
    
    fivesButton = [[UIButton alloc] initWithFrame:CGRectMake(185, 151, 50, 29)];
    [fivesButton setTitle:@"0" forState:UIControlStateNormal];
    [fivesButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fivesButton setUserInteractionEnabled:YES];
    [fivesButton addTarget:self action:@selector(fivesButton:) forControlEvents:UIControlEventTouchUpInside];
    
    sixesButton = [[UIButton alloc] initWithFrame:CGRectMake(185, 180, 50, 29)];
    [sixesButton setTitle:@"0" forState:UIControlStateNormal];
    [sixesButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sixesButton setUserInteractionEnabled:YES];
    [sixesButton addTarget:self action:@selector(sixesButton:) forControlEvents:UIControlEventTouchUpInside];
    
    upperSectionScore = [[UILabel alloc] initWithFrame:CGRectMake(184, 211, 50, 29)];
    upperSectionScore.textAlignment = NSTextAlignmentCenter;
    [upperSectionScore setText:@"0"];
    [upperSectionScore setTextColor:[UIColor blackColor]];
    
    upperSectionBonus = [[UILabel alloc] initWithFrame:CGRectMake(184, 242, 50, 29)];
    upperSectionBonus.textAlignment = NSTextAlignmentCenter;
    [upperSectionBonus setText:@"0"];
    [upperSectionBonus setTextColor:[UIColor redColor]];
    
    upperSectionTotal = [[UILabel alloc] initWithFrame:CGRectMake(184, 273, 50, 29)];
    upperSectionTotal.textAlignment = NSTextAlignmentCenter;
    [upperSectionTotal setText:@"0"];
    [upperSectionTotal setTextColor:[UIColor blackColor]];
    
    onePairButton = [[UIButton alloc] initWithFrame:CGRectMake(185, 347, 50, 29)];
    [onePairButton setTitle:@"0" forState:UIControlStateNormal];
    [onePairButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [onePairButton setUserInteractionEnabled:YES];
    [onePairButton addTarget:self action:@selector(one1Pair:) forControlEvents:UIControlEventTouchUpInside];
    
    twoPairsButton = [[UIButton alloc] initWithFrame:CGRectMake(185, 378, 50, 29)];
    [twoPairsButton setTitle:@"0" forState:UIControlStateNormal];
    [twoPairsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [twoPairsButton setUserInteractionEnabled:YES];
    [twoPairsButton addTarget:self action:@selector(one2Pairs:) forControlEvents:UIControlEventTouchUpInside];
    
    threePairsButton = [[UIButton alloc] initWithFrame:CGRectMake(185, 408, 50, 29)];
    [threePairsButton setTitle:@"0" forState:UIControlStateNormal];
    [threePairsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [threePairsButton setUserInteractionEnabled:YES];
    [threePairsButton addTarget:self action:@selector(one3Pairs:) forControlEvents:UIControlEventTouchUpInside];
    
    threeOfAKindButton = [[UIButton alloc] initWithFrame:CGRectMake(185, 438, 50, 29)];
    [threeOfAKindButton setTitle:@"0" forState:UIControlStateNormal];
    [threeOfAKindButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [threeOfAKindButton setUserInteractionEnabled:YES];
    [threeOfAKindButton addTarget:self action:@selector(one3OfAKind:) forControlEvents:UIControlEventTouchUpInside];
    
    fourOfAKindButton = [[UIButton alloc] initWithFrame:CGRectMake(185, 469, 50, 29)];
    [fourOfAKindButton setTitle:@"0" forState:UIControlStateNormal];
    [fourOfAKindButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fourOfAKindButton setUserInteractionEnabled:YES];
    [fourOfAKindButton addTarget:self action:@selector(one4OfAKind:) forControlEvents:UIControlEventTouchUpInside];
    
    fiveOfAKindButton = [[UIButton alloc] initWithFrame:CGRectMake(185, 499, 50, 29)];
    [fiveOfAKindButton setTitle:@"0" forState:UIControlStateNormal];
    [fiveOfAKindButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fiveOfAKindButton setUserInteractionEnabled:YES];
    [fiveOfAKindButton addTarget:self action:@selector(one5OfAKind:) forControlEvents:UIControlEventTouchUpInside];
    
    smallStraightButton = [[UIButton alloc] initWithFrame:CGRectMake(185, 530, 50, 29)];
    [smallStraightButton setTitle:@"0" forState:UIControlStateNormal];
    [smallStraightButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [smallStraightButton setUserInteractionEnabled:YES];
    [smallStraightButton addTarget:self action:@selector(oneSmallStraight:) forControlEvents:UIControlEventTouchUpInside];
    
    largeStraightButton = [[UIButton alloc] initWithFrame:CGRectMake(185, 561, 50, 29)];
    [largeStraightButton setTitle:@"0" forState:UIControlStateNormal];
    [largeStraightButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [largeStraightButton setUserInteractionEnabled:YES];
    [largeStraightButton addTarget:self action:@selector(oneLargeStraight:) forControlEvents:UIControlEventTouchUpInside];
    
    fullStraightButton = [[UIButton alloc] initWithFrame:CGRectMake(185, 592, 50, 29)];
    [fullStraightButton setTitle:@"0" forState:UIControlStateNormal];
    [fullStraightButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fullStraightButton setUserInteractionEnabled:YES];
    [fullStraightButton addTarget:self action:@selector(oneFullStraight:) forControlEvents:UIControlEventTouchUpInside];
    
    fullHouseButton = [[UIButton alloc] initWithFrame:CGRectMake(185, 622, 50, 29)];
    [fullHouseButton setTitle:@"0" forState:UIControlStateNormal];
    [fullHouseButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fullHouseButton setUserInteractionEnabled:YES];
    [fullHouseButton addTarget:self action:@selector(oneFullHouse:) forControlEvents:UIControlEventTouchUpInside];
    
    villaButton = [[UIButton alloc] initWithFrame:CGRectMake(185, 653, 50, 29)];
    [villaButton setTitle:@"0" forState:UIControlStateNormal];
    [villaButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [villaButton setUserInteractionEnabled:YES];
    [villaButton addTarget:self action:@selector(oneVilla:) forControlEvents:UIControlEventTouchUpInside];
    
    towerButton = [[UIButton alloc] initWithFrame:CGRectMake(185, 683, 50, 29)];
    [towerButton setTitle:@"0" forState:UIControlStateNormal];
    [towerButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [towerButton setUserInteractionEnabled:YES];
    [towerButton addTarget:self action:@selector(oneTower:) forControlEvents:UIControlEventTouchUpInside];
    
    chanceButton = [[UIButton alloc] initWithFrame:CGRectMake(185, 714, 50, 29)];
    [chanceButton setTitle:@"0" forState:UIControlStateNormal];
    [chanceButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [chanceButton setUserInteractionEnabled:YES];
    [chanceButton addTarget:self action:@selector(oneChance:) forControlEvents:UIControlEventTouchUpInside];
    
    yahtzeeButton = [[UIButton alloc] initWithFrame:CGRectMake(185, 744, 50, 29)];
    [yahtzeeButton setTitle:@"0" forState:UIControlStateNormal];
    [yahtzeeButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [yahtzeeButton setUserInteractionEnabled:YES];
    [yahtzeeButton addTarget:self action:@selector(oneYahtzee:) forControlEvents:UIControlEventTouchUpInside];
    
    lowerSectionScore = [[UILabel alloc] initWithFrame:CGRectMake(185, 815, 50, 29)];
    lowerSectionScore.textAlignment = NSTextAlignmentCenter;
    [lowerSectionScore setText:@"0"];
    [lowerSectionScore setTextColor:[UIColor blackColor]];
    
    upperSectionScoreTotal = [[UILabel alloc] initWithFrame:CGRectMake(185, 846, 50, 29)];
    upperSectionScoreTotal.textAlignment = NSTextAlignmentCenter;
    [upperSectionScoreTotal setText:@"0"];
    [upperSectionScoreTotal setTextColor:[UIColor blackColor]];
    
    totalScore = [[UILabel alloc] initWithFrame:CGRectMake(185, 877, 50, 29)];
    totalScore.textAlignment = NSTextAlignmentCenter;
    [totalScore setText:@"0"];
    [totalScore setTextColor:[UIColor blackColor]];
    
    restart = [[UIButton alloc] initWithFrame:CGRectMake(70, 925, 100, 40)];
    [restart setTitle:@"RESTART" forState:UIControlStateNormal];
    restart.titleLabel.font = [UIFont fontWithName:@"copperplate" size:18.0];
    [restart setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [restart setUserInteractionEnabled:YES];
    [restart addTarget:self action:@selector(restart:) forControlEvents:UIControlEventTouchUpInside];

    [self.scoreSheetScrollView addSubview:onesButton];
    [self.scoreSheetScrollView addSubview:twosButton];
    [self.scoreSheetScrollView addSubview:threesButton];
    [self.scoreSheetScrollView addSubview:foursButton];
    [self.scoreSheetScrollView addSubview:fivesButton];
    [self.scoreSheetScrollView addSubview:sixesButton];
    [self.scoreSheetScrollView addSubview:upperSectionScore];
    [self.scoreSheetScrollView addSubview:upperSectionBonus];
    [self.scoreSheetScrollView addSubview:upperSectionTotal];
    [self.scoreSheetScrollView addSubview:onePairButton];
    [self.scoreSheetScrollView addSubview:twoPairsButton];
    [self.scoreSheetScrollView addSubview:threePairsButton];
    [self.scoreSheetScrollView addSubview:threeOfAKindButton];
    [self.scoreSheetScrollView addSubview:fourOfAKindButton];
    [self.scoreSheetScrollView addSubview:fiveOfAKindButton];
    [self.scoreSheetScrollView addSubview:smallStraightButton];
    [self.scoreSheetScrollView addSubview:largeStraightButton];
    [self.scoreSheetScrollView addSubview:fullStraightButton];
    [self.scoreSheetScrollView addSubview:fullHouseButton];
    [self.scoreSheetScrollView addSubview:villaButton];
    [self.scoreSheetScrollView addSubview:towerButton];
    [self.scoreSheetScrollView addSubview:chanceButton];
    [self.scoreSheetScrollView addSubview:yahtzeeButton];
    [self.scoreSheetScrollView addSubview:lowerSectionScore];
    [self.scoreSheetScrollView addSubview:upperSectionScoreTotal];
    [self.scoreSheetScrollView addSubview:totalScore];
    [self.scoreSheetScrollView addSubview:restart];
    
    
    arrayOfButtons = [[NSArray alloc] initWithObjects:
                      onesButton,
                      twosButton,
                      threesButton,
                      foursButton,
                      fivesButton,
                      sixesButton,
                      onePairButton,
                      twoPairsButton,
                      threePairsButton,
                      threeOfAKindButton,
                      fourOfAKindButton,
                      fiveOfAKindButton,
                      smallStraightButton,
                      largeStraightButton,
                      fullStraightButton,
                      fullHouseButton,
                      villaButton,
                      towerButton,
                      chanceButton,
                      yahtzeeButton,
                      nil];
    
    arrayOfButtonsAlreadyUsed = [[NSMutableArray alloc] initWithObjects:nil];
    
    scoreLabels = [[NSArray alloc] initWithObjects:
                   upperSectionScore,
                   upperSectionBonus,
                   upperSectionTotal,
                   lowerSectionScore,
                   upperSectionScoreTotal,
                   totalScore,
                   nil];
    
    [self disableAllButtons];
}

-(void)resetThrowDicesView
{
    for (int i = 0; i < 6; i++) {
        UIButton *currentDice = [dices objectAtIndex:i];
        currentDice.selected = NO;
    }
    
    for (int i=0; i<6; i++) {
        UIImageView *currentImageView = [dicesImageViewArray objectAtIndex:i];
        currentImageView.alpha = 1;
        currentImageView.image = [UIImage imageNamed:qmd];
    }
    
    self.numberOfThrowsLabel.text = @"'SHAKE'";
    [self.throwDicesButton setTitle:@">OR CLICK<" forState:UIControlStateNormal];
    [self.throwDicesButton setUserInteractionEnabled:YES];
    [self.waitForPlayerToSaveIndicator stopAnimating];
    
    numberOfThrows = 0;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}


#pragma mark - Throwing and controlling the dices

-(NSMutableArray *)createArrayOfArgumentsForDiceImageView:(UIImageView *)diceImageView
{
    randomOrderOfImagesForDices = [[NSMutableArray alloc] init];
    tempDices = [[NSMutableArray alloc] initWithArray:imagesOfDices];
    
    int numberOfDicesLeft = 6;
    for (int i = 0; i < 6; i++) {
        int index = arc4random_uniform(numberOfDicesLeft);
        [randomOrderOfImagesForDices addObject:[tempDices objectAtIndex:index]];
        [tempDices removeObjectAtIndex:index];
        numberOfDicesLeft--;
    }
    
    diceImageView.animationImages = randomOrderOfImagesForDices;
    diceImageView.animationDuration = 0.21;
    diceImageView.animationRepeatCount = 4;
    [diceImageView startAnimating];
    NSMutableArray *arrayOfArguments = [[NSMutableArray alloc] initWithObjects:
                                        diceImageView,
                                        diceImageView.animationImages,
                                        nil];
    
    return arrayOfArguments;
}

-(void)throwDices
{
    if (numberOfThrows < 3) {
        if (!([[dices objectAtIndex:0] isSelected])) {
            UIImageView *dice1ImageView = [dicesImageViewArray objectAtIndex:0];
            [self performSelector:@selector(setImageForDice:)
                       withObject:[self createArrayOfArgumentsForDiceImageView:dice1ImageView]
                       afterDelay:0.84];
        }
        
        if (!([[dices objectAtIndex:1] isSelected])) {
            UIImageView *dice2ImageView = [dicesImageViewArray objectAtIndex:1];
            [self performSelector:@selector(setImageForDice:)
                       withObject:[self createArrayOfArgumentsForDiceImageView:dice2ImageView]
                       afterDelay:0.84];
        }
        
        if (!([[dices objectAtIndex:2] isSelected])) {
            UIImageView *dice3ImageView = [dicesImageViewArray objectAtIndex:2];
            [self performSelector:@selector(setImageForDice:)
                       withObject:[self createArrayOfArgumentsForDiceImageView:dice3ImageView]
                       afterDelay:0.84];
        }
        
        
        if (!([[dices objectAtIndex:3] isSelected])) {
            UIImageView *dice4ImageView = [dicesImageViewArray objectAtIndex:3];
            [self performSelector:@selector(setImageForDice:)
                       withObject:[self createArrayOfArgumentsForDiceImageView:dice4ImageView]
                       afterDelay:0.84];
        }
        
        if (!([[dices objectAtIndex:4] isSelected])) {
            UIImageView *dice5ImageView = [dicesImageViewArray objectAtIndex:4];
            [self performSelector:@selector(setImageForDice:)
                       withObject:[self createArrayOfArgumentsForDiceImageView:dice5ImageView]
                       afterDelay:0.84];
        }

        if (!([[dices objectAtIndex:5] isSelected])) {
            UIImageView *dice6ImageView = [dicesImageViewArray objectAtIndex:5];
            [self performSelector:@selector(setImageForDice:)
                       withObject:[self createArrayOfArgumentsForDiceImageView:dice6ImageView]
                       afterDelay:0.84];
        }
        
        numberOfThrows++;
        self.numberOfThrowsLabel.text = [NSString stringWithFormat:@"%d", numberOfThrows];
        [self.throwDicesButton setTitle:@"" forState:UIControlStateNormal];
        [self.throwDicesButton setUserInteractionEnabled:NO];
        
        if (numberOfThrows == 3) {
            [self.throwDicesButton setTitle:@"" forState:UIControlStateNormal];
            [self.numberOfThrowsLabel setText:@""];
            [self.waitForPlayerToSaveIndicator startAnimating];
        }
    }
    [self performSelector:@selector(enableAllButtonsThatShouldBeEnabled) withObject:nil afterDelay:0.9];
}

-(void)setImageForDice:(NSMutableArray *)arrayOfArguments
{
    UIImageView *imageView = [arrayOfArguments objectAtIndex:0];
    NSMutableArray *randomArrayOfImages = [arrayOfArguments objectAtIndex:1];
    [imageView stopAnimating];
    imageView.image = [randomArrayOfImages objectAtIndex:5];
    
    NSMutableArray *values = [[NSMutableArray alloc] init];

    for (int i = 0; i < 6; i++) {
        for (int j=0; j < 6; j++) {
            UIImageView *diceImage = [dicesImageViewArray objectAtIndex:i];
            if (diceImage.image == [[thrownDices objectAtIndex:j] valueForKey:@"diceImage"] || diceImage.image ==  [[thrownDices objectAtIndex:j] valueForKey:@"diceChosenImage"]) {
                NSNumber *tempNumber = [NSNumber numberWithInt:j+1];
                [values addObject:tempNumber];
            }
        }
    }
    
    NSString *tempString = [[NSString alloc] init];
    for (int i = 0; i < [values count]; i++) {
        tempString = [tempString stringByAppendingString:[[values objectAtIndex:i] stringValue]];
    }
    valueOfDicesString = tempString;
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) {
        [self throwDices];
    }
}

- (IBAction)throwDicesWithButton:(id)sender
{
    [self throwDices];
}

-(void)diceWasChosen:(UIImageView *)diceImageView forButton:(UIButton *)button
{
    for (int i = 0; i < 6; i++) {
        
        if ((diceImageView.image == [[thrownDices objectAtIndex:i] valueForKey:@"diceImage"]) || (diceImageView.image == [[thrownDices objectAtIndex:i] valueForKey:@"diceChosenImage"])) {
            if (button.selected == NO) {
                button.selected = YES;
                diceImageView.image = [[thrownDices objectAtIndex:i] valueForKey:@"diceChosenImage"];
                diceImageView.alpha = 0.7;
            } else {
                button.selected = NO;
                diceImageView.image = [[thrownDices objectAtIndex:i] valueForKey:@"diceImage"];
                diceImageView.alpha = 1;
            }
        }
    }
}

- (IBAction)dice1chosen:(id)sender {
    [self diceWasChosen:[dicesImageViewArray objectAtIndex:0] forButton:self.dice1];
}

- (IBAction)dice2chosen:(id)sender {
    [self diceWasChosen:[dicesImageViewArray objectAtIndex:1] forButton:self.dice2];
}

- (IBAction)dice3chosen:(id)sender {
    [self diceWasChosen:[dicesImageViewArray objectAtIndex:2] forButton:self.dice3];
}

- (IBAction)dice4chosen:(id)sender {
    [self diceWasChosen:[dicesImageViewArray objectAtIndex:3] forButton:self.dice4];
}

- (IBAction)dice5chosen:(id)sender {
    [self diceWasChosen:[dicesImageViewArray objectAtIndex:4] forButton:self.dice5];
}

- (IBAction)dice6chosen:(id)sender {
    [self diceWasChosen:[dicesImageViewArray objectAtIndex:5] forButton:self.dice6];
}


-(NSArray *)sortArrayOfDices
{
    NSMutableArray *arrayOfSortedDices = [[NSMutableArray alloc] initWithObjects: nil];
    for (int i = 0; i < 6; i++) {
        [arrayOfSortedDices addObject:[valueOfDicesString substringWithRange:NSMakeRange(i, 1)]];
    }
    
    for (int i = 0; i < 6; i++) {
        for (int j = i+1; j < 6; j++) {
            if ([[arrayOfSortedDices objectAtIndex:i] intValue]
                < [[arrayOfSortedDices objectAtIndex:j] intValue]) {
                [arrayOfSortedDices exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    return arrayOfSortedDices;
}



#pragma mark - Controlling buttons of the score sheet scroll view

-(void)disableAllButtons
{
    for (int i = 0; i < [arrayOfButtons count]; i++) {
        [[arrayOfButtons objectAtIndex:i] setUserInteractionEnabled:NO];
    }
}

-(void)enableAllButtonsThatShouldBeEnabled
{
    if (numberOfThrows < 3) {
        [self.throwDicesButton setTitle:@"ROLL" forState:UIControlStateNormal];
        [self.throwDicesButton setUserInteractionEnabled:YES];
        [self.view becomeFirstResponder];
    }
    if (![valueOfDicesString isEqualToString:@""]) {
        if ([arrayOfButtonsAlreadyUsed count] == 0) {
            for (int i = 0; i < [arrayOfButtons count]; i++) {
                [[arrayOfButtons objectAtIndex:i] setUserInteractionEnabled:YES];
            }
        } else {
            for (int i = 0; i < [arrayOfButtons count]; i++) {
                for (int j = 0; j < [arrayOfButtonsAlreadyUsed count]; j++) {
                    if ([[arrayOfButtonsAlreadyUsed objectAtIndex:j] isEqual:[arrayOfButtons objectAtIndex:i]]) {
                        [[arrayOfButtons objectAtIndex:i] setUserInteractionEnabled:NO];
                        break;
                    } else {
                        [[arrayOfButtons objectAtIndex:i] setUserInteractionEnabled:YES];
                    }
                }
            }
        }
    }
}


-(void)updateScoreSheetForItem:(UIButton *)button withScore:(int)scoreForItem forSection:(int)section
{
    [button setTitle:[NSString stringWithFormat:@"%d", scoreForItem] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [arrayOfButtonsAlreadyUsed addObject:button];
    
    [self disableAllButtons];
    [self resetThrowDicesView];
    
    totalScoreForLabel += scoreForItem;
    totalScore.text = [NSString stringWithFormat:@"%d", totalScoreForLabel];
    
    if (section == 0) {
        scoreOfUpperSection += scoreForItem;
        [upperSectionScore setText:[NSString stringWithFormat:@"%d", scoreOfUpperSection]];
        [upperSectionTotal setText:[NSString stringWithFormat:@"%d", scoreOfUpperSection]];
        [upperSectionScoreTotal setText:[NSString stringWithFormat:@"%d", scoreOfUpperSection]];
        
        if (scoreOfUpperSection > 83 && [upperSectionBonus.text isEqualToString:@"0"] && bonusRecieved == 0) {
            upperSectionBonus.text = @"100";
            upperSectionBonus.textColor = [UIColor greenColor];
            totalScoreForLabel += 100;
            scoreOfUpperSection += 100;
            upperSectionTotal.text = [NSString stringWithFormat:@"%d", scoreOfUpperSection];
            [upperSectionScoreTotal setText:[NSString stringWithFormat:@"%d", scoreOfUpperSection]];
            totalScore.text = [NSString stringWithFormat:@"%d", totalScoreForLabel];
            bonusRecieved = 1;
        } else if (bonusRecieved == 0) {
            upperSectionBonus.text = @"0";
            upperSectionBonus.textColor = [UIColor redColor];
        }
    } else {
        scoreOfLowerSection += scoreForItem;
        lowerSectionScore.text = [NSString stringWithFormat:@"%d", scoreOfLowerSection];
    }
    
    // Restart game when done? 20
    if ([arrayOfButtonsAlreadyUsed count] == 1) {
        saveScoreOrNewGame = [[UIAlertView alloc] initWithTitle:@"Save Score"
                                                        message:[NSString stringWithFormat:@"Would you like to save your score, %d?", [totalScore.text intValue]]
                                                       delegate:self
                                              cancelButtonTitle:@"Yes"
                                              otherButtonTitles:@"Restart Game", nil];
        [saveScoreOrNewGame show];
    }
    
}


-(void)updateScoreSheetForItem:(UIButton *)button
{
    [button setTitle:@"-" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [arrayOfButtonsAlreadyUsed addObject:button];
    
    [self disableAllButtons];
    [self resetThrowDicesView];
    
    if ([arrayOfButtonsAlreadyUsed count] == 1) {
        saveScoreOrNewGame = [[UIAlertView alloc] initWithTitle:@"Save Score"
                                                        message:[NSString stringWithFormat:@"Would you like to save your score, %d?", [totalScore.text intValue]]
                                                       delegate:self
                                              cancelButtonTitle:@"Yes"
                                              otherButtonTitles:@"Restart Game", nil];
        [saveScoreOrNewGame show];
    }
}

-(void)checkScore:(int)theScore forItem:(UIButton *)button forSection:(int)section
{
    if (theScore > 0) {
        [self updateScoreSheetForItem:button withScore:theScore forSection:section];
    } else {
        [self updateScoreSheetForItem:button];
    }
}

-(int)scoreForItem:(UIButton *)button withValue:(int)val
{
    score = 0;
    for (int i = 0; i<6; i++) {
        valueOfDice = [[valueOfDicesString substringWithRange:NSMakeRange(i, 1)] intValue];
        if (valueOfDice == val) {
            score += val;
        }
    }
    return score;
}

//own class??
#pragma mark - Buttons for updating the score sheet scroll view

- (IBAction)onesButton:(id)sender {
    [self scoreForItem:onesButton withValue:1];
    [self checkScore:score forItem:onesButton forSection:0];
}

-(IBAction)twosButton:(id)sender {
    [self scoreForItem:twosButton withValue:2];
    [self checkScore:score forItem:twosButton forSection:0];
}

-(IBAction)threesButton:(id)sender {
    [self scoreForItem:threesButton withValue:3];
    [self checkScore:score forItem:threesButton forSection:0];
}

-(IBAction)foursButton:(id)sender {
    [self scoreForItem:foursButton withValue:4];
    [self checkScore:score forItem:foursButton forSection:0];
}

-(IBAction)fivesButton:(id)sender {
    [self scoreForItem:fivesButton withValue:5];
    [self checkScore:score forItem:fivesButton forSection:0];
}

-(IBAction)sixesButton:(id)sender {
    [self scoreForItem:sixesButton withValue:6];
    [self checkScore:score forItem:sixesButton forSection:0];
}


-(NSArray *)sortArrayOfPairs
{
    valueOfPairsArray = [[NSMutableArray alloc] initWithObjects:nil];
    for (int i = 0; i < 5; i++) {
        value = [[valueOfDicesString substringWithRange:NSMakeRange(i, 1)] intValue];
        for (int j = i+1; j < 6; j++) {
            if (value == [[valueOfDicesString substringWithRange:NSMakeRange(j, 1)] intValue]) {
                
                NSNumber *valueOfPair = [NSNumber numberWithInt:value + [[valueOfDicesString substringWithRange:NSMakeRange(j, 1)] intValue]];
                
                if ([valueOfPairsArray count] < 1) {
                    [valueOfPairsArray addObject:valueOfPair];
                } else {
                    int dublett = 0;
                    for (int k = 0; k < [valueOfPairsArray count]; k++) {
                        
                        if ([valueOfPair intValue] == [[valueOfPairsArray objectAtIndex:k] intValue]) {
                            dublett = 1;
                            break;
                        }
                    }
                    if (dublett == 0) {
                        [valueOfPairsArray addObject:valueOfPair];
                    }
                }
                break;
            }
        }
    }
    for (int k = 0; k < [valueOfPairsArray count]; k++) {
        for (int l = k+1; l < [valueOfPairsArray count]; l++) {
            if ([[valueOfPairsArray objectAtIndex:k] intValue] < [[valueOfPairsArray objectAtIndex:l] intValue]) {
                [valueOfPairsArray exchangeObjectAtIndex:k withObjectAtIndex:l];
            }
        }
    }
    return  valueOfPairsArray;
}


-(IBAction)one1Pair:(id)sender {
    
    [self sortArrayOfPairs];
    
    if ([valueOfPairsArray count] > 0) {
        [self updateScoreSheetForItem:onePairButton withScore:[[valueOfPairsArray objectAtIndex:0] intValue] forSection:1];
    } else {
        [self updateScoreSheetForItem:onePairButton];
    }
}

-(IBAction)one2Pairs:(id)sender {
    
    [self sortArrayOfPairs];
    
    int valueOf2Pairs = 0;
    
    if ([valueOfPairsArray count] > 1) {
        for (int i = 0; i < 2; i++) {
            valueOf2Pairs += [[valueOfPairsArray objectAtIndex:i] intValue];
        }
        [self updateScoreSheetForItem:twoPairsButton withScore:valueOf2Pairs forSection:1];
    } else {
        [self updateScoreSheetForItem:twoPairsButton];
    }
}

-(IBAction)one3Pairs:(id)sender {
    
    [self sortArrayOfPairs];
    
    int valueOf3Pairs = 0;
    if ([valueOfPairsArray count] > 2) {
        for (int i = 0; i < 3; i++) {
            valueOf3Pairs += [[valueOfPairsArray objectAtIndex:i] intValue];
        }
        [self updateScoreSheetForItem:threePairsButton withScore:valueOf3Pairs forSection:1];
    } else {
        [self updateScoreSheetForItem:threePairsButton];
    }
    
}

-(IBAction)one3OfAKind:(id)sender {
    valueOf3OfAKindsArray = [[NSMutableArray alloc] initWithObjects: nil];
    int valueOf3OfAKind = 0;
    for (int i = 0; i < 4; i++) {
        value = [[valueOfDicesString substringWithRange:NSMakeRange(i, 1)] intValue];
        for (int j = i+1; j < 6; j++) {
            value2 = [[valueOfDicesString substringWithRange:NSMakeRange(j, 1)] intValue];
            if (value == value2) {
                // Försöka hitta ytterligare en likadan.
                for (int k = j+1; k < 6; k++) {
                    value3 = [[valueOfDicesString substringWithRange:NSMakeRange(k, 1)] intValue];
                    if (value == value3) {
                        valueOf3OfAKind = value*3;
                        [valueOf3OfAKindsArray addObject:[NSNumber numberWithInt:valueOf3OfAKind]];
                        break;
                    }
                }
            }
        }
    }
    if ([valueOf3OfAKindsArray count] > 1) {
        if ([[valueOf3OfAKindsArray objectAtIndex:0] intValue] > [[valueOf3OfAKindsArray objectAtIndex:1] intValue]) {
            [self updateScoreSheetForItem:threeOfAKindButton withScore:[[valueOf3OfAKindsArray objectAtIndex:0] intValue] forSection:1];
            
        } else {
            [self updateScoreSheetForItem:threeOfAKindButton withScore:[[valueOf3OfAKindsArray objectAtIndex:1] intValue] forSection:1];
        }
    } else if ([valueOf3OfAKindsArray count] == 1){
        [self updateScoreSheetForItem:threeOfAKindButton withScore:[[valueOf3OfAKindsArray objectAtIndex:0] intValue] forSection:1];
    } else {
        [self updateScoreSheetForItem:threeOfAKindButton];
    }
}

-(IBAction)one4OfAKind:(id)sender {
    int valueOf4OfAKind = 0;
    for (int i = 0; i < 4; i++) {
        value = [[valueOfDicesString substringWithRange:NSMakeRange(i, 1)] intValue];
        for (int j = i+1; j < 6; j++) {
            value2 = [[valueOfDicesString substringWithRange:NSMakeRange(j, 1)] intValue];
            if (value == value2) {
                for (int k = j+1; k < 6; k++) {
                    value3 = [[valueOfDicesString substringWithRange:NSMakeRange(k, 1)] intValue];
                    if (value == value3) {
                        for (int l = k+1; l < 6; l++) {
                            value4 = [[valueOfDicesString substringWithRange:NSMakeRange(l, 1)] intValue];
                            if (value == value4) {
                                valueOf4OfAKind = value*4;
                            }
                        }
                    }
                }
            }
        }
    }
    if (valueOf4OfAKind > 0) {
        [self updateScoreSheetForItem:fourOfAKindButton withScore:valueOf4OfAKind forSection:1];
    } else {
        [self updateScoreSheetForItem:fourOfAKindButton];
    }
}
-(IBAction)one5OfAKind:(id)sender {
    int valueOf5OfAKind = 0;
    for (int i = 0; i < 2; i++) {
        value = [[valueOfDicesString substringWithRange:NSMakeRange(i, 1)] intValue];
        tracker = 0;
        for (int j = i + 1; j < 6; j++) {
            value2 = [[valueOfDicesString substringWithRange:NSMakeRange(j, 1)] intValue];
            if (value == value2) {
                tracker++;
                if (tracker > 3) {
                    valueOf5OfAKind = value * 5;
                }
            }
        }
    }
    
    if (valueOf5OfAKind > 0) {
        [self updateScoreSheetForItem:fiveOfAKindButton withScore:valueOf5OfAKind forSection:1];
    }  else {
        [self updateScoreSheetForItem:fiveOfAKindButton];
    }
}

-(IBAction)oneSmallStraight:(id)sender {
    
    NSArray *smallStraightArray = [[NSArray alloc] initWithObjects:@"5", @"4", @"3", @"2", @"1", nil];
    NSString *smallStraightString = @"54321";
    
    NSMutableArray *arrayOfDices = [[NSMutableArray alloc] initWithArray:[self sortArrayOfDices]];
    
    tracker = 0;
    if ([[arrayOfDices objectAtIndex:0] intValue] == 6) {
        NSString *possibleSmallStraightString = [NSString stringWithFormat:@"%d%d%d%d%d", [[arrayOfDices objectAtIndex:1] intValue], [[arrayOfDices objectAtIndex:2] intValue], [[arrayOfDices objectAtIndex:3] intValue], [[arrayOfDices objectAtIndex:4] intValue], [[arrayOfDices objectAtIndex:5] intValue]];
        if ([smallStraightString isEqualToString:possibleSmallStraightString]) {
            tracker = 5;
        }
    } else {
        for (int i = 0; i < 5; i++) {
            if ([[arrayOfDices objectAtIndex:i] intValue] == [[smallStraightArray objectAtIndex:i] intValue]) {
                tracker++;
            } else if ([[arrayOfDices objectAtIndex:i+1] intValue] == [[smallStraightArray objectAtIndex:i] intValue]) {
                tracker++;
                for (int j = i+2; j < 6; j++) {
                    if ([[arrayOfDices objectAtIndex:j] intValue] == [[smallStraightArray objectAtIndex:j-1] intValue]) {
                        tracker++;
                    }
                }
                break;
            }
        }
    }
    if (tracker > 4) {
        [self updateScoreSheetForItem:smallStraightButton withScore:15 forSection:1];
    } else {
        [self updateScoreSheetForItem:smallStraightButton];
    }
}

-(IBAction)oneLargeStraight:(id)sender {
    
    NSArray *largeStraightArray = [[NSArray alloc] initWithObjects:@"6", @"5", @"4", @"3", @"2", nil];
    
    NSMutableArray *arrayOfDices = [[NSMutableArray alloc] initWithArray:[self sortArrayOfDices]];
    

    tracker = 0;
    for (int i = 0; i < 5; i++) {
        if ([[arrayOfDices objectAtIndex:i] intValue] == [[largeStraightArray objectAtIndex:i] intValue]) {
            tracker++;
        } else if ([[arrayOfDices objectAtIndex:i+1] intValue] == [[largeStraightArray objectAtIndex:i] intValue]) {
            tracker++;
            for (int j = i+2; j < 6; j++) {
                if ([[arrayOfDices objectAtIndex:j] intValue] == [[largeStraightArray objectAtIndex:j-1] intValue]) {
                    tracker++;
                }
            }
            break;
        }
    }
    
    if (tracker > 4) {
        [self updateScoreSheetForItem:largeStraightButton withScore:20 forSection:1];
    } else {
        [self updateScoreSheetForItem:largeStraightButton];
    }
}

-(IBAction)oneFullStraight:(id)sender {
    
    NSMutableArray *arrayOfDices = [[NSMutableArray alloc] initWithArray:[self sortArrayOfDices]];
    

    tracker = 0;
    for (int i = 0; i < 6; i++) {
        if ([[arrayOfDices objectAtIndex:i] intValue] == (6-i)) {
            tracker++;
        } else {
            break;
        }
    }
    
    if (tracker == 6) {
        [self updateScoreSheetForItem:fullStraightButton withScore:25 forSection:1];
    } else {
        [self updateScoreSheetForItem:fullStraightButton];
    }
}

-(IBAction)oneFullHouse:(id)sender {
    
    
    NSMutableArray *threeOfAKindArray = [[NSMutableArray alloc] initWithObjects: nil];
    int valueOf3OfAKind = 0;
    for (int i = 0; i < 4; i++) {
        value = [[valueOfDicesString substringWithRange:NSMakeRange(i, 1)] intValue];
        for (int j = i+1; j < 6; j++) {
            value2 = [[valueOfDicesString substringWithRange:NSMakeRange(j, 1)] intValue];
            if (value == value2) {
                for (int k = j+1; k < 6; k++) {
                    value3 = [[valueOfDicesString substringWithRange:NSMakeRange(k, 1)] intValue];
                    if (value == value3) {
                        valueOf3OfAKind = value*3;
                        if ([threeOfAKindArray count] > 0) {
                            for (int i = 0; i < [threeOfAKindArray count]; i++) {
                                if (valueOf3OfAKind != [[threeOfAKindArray objectAtIndex:i] intValue]) {
                                    [threeOfAKindArray addObject:[NSNumber numberWithInt:valueOf3OfAKind]];
                                }
                            }
                        } else {
                            [threeOfAKindArray addObject:[NSNumber numberWithInt:valueOf3OfAKind]];
                        }
                        break;
                    }
                }
            }
        }
    }
    
    NSMutableArray *arrayOfDices = [[NSMutableArray alloc] initWithArray:[self sortArrayOfDices]];
    
    int valueOfFullHouse = 0;
    if ([threeOfAKindArray count] > 1) {
        if ([[threeOfAKindArray objectAtIndex:0] intValue] > [[threeOfAKindArray objectAtIndex:1] intValue]) {
            valueOfFullHouse = [[threeOfAKindArray objectAtIndex:0] intValue] + ([[threeOfAKindArray objectAtIndex:1] intValue] * 2/3);
        } else {
            valueOfFullHouse = [[threeOfAKindArray objectAtIndex:1] intValue] + ([[threeOfAKindArray objectAtIndex:0] intValue] * 2/3);
        }
    } else if ([threeOfAKindArray count] == 1) {
        NSString *val = [NSString stringWithFormat:@"%d", [[threeOfAKindArray objectAtIndex:0] intValue] / 3];
        int countOfVal = 0;
        for (int i = 5; i > -1; i--) {
            if ([val isEqual:[arrayOfDices objectAtIndex:i]]) {
                [arrayOfDices removeObjectAtIndex:i];
                countOfVal++;
            }
        }
        if (countOfVal > 3) {
            if ([[arrayOfDices objectAtIndex:0] isEqual:[arrayOfDices objectAtIndex:1]]) {
                valueOfFullHouse = [[threeOfAKindArray objectAtIndex:0] intValue] + [[arrayOfDices objectAtIndex:0] intValue] * 2;
            }
        } else {
            for (int i = 1; i < 3; i++) {
                if ([[arrayOfDices objectAtIndex:0] isEqual:[arrayOfDices objectAtIndex:i]]) {
                    valueOfFullHouse = [[threeOfAKindArray objectAtIndex:0] intValue] + [[arrayOfDices objectAtIndex:0] intValue] * 2;
                } else if ([[arrayOfDices objectAtIndex:1] isEqual:[arrayOfDices objectAtIndex:2]]) {
                    valueOfFullHouse = [[threeOfAKindArray objectAtIndex:0] intValue] + [[arrayOfDices objectAtIndex:1] intValue] * 2;
                }
            }
        }
    }
    
    if (valueOfFullHouse > 0) {
        [self updateScoreSheetForItem:fullHouseButton withScore:valueOfFullHouse forSection:1];
    } else {
        [self updateScoreSheetForItem:fullHouseButton];
    }
}

-(IBAction)oneVilla:(id)sender {
    
    NSMutableArray *arrayOfDices = [[NSMutableArray alloc] initWithArray:[self sortArrayOfDices]];
    
    int valueOfVilla = 0;
    if ([[arrayOfDices objectAtIndex:0] intValue] == [[arrayOfDices objectAtIndex:1] intValue] &&
        [[arrayOfDices objectAtIndex:0] intValue] == [[arrayOfDices objectAtIndex:2] intValue]) {
        if ([[arrayOfDices objectAtIndex:3] intValue] == [[arrayOfDices objectAtIndex:4] intValue] &&
            [[arrayOfDices objectAtIndex:3] intValue] == [[arrayOfDices objectAtIndex:5] intValue]) {
            if (!([[arrayOfDices objectAtIndex:0] intValue] == [[arrayOfDices objectAtIndex:3] intValue])) {
                valueOfVilla = [[arrayOfDices objectAtIndex:0] intValue] * 3 + [[arrayOfDices objectAtIndex:3] intValue] * 3;
            }
        }
    }
    
    if (valueOfVilla > 0) {
        [self updateScoreSheetForItem:villaButton withScore:valueOfVilla forSection:1];
    } else {
        [self updateScoreSheetForItem:villaButton];
        
    }
}

-(IBAction)oneTower:(id)sender {
    NSMutableArray *arrayOfDices = [[NSMutableArray alloc] initWithArray:[self sortArrayOfDices]];
    
    tracker = 1;
    for (int i = 1; i < 6; i++) {
        if ([[arrayOfDices objectAtIndex:0] intValue] == [[arrayOfDices objectAtIndex:i] intValue]) {
            tracker++;
        }
    }
    
    if (tracker == 4) {
        if ([[arrayOfDices objectAtIndex:4] intValue] == [[arrayOfDices objectAtIndex:5] intValue]) {
            tracker++;
        }
    } else if (tracker == 2) {
        for (int i = 3; i < 6; i++) {
            if ([[arrayOfDices objectAtIndex:2] intValue] == [[arrayOfDices objectAtIndex:i] intValue]) {
                tracker++;
            }
        }
    } else {
        tracker = 0;
    }
    
    int valueOfTower = 0;
    
    if (tracker == 5) {
        for (int i = 0; i < 6; i++) {
            valueOfTower += [[arrayOfDices objectAtIndex:i] intValue];
        }
        [self updateScoreSheetForItem:towerButton withScore:valueOfTower forSection:1];
    } else {
        [self updateScoreSheetForItem:towerButton];
    }
}

-(IBAction)oneChance:(id)sender {
    
    int valueOfChance = 0;
    for (int i = 0; i < 6; i++) {
        valueOfChance += [[valueOfDicesString substringWithRange:NSMakeRange(i, 1)] intValue];
    }
    [self updateScoreSheetForItem:chanceButton withScore:valueOfChance forSection:1];
}

-(IBAction)oneYahtzee:(id)sender {
    tracker = 1;
    for (int i = 1; i < 6; i++) {
        if ([[valueOfDicesString substringWithRange:NSMakeRange(0, 1)] intValue] == [[valueOfDicesString substringWithRange:NSMakeRange(i, 1)] intValue]) {
            tracker++;
        }
    }
    if (tracker == 6) {
        [self updateScoreSheetForItem:yahtzeeButton withScore:100 forSection:1];
    } else {
        [self updateScoreSheetForItem:yahtzeeButton];
    }
}


#pragma mark - Restarting and saving game

-(IBAction)restart:(id)sender
{
    [restartAlert show];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ([alertView.title isEqualToString:@"New Game"]) {
        if (buttonIndex == 0) {
            [self restartGame];
        }
    } else if ([alertView.title isEqualToString:@"Save Score"]) {
        if (buttonIndex == 0) {
            [self saveScore];
            self.tabBarController.tabBar.hidden = YES;
        } else {
            [self restartGame];
        }
    }
    
}

-(void)restartGame
{
    for (int i = 0; i < [arrayOfButtons count]; i++) {
        [[arrayOfButtons objectAtIndex:i] setTitle:@"0" forState:UIControlStateNormal];
        [[arrayOfButtons objectAtIndex:i] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [[arrayOfButtons objectAtIndex:i] setUserInteractionEnabled:NO];
    }
    
    for (int i = 0; i < [scoreLabels count]; i++) {
        [[scoreLabels objectAtIndex:i] setText:@"0"];
        [[scoreLabels objectAtIndex:i] setTextColor:[UIColor blackColor]];
    }
    
    [self resetThrowDicesView];
    valueOfDicesString = @"";
    arrayOfButtonsAlreadyUsed = [[NSMutableArray alloc] initWithObjects: nil];
    totalScoreValueGlobal = 0;
    scoreOfLowerSection = 0;
    scoreOfUpperSection = 0;
    totalScoreForLabel = 0;
    bonusRecieved = 0;
}

-(void)saveScore
{
    savedScore = [totalScore.text intValue];
    totalScoreValueGlobal = [totalScore.text intValue];
    self.navigationController.navigationBar.hidden = NO;
    saveHighScoreViewController *shsvc = [[saveHighScoreViewController alloc] init];
    [self.navigationController pushViewController:shsvc animated:YES];
    [self restartGame];
}

@end
