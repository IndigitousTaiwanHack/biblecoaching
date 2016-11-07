//
//  HTBibleChapterViewController.m
//  hackathon
//
//  Created by GIGIGUN on 05/11/2016.
//  Copyright © 2016 hippocolors. All rights reserved.
//

#import "HTBibleChapterViewController.h"
#import "HTBibleTableViewCell.h"
#import "HTCommentViewController.h"

@interface HTBibleChapterViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation HTBibleChapterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = _bibleTitle;
    _bibleChapter = [[NSMutableArray alloc]init];
    _serverObj = [ServerModule getInstance];
    
    NSLog(@"book id = %@",_bookid);
    
    NSDictionary *bookDic2 = @{@"book_id":_bookid};
    
    [_serverObj GetChapterListWithParameter:bookDic2 Success:^(id responseObj) {
        
        NSLog(@"GetChapterListWithParameter responseObj = %@",responseObj);
        _bibleChapter = [responseObj valueForKey:@"bibles"];
        [_tableview reloadData];
        
    } Failure:^(NSError *error) {
        NSLog(@"GetChapterListWithParameter fail");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HTBibleTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (Cell == nil) {
        Cell = [[HTBibleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    Cell.TitleLab.text = [NSString stringWithFormat:@"第 %@ 章",[[[_bibleChapter[indexPath.row] valueForKey:@"bid"] componentsSeparatedByString: @"-"] objectAtIndex:1]];
    
    return Cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_bibleChapter count];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: 取得點擊聖經的內容~
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    HTCommentViewController *CommentPage = [storyboard instantiateViewControllerWithIdentifier:CommentPageID];
    CommentPage.navBar.hidden = YES;
    CommentPage.bibleInfo = [_bibleChapter[indexPath.row] valueForKey:@"bid"];
    CommentPage.title = [NSString stringWithFormat:@"%@ %@",_bibleTitle,[NSString stringWithFormat:@"第 %@ 章",[[[_bibleChapter[indexPath.row] valueForKey:@"bid"] componentsSeparatedByString: @"-"] objectAtIndex:1]]];
    CommentPage.isChapter = YES;
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
