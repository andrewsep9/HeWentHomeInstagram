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

@property (strong, nonatomic) UIImage *chosenImage;

@end

@implementation CameraViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.tabBarController.delegate = self;
//    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
//    imagePickerVC.delegate = self;
//    imagePickerVC.allowsEditing = YES;
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
//    }
//    else {
//        NSLog(@"Camera 🚫 available so we will use photo library instead");
//        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    }
//    [self presentViewController:imagePickerVC animated:YES completion:nil];
//
//}
//
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:YES];
//    NSLog(@"DidTap");
//
//}
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//    // Get the image captured by the UIImagePickerController
//    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
//    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
//    // Do something with the images (based on your use case)
//    // Dismiss UIImagePickerController to go back to your original view controller
//    self.chosenImage = editedImage;
//    [self resizeImage:self.chosenImage withSize:CGSizeMake(100, 100)];
//    [self dismissViewControllerAnimated:YES completion:^{[self performSegueWithIdentifier:@"ComposeSegue" sender:self];}];
//}
//
//
//- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
//    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
//    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
//    resizeImageView.image = image;
//    UIGraphicsBeginImageContext(size);
//    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return newImage;
//}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
