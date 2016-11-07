//
//  HTProfileHeaderTableViewCell.h
//  hackathon
//
//  Created by GIGIGUN on 04/11/2016.
//  Copyright © 2016 hippocolors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTProfileHeaderTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UILabel *userPostCountLab;
@property (strong, nonatomic) IBOutlet UILabel *userPostLikeCountLab;
@property (strong, nonatomic) IBOutlet UILabel *userGoodResponseLab;
@property (strong, nonatomic) IBOutlet UILabel *userName;

@end
