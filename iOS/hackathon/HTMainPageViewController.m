//
//  HTMainPageViewController.m
//  hackathon
//
//  Created by GIGIGUN on 04/11/2016.
//  Copyright © 2016 hippocolors. All rights reserved.
//

#import "HTMainPageViewController.h"
#import "HTMainHeaderTableViewCell.h"
#import "HTMainBibleTodayTableViewCell.h"
#import "HTMainHotBibleTableViewCell.h"
#import "HTMainRecommandTableViewCell.h"
#import "HTPostTableViewCell.h"
#import "HTMainRecommandView.h"
#import "HTCommentViewController.h"
#import "HTBaseNavigationViewController.h"
#import "HTNotificationModule.h"
#import "cameraViewController.h"
#import "HTHotBibleViewController.h"
#import "HTPostViewViewController.h"
#import "HTFBModule.h"
#import "UIImageView+AFNetworking.h"
#import "HotPostTableViewCell.h"


#define HeaderSection           0
#define BibleTodaySection       1
//#define RecommandPostSection    2
#define HotBibleSection         2
#define HotPostSection          3
#define PostsSection            4


#define HeaderCellName          @"headerCell"
#define BibleTodayCellName      @"bibleTodayCell"
#define RecommandPostCellName   @"recommandPostCell"
#define HotBibleCellName        @"hotBibleCell"
#define HotPostCellName         @"hotPostCell"
#define PostCellName            @"PostCell"

@interface HTMainPageViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIScrollView *recommandScroller;
@property (strong, nonatomic) ServerModule *serverObj;
@property (strong, nonatomic) NSMutableArray *notificationList;
@property (strong, nonatomic) NSString *bibleTitle;
@property (strong, nonatomic) NSString *bibleContent;
@property (strong, nonatomic) NSString *bibleDate;
@property (strong, nonatomic) IBOutlet UIView *newsSectionView;
@property (strong, nonatomic) cameraViewController *cameraView;
@property (strong, nonnull) NSString *bibleInfoString;

@property (strong, nonatomic) NSString *notificationBibleString;
@property (strong, nonatomic) NSMutableArray *postNewList;
@property (strong, nonatomic) NSMutableDictionary *postHotList;
@property (strong, nonatomic) NSMutableDictionary *bibleHotList;
@property (strong, nonatomic) NSMutableArray *popularManList;

@property (strong, nonatomic) NSString *HotPostIDString;
@property (strong, nonatomic) NSMutableArray *PostIDArray;

@end

@implementation HTMainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _serverObj = [ServerModule getInstance];
    
    _notificationList = [HTNotificationModule GetNotificationList];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    _bibleTitle = @"";
    _bibleContent = @"";
    _bibleDate = @"";
    _postNewList = [[NSMutableArray alloc]init];
    _postHotList = [[NSMutableDictionary alloc]init];
    _bibleHotList = [[NSMutableDictionary alloc]init];
    _popularManList = [[NSMutableArray alloc]init];
    
    _cameraView = [[cameraViewController alloc]init];
    
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    
    int index=0;
    for (int i=0;i<_notificationList.count;i++) {
        if ([strDate isEqualToString:[_notificationList[i] valueForKey:@"Date"]]) {
            index = i;
            break;
        }
    }
    
