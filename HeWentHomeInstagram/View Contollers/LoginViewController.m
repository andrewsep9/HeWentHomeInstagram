//
//  LoginViewController.m
//  HeWentHomeInstagram
//
//  Created by andrews9 on 7/8/19.
//  Copyright © 2019 andrews9. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"
#import <Parse/Parse.h>
#import "PFUser.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)([UIColor colorWithRed:0.0 green:0.9764705896377563 blue:0.05882352963089943 alpha:1.00].CGColor), (id)([UIColor colorWithRed:0.0 green:0.5294117647058824 blue:0.8980392156862745 alpha:1.00].CGColor), nil];
    gradient.startPoint = CGPointMake(0.00, 0.00);
    gradient.endPoint = CGPointMake(1.00, 1.00);
    [self.view.layer insertSublayer:gradient atIndex:0];
    NSLog(@"Opened");
}

- (void)loginUser {
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            [self performSegueWithIdentifier:@"FeedSegue" sender:nil];
            
            // display view controller that needs to shown after successful login
        }
    }];
}


- (IBAction)loginTapped:(id)sender {
    [self loginUser];
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
