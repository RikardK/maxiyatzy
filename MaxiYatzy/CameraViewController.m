//
//  CameraViewController.m
//  MaxiYatzy
//
//  Created by Rikard Karlsson on 2013-10-08.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import "CameraViewController.h"
#import "saveHighScoreViewController.h"

@interface CameraViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    saveHighScoreViewController *shsvc;
    UIImage *playerImage;
}

@end

@implementation CameraViewController

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
    shsvc = [[saveHighScoreViewController alloc] init];
    [self prefersStatusBarHidden];
}

- (BOOL)showImagePickerControllerForType:(UIImagePickerControllerSourceType) sourceType
{
    if([UIImagePickerController isSourceTypeAvailable:sourceType])
    {
        self.sourceType = sourceType;
        self.allowsEditing = YES;
        self.delegate = self;
        return YES;
    }
    return NO;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    playerImage = [info objectForKey:UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.cameraDelegate setPlayerImageTest:playerImage];
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
