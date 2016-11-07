//
//  HotPostTableViewCell.h
//  hackathon
//
//  Created by GIGIGUN on 06/11/2016.
//  Copyright © 2016 hippocolors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotPostTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *userImageView;
@property (strong, nonatomic) IBOutlet UILabel *posterName;
@property (strong, nonatomic) IBOutlet UILabel *DateLab;
@property (strong, nonatomic) IBOutlet UILabel *postContentLab;
@property (strong, nonatomic) IBOutlet UILabel *likeCountLab;
@property (strong, nonatomic) IBOutlet UILabel *responseLab;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UIButton *likeBtn;
@property (strong, nonatomic) NSString *postIDString;
@end
