//
//  HTBibleChapterViewController.h
//  hackathon
//
//  Created by GIGIGUN on 05/11/2016.
//  Copyright © 2016 hippocolors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTBibleChapterViewController : UIViewController
@property (strong,nonatomic) NSMutableArray *bibleChapter;
@property (strong,nonatomic) ServerModule *serverObj;
@property (strong,nonatomic) NSString *bookid;
@property (strong,nonatomic) NSString *bibleTitle;
@end
