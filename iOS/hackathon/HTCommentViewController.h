//
//  HTCommentViewController.h
//  hackathon
//
//  Created by GIGIGUN on 04/11/2016.
//  Copyright © 2016 hippocolors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SLKTextViewController.h>

@interface HTCommentViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *dismissBtn;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *postBtn;
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@property BOOL isChapter;
@property (strong, nonatomic) ServerModule *serverObj;
@property (strong, nonatomic) NSString *bibleInfo;
@property (strong, nonatomic) NSString *bibleTitle;
@end
