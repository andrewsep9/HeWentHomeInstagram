//
//  CameraViewController.m
//  HeWentHomeInstagram
//
//  Created by andrews9 on 7/9/19.
//  Copyright © 2019 andrews9. All rights reserved.
//

#import "CameraViewController.h"
#import <UIKit/UIKit.h>

@interface CameraViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITabBarControllerDelegate>

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    NSLog(@"DidTap");
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
