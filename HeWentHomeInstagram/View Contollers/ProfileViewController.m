//
//  ProfileViewController.m
//  HeWentHomeInstagram
//
//  Created by andrews9 on 7/11/19.
//  Copyright © 2019 andrews9. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import "PFUser.h"
#import "PostCell.h"
#import "Post.h"
#import "NSDate+DateTools.h"
#import "ProfileCollectionViewCell.h"




@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *postss;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self fetchPosts];
}


- (void) fetchPosts{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    // [query whereKey:@"likesCount" greaterThan:@100];
    query.limit = 20;
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.postss = [NSMutableArray arrayWithArray:posts];
            [self.collectionView reloadData];
            NSLog(@"Okay %@", self.postss);
            // do something with the array of object returned by the call
        } else {
            NSLog(@"Okay %@", error.localizedDescription);
        }
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ProfileCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileCollectionCell" forIndexPath:indexPath];
    Post *post = self.postss[indexPath.item];
    UIImage *image = [[UIImage alloc] initWithData:post.image.getData];
    cell.postImageView.image = image;
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.postss.count;
}


@end
