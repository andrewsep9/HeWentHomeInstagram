//
//  FeedViewController.m
//  HeWentHomeInstagram
//
//  Created by andrews9 on 7/9/19.
//  Copyright © 2019 andrews9. All rights reserved.
//

#import "FeedViewController.h"
#import <Parse/Parse.h>
#import "PFUser.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "PostCell.h"
#import "Post.h"
#import "ComposeViewController.h"
#import "DetailsViewController.h"
#import "NSDate+DateTools.h"


@interface FeedViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *postss;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor blackColor],
       NSFontAttributeName:[UIFont fontWithName:@"Billabong" size:35]}];
    
    [self fetchPosts];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [self fetchPosts];
    [self.tableView reloadData];
    [refreshControl endRefreshing];
}


-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
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
            [self.tableView reloadData];
            NSLog(@"Okay %@", self.postss);
            // do something with the array of object returned by the call
        } else {
            NSLog(@"Okay %@", error.localizedDescription);
        }
    }];
    
}

- (IBAction)logoutTapped:(UIBarButtonItem *)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    Post *detailsPost = self.postss[indexPath.row];
    DetailsViewController *detailsViewController = [segue destinationViewController];
    detailsViewController.detailsPost = detailsPost;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    Post *post = self.postss[indexPath.row];
    cell.post = post;
    cell.feedPostLabel.text = post[@"caption"];
    
    UIImage *image = [[UIImage alloc] initWithData:post.image.getData];
    cell.feedPostImage.image = image;
    cell.timeStampLabel.text = cell.post.createdAt.timeAgoSinceNow;
    PFUser *temp = post[@"author"];
    cell.usernameLabel.text = temp[@"username"];
    return cell;
    
    
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postss.count;
}



@end
