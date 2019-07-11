//
//  ComposeViewController.m
//  HeWentHomeInstagram
//
//  Created by andrews9 on 7/9/19.
//  Copyright © 2019 andrews9. All rights reserved.
//

#import "ComposeViewController.h"
#import "Post.h"
#import "FeedViewController.h"

@interface ComposeViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITabBarControllerDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UITextView *postTextView;
@property (strong, nonatomic) UIImage *chosenImage;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.postTextView.delegate = self;
    
    self.tabBarController.delegate = self;
    
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePickerVC animated:YES completion:^{
        self.postTextView.text = @"Insert caption here";
        self.postTextView.textColor = [UIColor lightGrayColor];
    }];
    NSLog(@"Bruh");
    }

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    // Do something with the images (based on your use case)
    // Dismiss UIImagePickerController to go back to your original view controller
    self.chosenImage = editedImage;
    self.postImageView.image = [self resizeImage:editedImage withSize:CGSizeMake(300, 300)];
//    self.postImageView.image = self.chosenImage;
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self dismissViewControllerAnimated:YES completion:^{[self performSegueWithIdentifier:@"ComposeSegue" sender:self];}];
}


- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)shareTapped:(UIBarButtonItem *)sender {
    [Post postUserImage:self.postImageView.image withCaption:self.postTextView.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error != nil){
            NSLog(@"Error: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Posted!");
            
            [self.parentViewController.tabBarController setSelectedIndex:0];
    
        }
    }];
}

//Placeholder in UITextView method #1
- (void)textViewDidBeginEditing:(UITextView *)captionTextView
{
    if ([self.postTextView.text isEqualToString:@"Insert caption here"]) {
        self.postTextView.text  = @"";
        self.postTextView.textColor = [UIColor blackColor];
    }
    [self.postTextView becomeFirstResponder];
}

//Placeholder in UITextView method #2
- (void)textViewDidEndEditing:(UITextView *)captionTextView
{
    if ([self.postTextView.text isEqualToString:@""]) {
        self.postTextView.text = @"Insert caption here";
        self.postTextView.textColor = [UIColor lightGrayColor];
    }
    [self.postTextView resignFirstResponder];
}



@end