//    NSLog(@"today = %@",[_notificationList[index] valueForKey:@"Bible"]);
    
    _bibleInfoString = [_notificationList[index] valueForKey:@"Bible"];
    
    [_serverObj GetTodayBibleInfoWithParameter:[_notificationList[index] valueForKey:@"Bible"] Success:^(id responseObj) {
        
        _bibleTitle = [NSString stringWithFormat:@"%@ 第 %@ 章",[responseObj objectForKey:@"title"],[[[_notificationList[index] valueForKey:@"Bible"] componentsSeparatedByString: @"-"] objectAtIndex:1]];
        _bibleContent = [responseObj objectForKey:@"content"];
        _bibleDate = [_notificationList[index] valueForKey:@"Date"];

        
        [_tableView reloadData];
    } Failure:^(NSError *error) {
        NSLog(@"GetTodayBibleInfoWithParameter Fail");
    }];
    
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 300;
    
    [_tableView registerNib:[UINib nibWithNibName:@"HTPostTableViewCell" bundle:nil] forCellReuseIdentifier:PostCellName];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cameraNotification:) name:CameraNotification object:nil];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"_notification string %@", _notificationBibleString);
    
    if (_notificationBibleString) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        HTCommentViewController *CommentPage = [storyboard instantiateViewControllerWithIdentifier:CommentPageID];
        CommentPage.bibleInfo = _notificationBibleString;
//        [self presentViewController:CommentPage animated:YES completion:nil];
        [self.navigationController pushViewController:CommentPage animated:YES];
        _notificationBibleString = nil;
    }
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_serverObj GetNewsWithSuccess:^(id responseObj) {
        NSLog(@"GetNewsWithSuccess responseObj = %@",responseObj);
        if ([[responseObj valueForKey:@"result"] isEqual:[NSNumber numberWithInt:0]]) {
            _postNewList = [responseObj valueForKey:@"posts"];
            [_tableView reloadData];
        }
    } Failure:^(NSError *error) {
        NSLog(@"GetNewsWithSuccess Fail");
    }];
    
    [_serverObj GetPopularBibleWithSuccess:^(id responseObj) {
        NSLog(@"GetPopularBibleWithSuccess responseObj = %@",responseObj);
        
        if ([[responseObj valueForKey:@"result"] isEqual:[NSNumber numberWithInt:0]]) {
            _bibleHotList = [responseObj valueForKey:@"post"];
            [_tableView reloadData];
        }
        
    } Failure:^(NSError *error) {
        NSLog(@"GetPopularBibleWithSuccess Fail");
    }];
    
    [_serverObj GetPostsPopularWithSuccess:^(id responseObj) {
        NSLog(@"GetPostsPopularWithSuccess responseObj = %@,post = %@",responseObj,[responseObj valueForKey:@"post"]);
        if ([[responseObj valueForKey:@"result"] isEqual:[NSNumber numberWithInt:0]]) {
            
            NSLog(@"Casper response = %@", responseObj);
            _postHotList = [responseObj valueForKey:@"post"];
            [_tableView reloadData];
        }
    } Failure:^(NSError *error) {
        NSLog(@"GetPostsPopularWithSuccess Fail");
    }];
    
    NSDictionary *dic = @{@"uid":[HTFBModule GetFBID],@"provider":@"facebook"};
    [_serverObj RecommendWithParameter:dic Success:^(id responseObj) {
        NSLog(@"RecommendWithParameter responseObj = %@,post = %@",responseObj,[responseObj valueForKey:@"post"]);
        if ([[responseObj valueForKey:@"result"] isEqual:[NSNumber numberWithInt:0]]) {
            _popularManList = [responseObj valueForKey:@"posts"];
            [_tableView reloadData];
        }
    } Failure:^(NSError *error) {
        NSLog(@"RecommendWithParameter Fail");
    }];
}

