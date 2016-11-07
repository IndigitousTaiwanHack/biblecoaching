//
//  HTPostViewViewController.m
//  hackathon
//
//  Created by GIGIGUN on 05/11/2016.
//  Copyright © 2016 hippocolors. All rights reserved.
//

#import "HTPostViewViewController.h"
#import "HTPostTableViewCell.h"
#import "HPPostResponseTableViewCell.h"
#import "HTWriteViewController.h"
#import "UIImageView+AFNetworking.h"

#define  PostCellName            @"PostCell"
#define  ResponseCellName        @"responseCell"


@interface HTPostViewViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *responseList;
@property (strong, nonatomic) ServerModule *serverObj;
@end

@implementation HTPostViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"熱門討論";
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 300;
    
    _responseList = [[NSMutableArray alloc]init];
    _serverObj = [ServerModule getInstance];
    
    [_tableView registerNib:[UINib nibWithNibName:@"HTPostTableViewCell" bundle:nil] forCellReuseIdentifier:PostCellName];

    UIBarButtonItem *activePostFunctionBtn = [[UIBarButtonItem alloc] initWithTitle:@"回覆" style:UIBarButtonItemStylePlain target:self action:@selector(replyBtnBtnClicked:)];
    self.navigationItem.rightBarButtonItem = activePostFunctionBtn;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSLog(@"kk post id = %@",_postid);
    
    NSDictionary *dic = @{@"post_id":_postid};
    
    [_serverObj GetResponseListWithParameter:dic Success:^(id responseObj) {
        if ([[responseObj valueForKey:@"result"] isEqual:[NSNumber numberWithInt:0]]) {
            _responseList = [responseObj valueForKey:@"responses"];
            [_tableView reloadData];
        }
    } Failure:^(NSError *error) {
        NSLog(@"GetResponseListWithParameter fail");
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return [_responseList count];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        HTPostTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:PostCellName];
        
        if (Cell == nil) {
            Cell = [[HTPostTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PostCellName];
        }
        
        __weak HTPostTableViewCell *weakCell = Cell;
        NSURL *Url = [NSURL URLWithString:[_contentInfo valueForKey:@"user_url"]];
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
        
        [Cell.posterName setText:[NSString stringWithFormat:@"%@", [_contentInfo valueForKey:@"user_name"]]];
        
        [Cell.DateLab setText:[NSString stringWithFormat:@"%@", [_contentInfo valueForKey:@"date"]]];
        
        [Cell.postContentLab setText:[NSString stringWithFormat:@"%@", [_contentInfo valueForKey:@"content"]]];
        
        [Cell.titleLab setText:[NSString stringWithFormat:@"%@ 第%@章",[_contentInfo valueForKey:@"bible_title"],[[[_contentInfo valueForKey:@"bid"]componentsSeparatedByString: @"-"] objectAtIndex:1]]];
        
        [Cell.likeCountLab setText:[NSString stringWithFormat:@"%@", [_contentInfo valueForKey:@"rank_count"]]];
        
        [Cell.responseLab setText:[NSString stringWithFormat:@"%@", [_contentInfo valueForKey:@"response_count"]]];
        
        
        return Cell;
        
    } else {
        
        HPPostResponseTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:ResponseCellName];
        
        if (Cell == nil) {
            Cell = [[HPPostResponseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ResponseCellName];
        }
        
        __weak HPPostResponseTableViewCell *weakCell = Cell;
        NSURL *Url = [NSURL URLWithString:[_responseList[indexPath.row] valueForKey:@"user_url"]];
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
        
        [Cell.username setText:[NSString stringWithFormat:@"%@",[_responseList[indexPath.row] valueForKey:@"user_name"]]];
        [Cell.datetime setText:[NSString stringWithFormat:@"%@",[_responseList[indexPath.row] valueForKey:@"date"]]];
        [Cell.userreply setText:[NSString stringWithFormat:@"%@",[_responseList[indexPath.row] valueForKey:@"content"]]];
        
        return Cell;
        
    }
    
}

-(void) replyBtnBtnClicked : (id) sender
{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    HTWriteViewController *CommentPage = [storyboard instantiateViewControllerWithIdentifier:WritePageID];
    CommentPage.postid = _postid;
    [self.navigationController pushViewController:CommentPage animated:YES];
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
