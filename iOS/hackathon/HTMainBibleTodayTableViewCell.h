//
//  HTMainBibleTodayTableViewCell.h
//  hackathon
//
//  Created by GIGIGUN on 04/11/2016.
//  Copyright © 2016 hippocolors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTMainBibleTodayTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *bibleTitleLab;
@property (strong, nonatomic) IBOutlet UILabel *bibleContentLab;
@property (strong, nonatomic) IBOutlet UIImageView *posterImageView;
@property (strong, nonatomic) IBOutlet UIButton *writeCommentBtn;
@property (strong, nonatomic) IBOutlet UILabel *dateLab;

@end
