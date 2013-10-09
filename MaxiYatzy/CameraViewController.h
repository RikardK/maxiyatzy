//
//  CameraViewController.h
//  MaxiYatzy
//
//  Created by Rikard Karlsson on 2013-10-08.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CameraViewDelegate <NSObject>

-(void)setPlayerImageTest:(UIImage *)image;

@end

@interface CameraViewController : UIImagePickerController

-(BOOL)showImagePickerControllerForType:(UIImagePickerControllerSourceType) sourceType;
@property (weak) id <CameraViewDelegate> cameraDelegate;

@end