#pragma tableView DataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == HotBibleSection){
        return 1;
    }
    else if(section == HotPostSection){
        return 1;
    }
    else if (section == PostsSection) {
        return [_postNewList count];
    }
    else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 120;
    }
    else if (section == 4) {
        return 32;
    }
    else {
        return 0;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == PostsSection) {
        return _newsSectionView;

    }
    
    if (section == 2) {
        
        // TODO: get recommand post section
        NSLog(@"_popularManList %@", _popularManList);
        NSLog(@"_popularManList %d", _popularManList.count);
        
        if (_recommandScroller) {
            for (UIView *subView in _recommandScroller.subviews) {
                NSLog(@"SUBVIEW = %@", subView);
                if ((subView.tag > 0) && (subView.tag < 5)) {
                    
                    [subView removeFromSuperview];
                }
            }
        }

        
        for (NSInteger index = 0; index < _popularManList.count; index ++ ) {
            
            HTMainRecommandView *userTempView = [[[NSBundle mainBundle] loadNibNamed:@"HTMainRecommandView" owner:self options:nil] objectAtIndex:0];
            
            userTempView.tag = index;
            CGRect Frame = userTempView.frame;
            Frame.origin.x = userTempView.frame.size.width * index;
            [userTempView setFrame:Frame];
            
            NSURL *Url = [NSURL URLWithString:[_popularManList[index] valueForKey:@"user_url"]];
            NSMutableURLRequest *UrlRequest = [NSMutableURLRequest requestWithURL:Url];
            
            __weak HTMainRecommandView *tempView = userTempView;

            [tempView.userImageView setImageWithURLRequest:UrlRequest
                                        placeholderImage:nil
                                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                     userTempView.userImageView.image = image;
                                                     [tempView setNeedsLayout];
                                                     
                                                 } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                                     NSLog(@"Failed : response = %@",response);
                                                     NSLog(@"Failed : error = %@", [error localizedDescription]);
                                                 }];
            
            userTempView.BookNameLab.text = [_popularManList[index] valueForKey:@"bible_title"];
            NSString *ChapterString = [[[_popularManList[index] valueForKey:@"bid"]componentsSeparatedByString: @"-"] objectAtIndex:1];
            userTempView.chapterNumberLab.text = [NSString stringWithFormat:@"第 %@ 章", ChapterString];
            [userTempView.GotoSeeBtn addTarget:self action:@selector(presentPostPageWithRecommendPost:) forControlEvents:UIControlEventTouchUpInside];
            userTempView.GotoSeeBtn.tag = index;

            
