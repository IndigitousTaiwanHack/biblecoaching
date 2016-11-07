//
//  HTMainRecommandView.h
//  hackathon
//
//  Created by GIGIGUN on 05/11/2016.
//  Copyright © 2016 hippocolors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTMainRecommandView : UIView
@property (strong, nonatomic) IBOutlet UIImageView *userImageView;
@property (strong, nonatomic) IBOutlet UILabel *BookNameLab;
@property (strong, nonatomic) IBOutlet UILabel *chapterNumberLab;
@property (strong, nonatomic) IBOutlet UIButton *GotoSeeBtn;
@property (strong, nonatomic) NSString *postIDString;

@end
