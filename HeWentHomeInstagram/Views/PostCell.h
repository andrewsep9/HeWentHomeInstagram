//
//  PostCell.h
//  HeWentHomeInstagram
//
//  Created by andrews9 on 7/10/19.
//  Copyright © 2019 andrews9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet UIImageView *feedPostImage;
@property (weak, nonatomic) IBOutlet UILabel *feedPostLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@end

NS_ASSUME_NONNULL_END