//            @property (strong, nonatomic) IBOutlet UILabel *BookNameLab;
//            @property (strong, nonatomic) IBOutlet UILabel *chapterNumberLab;
//            @property (strong, nonatomic) IBOutlet UIButton *GotoSeeBtn;
//            @property (strong, nonatomic) NSString *postIDString;

            
            [_recommandScroller addSubview:userTempView];
            
            CGSize size = CGSizeMake(userTempView.frame.size.width * (index + 1),
                                     0);
            _recommandScroller.contentSize = size;
            _recommandScroller.backgroundColor = [UIColor whiteColor];
        }
        
        return _recommandScroller;
        
    } else {
        return nil;
    }
}


    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case HeaderSection:
        {
            HTMainHeaderTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:HeaderCellName];
            if (Cell == nil) {
                Cell = [[HTMainHeaderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeaderCellName];
            }
            [Cell.cameraBtn addTarget:self action:@selector(headerCameraBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [Cell.bibleBtn addTarget:self action:@selector(headerBibleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            return Cell;

        }
            break;
            
        case BibleTodaySection:
        {
            HTMainBibleTodayTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:BibleTodayCellName];
            if (Cell == nil) {
                Cell = [[HTMainBibleTodayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BibleTodayCellName];
            }
            
            [Cell.bibleTitleLab setText:_bibleTitle];
            [Cell.bibleContentLab setText:_bibleContent];
            [Cell.dateLab setText:_bibleDate];
            
            [Cell.writeCommentBtn addTarget:self action:@selector(presentWriteCommentView:) forControlEvents:UIControlEventTouchUpInside];
            
            __weak HTMainBibleTodayTableViewCell *weakCell = Cell;
            NSURL *Url = [NSURL URLWithString:[HTFBModule GetImageUrl]];
            NSMutableURLRequest *UrlRequest = [NSMutableURLRequest requestWithURL:Url];
            
            [Cell.posterImageView setImageWithURLRequest:UrlRequest
                                  placeholderImage:nil
                                           success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                               weakCell.posterImageView.image = image;
                                               [weakCell setNeedsLayout];
                                               
                                           } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                               NSLog(@"Failed : response = %@",response);
                                               NSLog(@"Failed : error = %@", [error localizedDescription]);
                                           }];
            
            
            return Cell;
        }
            break;


        case HotBibleSection:
        {
            // TODO: add hot bible section
            HTMainHotBibleTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:HotBibleCellName];
            if (Cell == nil) {
                Cell = [[HTMainHotBibleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HotBibleCellName];
            }
            
            
            
            [Cell.titleLab setText:[NSString stringWithFormat:@"%@ 第%@章",[_bibleHotList valueForKey:@"bible_title"],[[[_bibleHotList valueForKey:@"bid"]componentsSeparatedByString: @"-"] objectAtIndex:1]]];
            
            [Cell.discussLab setText:[NSString stringWithFormat:@"%@",[_bibleHotList valueForKey:@"post_count"]]];
            
            
            return Cell;
        }
            break;

        case HotPostSection:
        {
            // TODO: add hot post section, 熱門討論可以跟一般討論使用同一個 class
            HotPostTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:HotPostCellName];
            if (Cell == nil) {
                Cell = [[HotPostTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HotPostCellName];
            }
            
            [Cell.likeCountLab setHidden:YES];
            
            __weak HotPostTableViewCell *weakCell = Cell;
            NSURL *Url = [NSURL URLWithString:[_postHotList valueForKey:@"user_url"]];
            NSMutableURLRequest *UrlRequest = [NSMutableURLRequest requestWithURL:Url];
            
            [Cell.userImageView setImageWithURLRequest:UrlRequest
                                  placeholderImage:nil
                                           success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                               weakCell.userImageView.image = image;
                                               [weakCell setNeedsLayout];
                                               
                                           } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                               NSLog(@"Failed : response = %@",response);
                                               NSLog(@"Failed : error = %@", [error localizedDescription]);
                                           }];
            
            
            [Cell.posterName setText:[NSString stringWithFormat:@"%@",[_postHotList valueForKey:@"user_name"]]];
            [Cell.DateLab setText:[NSString stringWithFormat:@"%@",[_postHotList valueForKey:@"date"]]];
            NSLog(@"content = %@", [_postHotList valueForKey:@"content"]);
            [Cell.postContentLab setText:[NSString stringWithFormat:@"%@",[_postHotList valueForKey:@"content"]]];
            [Cell.likeCountLab setText:[NSString stringWithFormat:@"%@",[_postHotList valueForKey:@"rank_count"]]];
            [Cell.responseLab setText:[NSString stringWithFormat:@"%@",[_postHotList valueForKey:@"response_count"]]];
            [Cell.titleLab setText:[NSString stringWithFormat:@"%@ 第%@章",[_postHotList valueForKey:@"bible_title"],[[[_postHotList valueForKey:@"bid"]componentsSeparatedByString: @"-"] objectAtIndex:1]]];
            Cell.postIDString = [NSString stringWithFormat:@"%@", [_postHotList valueForKey:@"id"]];
            
            return Cell;
        }
            break;
            
        case PostsSection:
        {
            // TODO: add hot post section, 熱門討論可以跟一般討論使用同一個 class
            HTPostTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:PostCellName];
            if (Cell == nil) {
                Cell = [[HTPostTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PostCellName];
            }
            
            [Cell.likeBtn setHidden:YES];
            
            
            __weak HTPostTableViewCell *weakCell = Cell;
            NSURL *Url = [NSURL URLWithString:[_postNewList[indexPath.row] valueForKey:@"user_url"]];
            NSMutableURLRequest *UrlRequest = [NSMutableURLRequest requestWithURL:Url];
            
            [Cell.userImageView setImageWithURLRequest:UrlRequest
                                        placeholderImage:nil
                                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                     
                                                     NSLog(@"success");
                                                     weakCell.userImageView.image = image;
                                                     [weakCell setNeedsLayout];
                                                     
                                                 } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                                     NSLog(@"Failed : response = %@",response);
                                                     NSLog(@"Failed : error = %@", [error localizedDescription]);
                                                 }];
            
            
            [Cell.posterName setText:[NSString stringWithFormat:@"%@",[_postNewList[indexPath.row] valueForKey:@"user_name"]]];
            [Cell.DateLab setText:[NSString stringWithFormat:@"%@",[_postNewList[indexPath.row] valueForKey:@"date"]]];
            
            [Cell.postContentLab setText:[NSString stringWithFormat:@"%@",[_postNewList[indexPath.row] valueForKey:@"content"]]];
            
            [Cell.likeCountLab setText:[NSString stringWithFormat:@"%@",[_postNewList[indexPath.row] valueForKey:@"rank_count"]]];
            
            [Cell.responseLab setText:[NSString stringWithFormat:@"%@",[_postNewList[indexPath.row] valueForKey:@"response_count"]]];
            
            [Cell.titleLab setText:[NSString stringWithFormat:@"%@ 第%@章",[_postNewList[indexPath.row] valueForKey:@"bible_title"],[[[_postNewList[indexPath.row] valueForKey:@"bid"]componentsSeparatedByString: @"-"] objectAtIndex:1]]];
            
            
            return Cell;
        }
            break;

            
        default:
        {
            // Should not be here
            UITableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"defaultCell"];
            if (Cell == nil) {
                Cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaultCell"];
            }
            return Cell;
        }
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];

    if (indexPath.section == HotBibleSection) {

        HTHotBibleViewController *hotBiblePage = [storyboard instantiateViewControllerWithIdentifier:HotBiblePageID];
        [self.navigationController pushViewController:hotBiblePage animated:YES];

    } else if (indexPath.section == HotPostSection) {
        
        HTPostViewViewController *hotBiblePage = [storyboard instantiateViewControllerWithIdentifier:PostsPageID];
        hotBiblePage.postid = [_postHotList valueForKey:@"id"];
        hotBiblePage.contentInfo = _postHotList;
        [self.navigationController pushViewController:hotBiblePage animated:YES];
        
    } else if (indexPath.section == PostsSection) {
        HTPostViewViewController *hotBiblePage = [storyboard instantiateViewControllerWithIdentifier:PostsPageID];
        hotBiblePage.postid = [_postNewList[indexPath.row] valueForKey:@"id"];
        hotBiblePage.contentInfo = _postNewList[indexPath.row];
        [self.navigationController pushViewController:hotBiblePage animated:YES];
    }
}

