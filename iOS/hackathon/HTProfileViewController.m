//
//  HTProfileViewController.m
//  hackathon
//
//  Created by GIGIGUN on 04/11/2016.
//  Copyright © 2016 hippocolors. All rights reserved.
//

#import "HTProfileViewController.h"
#import "HTProfileHeaderTableViewCell.h"
#import "HTPostTableViewCell.h"
#import "HTFBModule.h"
#import <AFNetworking/AFNetworking.h>
#import "UIImageView+AFNetworking.h"
#import "ServerModule.h"


#define ProfileHeaderCellName @"profileHeaderCell"
#define PostCellName            @"PostCell"


@interface HTProfileViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) ServerModule *serverObj;
@property (strong, nonatomic) NSString *postCount;
@property (strong, nonatomic) NSString *postRankCount;
@property (strong, nonatomic) NSMutableArray *postList;
@end

@implementation HTProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _postCount = @"";
    _postRankCount = @"";
    _postList = [[NSMutableArray alloc]init];
    
    _serverObj = [ServerModule getInstance];
    
    
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 300;
    
    [_tableView registerNib:[UINib nibWithNibName:@"HTPostTableViewCell" bundle:nil] forCellReuseIdentifier:PostCellName];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_serverObj GetUserProfileWithSuccess:^(id responseObj) {
        
        NSLog(@"GetUserProfileWithSuccess responseObj = %@",responseObj);
        if ([[responseObj valueForKey:@"result"] isEqual:[NSNumber numberWithInt:0]]) {
            _postCount = [[responseObj valueForKey:@"user"] valueForKey:@"post_count"];
            _postRankCount = [[responseObj valueForKey:@"user"] valueForKey:@"post_rank_count"];
            
            [_tableView reloadData];
        }
        else{
            NSLog(@"GetUserProfileWithSuccess result = %@",[responseObj valueForKey:@"result"]);
        }
    } Failure:^(NSError *error) {
        NSLog(@"GetUserProfileWithSuccess Fail");
    }];
    
    
    [_serverObj GetUserProfileHistoryWithSuccess:^(id responseObj) {
        if ([[responseObj valueForKey:@"result"] isEqual:[NSNumber numberWithInt:0]]) {
            _postList = [responseObj valueForKey:@"posts"];
            [_tableView reloadData];
        }
        else{
            NSLog(@"GetUserProfileWithSuccess result = %@",[responseObj valueForKey:@"result"]);
        }
        
    } Failure:^(NSError *error) {
        
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 1) {
        return [_postList count];
    }
    else
        return 1;

}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        HTProfileHeaderTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:ProfileHeaderCellName];
        if (Cell == nil) {
            Cell = [[HTProfileHeaderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ProfileHeaderCellName];
        }
    
        __weak HTProfileHeaderTableViewCell *weakCell = Cell;
        NSURL *Url = [NSURL URLWithString:[HTFBModule GetImageUrl]];
        NSMutableURLRequest *UrlRequest = [NSMutableURLRequest requestWithURL:Url];

        [Cell.userImage setImageWithURLRequest:UrlRequest
                                     placeholderImage:nil
                                              success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                  weakCell.userImage.image = image;
                                                  [weakCell setNeedsLayout];
                                                  
                                              } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                                  NSLog(@"Failed : response = %@",response);
                                                  NSLog(@"Failed : error = %@", [error localizedDescription]);
                                              }];
        

        [Cell.userName setText:[HTFBModule GetFBName]];
        [Cell.userPostCountLab setText:[NSString stringWithFormat:@"%@",_postCount]];
        [Cell.userPostLikeCountLab setText:[NSString stringWithFormat:@"%@",_postRankCount]];
        return Cell;

    } else {
        
        HTPostTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:PostCellName];
        if (Cell == nil) {
            Cell = [[HTPostTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PostCellName];
        }
        
        [Cell.likeBtn setHidden:YES];
        [Cell.posterName setText:[NSString stringWithFormat:@"%@",[HTFBModule GetFBName]]];
        
        __weak HTPostTableViewCell *weakCell = Cell;
        NSURL *Url = [NSURL URLWithString:[_postList[indexPath.row] valueForKey:@"user_url"]];
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
        
        
        [Cell.titleLab setText:[NSString stringWithFormat:@"%@ 第%@章",[_postList[indexPath.row] valueForKey:@"bible_title"],[[[_postList[indexPath.row] valueForKey:@"bid"]componentsSeparatedByString: @"-"] objectAtIndex:1]]];
        [Cell.postContentLab setText:[NSString stringWithFormat:@"%@",[_postList[indexPath.row] valueForKey:@"bible_content"]]];
        [Cell.DateLab setText:[NSString stringWithFormat:@"%@",[_postList[indexPath.row] valueForKey:@"date"]]];
        
        [Cell.likeCountLab setText:[NSString stringWithFormat:@"%@",[_postList[indexPath.row] valueForKey:@"rank_count"]]];
        [Cell.responseLab setText:[NSString stringWithFormat:@"%@",[_postList[indexPath.row] valueForKey:@"response_count"]]];
        return Cell;
    }
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
