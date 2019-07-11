//
//  FeedViewController.m
//  HeWentHomeInstagram
//
//  Created by andrews9 on 7/9/19.
//  Copyright © 2019 andrews9. All rights reserved.
//

#import "FeedViewController.h"
#import "User.h"
#import <Parse/Parse.h>
#import "PFUser.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "PostCell.h"
#import "Post.h"
#import "ComposeViewController.h"


@interface FeedViewController () <UITableViewDelegate, UITableViewDataSource>
//ComposeViewControllerDelegate

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
//    self.tableView.rowHeight = 800;
    
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

//- (void) didPost:(Post *)post{
//    [self.postss insertObject:post atIndex:0];
//    [self.tableView reloadData];
//}


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
    
    
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    Post *post = self.postss[indexPath.row];
    cell.post = post;
    cell.feedPostLabel.text = post[@"caption"];
    
    UIImage *image = [[UIImage alloc] initWithData:post.image.getData];
    cell.feedPostImage.image = image;
    
    
    
    return cell;
    
    
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postss.count;
}



@end