-(void) headerCameraBtnClicked : (id) sender
{
    // TODO : GOTO camera page
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    [self presentViewController:_cameraView animated:YES completion:nil];
}

-(void) headerBibleBtnClicked : (id) sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    HTBaseNavigationViewController *BiblePage = [storyboard instantiateViewControllerWithIdentifier:BiblePageID];
    [self presentViewController:BiblePage animated:YES completion:nil];

}

-(void) presentWriteCommentView : (id) sender
{
    // TODO : GOTO bible select page
    NSLog(@"%s", __PRETTY_FUNCTION__);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    HTCommentViewController *CommentPage = [storyboard instantiateViewControllerWithIdentifier:CommentPageID];
    CommentPage.bibleInfo = _bibleInfoString;
    NSLog(@"BibleTitle = %@",_bibleTitle);
    CommentPage.bibleTitle = _bibleTitle;
//    [self presentViewController:CommentPage animated:YES completion:nil];
    [self.navigationController pushViewController:CommentPage animated:YES];
    
}



- (void) cameraNotification:(NSNotification*) notification
{
    _notificationBibleString = [notification object];
}

-(void) presentPostPageWithRecommendPost : (UIButton*) sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    HTPostViewViewController *hotBiblePage = [storyboard instantiateViewControllerWithIdentifier:PostsPageID];
    hotBiblePage.postid = [_popularManList[sender.tag] valueForKey:@"bid"];
    hotBiblePage.contentInfo = _postNewList[sender.tag];
    [self.navigationController pushViewController:hotBiblePage animated:YES];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
