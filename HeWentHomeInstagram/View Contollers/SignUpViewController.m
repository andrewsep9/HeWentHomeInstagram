//
//  SignUpViewController.m
//  HeWentHomeInstagram
//
//  Created by andrews9 on 7/9/19.
//  Copyright © 2019 andrews9. All rights reserved.
//

#import "SignUpViewController.h"
#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "PFUser.h"

@interface SignUpViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation SignUpViewController
@synthesize gifImageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    gifImageView.animationImages = [[NSArray alloc] initWithObjects:
                                    [UIImage imageNamed:@"1.png"],
                                    [UIImage imageNamed:@"2.png"],
                                    [UIImage imageNamed:@"3.png"],
                                    [UIImage imageNamed:@"4.png"],
                                    [UIImage imageNamed:@"5.png"],
                                    [UIImage imageNamed:@"6.png"],
                                    [UIImage imageNamed:@"7.png"],
                                    [UIImage imageNamed:@"8.png"],
                                    [UIImage imageNamed:@"9.png"],
                                    [UIImage imageNamed:@"10.png"],
                                    [UIImage imageNamed:@"11.png"],
                                    [UIImage imageNamed:@"12.png"],
                                    [UIImage imageNamed:@"13.png"],
                                    [UIImage imageNamed:@"14.png"],
                                    [UIImage imageNamed:@"15.png"],
                                    [UIImage imageNamed:@"16.png"],
                                    [UIImage imageNamed:@"17.png"],
                                    [UIImage imageNamed:@"18.png"],
                                    [UIImage imageNamed:@"19.png"],
                                    [UIImage imageNamed:@"20.png"],

                                     nil];
    [gifImageView setAnimationRepeatCount:0];
    gifImageView.animationDuration = 6;
    [gifImageView startAnimating];
    
}

- (void)registerUser {
    
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameTextField.text;
    newUser.email = self.emailTextField.text;
    newUser.password = self.passwordTextField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            
            // manually segue to logged in view
        }
    }];
}

- (IBAction)BackButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)signUpTapped:(id)sender {
    [self registerUser];
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
