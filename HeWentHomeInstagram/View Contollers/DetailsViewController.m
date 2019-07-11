//
//  DetailsViewController.m
//  HeWentHomeInstagram
//
//  Created by andrews9 on 7/11/19.
//  Copyright © 2019 andrews9. All rights reserved.
//

#import "DetailsViewController.h"
#import "PostCell.h"
#import "Post.h"
#import <Parse/Parse.h>
#import "NSDate+DateTools.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.captionLabel.text = self.detailsPost[@"caption"];
    NSData *data = self.detailsPost.image.getData;
    UIImage *image = [[UIImage alloc] initWithData:data];
    self.postImage.image = image;
    self.timeStampLabel.text = self.detailsPost.createdAt.timeAgoSinceNow;

    // Do any additional setup after loading the view.
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
