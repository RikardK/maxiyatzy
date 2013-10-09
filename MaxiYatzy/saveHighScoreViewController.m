//
//  saveHighScoreViewController.m
//  MaxiYatzy
//
//  Created by Rikard Karlsson on 2013-08-05.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import "saveHighScoreViewController.h"
#import "HighScoreViewController.h"
#import "HighScorePlayerStorage.h"
#import "HighScorePlayer.h"
#import "GlobalVariables.h"
#import "CameraViewController.h"

@interface saveHighScoreViewController () <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CameraViewDelegate>
{
    CameraViewController *cvc;
}

@property (weak, nonatomic) IBOutlet UITextField *enterPlayerNameField;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *playerImage;

@end

@implementation saveHighScoreViewController
{
    HighScorePlayerStorage *playerStorage;
    HighScorePlayer *player;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.enterPlayerNameField setReturnKeyType:UIReturnKeyDone];
    [self.enterPlayerNameField setDelegate:self];
    [self.playerImage setImage:[UIImage imageNamed:@"noImageAvailable.png"]];
    
    self.backgroundImage.image = [UIImage imageNamed:@"saveScoreBackgroundImage.png"];
    
    cvc = [[CameraViewController alloc] init];
    cvc.cameraDelegate = self;
    
    playerStorage = [HighScorePlayerStorage new];
    player = [HighScorePlayer new];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.score.text = [NSString stringWithFormat:@"%d", savedScore];
    self.navigationController.navigationBarHidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated {
    playerName = self.enterPlayerNameField.text;
    player.name = self.enterPlayerNameField.text;
    player.score = [NSNumber numberWithInt:[self.score.text intValue]];
    player.image = self.playerImage.image;
    [playerStorage savePlayer:player];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SaveHighScore" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)takePicture:(id)sender
{
    [cvc showImagePickerControllerForType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:cvc animated:YES completion:nil];
}

- (IBAction)showLibrary:(id)sender
{
    [cvc showImagePickerControllerForType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:cvc animated:YES completion:nil];
}

-(void)setPlayerImageTest:(UIImage *)image
{
    [self.playerImage setImage:image];
}


@end
