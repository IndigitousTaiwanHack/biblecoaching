//
//  HTBibleViewController.m
//  hackathon
//
//  Created by GIGIGUN on 04/11/2016.
//  Copyright © 2016 hippocolors. All rights reserved.
//

#import "HTBibleViewController.h"
#import "HTBibleTableViewCell.h"
#import "HTBibleChapterViewController.h"
@interface HTBibleViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation HTBibleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _bibleContent = [[NSMutableArray alloc]init];
    _serverObj = [ServerModule getInstance];
    
    [_serverObj GetBookListWithSuccess:^(id responseObj) {
        _bibleContent = [responseObj valueForKey:@"books"];
        [_tableview reloadData];
    } Failure:^(NSError *error) {
        NSLog(@"GetBookListWithSuccess Error!");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_bibleContent count];
    
}
- (IBAction)cancleBtnClicked:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HTBibleTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (Cell == nil) {
        Cell = [[HTBibleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    Cell.prefixLab.text = [_bibleContent[indexPath.row] valueForKey:@"abbr"];
    Cell.TitleLab.text = [_bibleContent[indexPath.row] valueForKey:@"title"];
    
    return Cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: 取得點擊聖經的章數~
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    HTBibleChapterViewController *ChapterPage = [storyboard instantiateViewControllerWithIdentifier:BibleChapterPageID];
    
    ChapterPage.bookid = [NSString stringWithFormat:@"%ld",(indexPath.row+1)];
    ChapterPage.bibleTitle = [_bibleContent[indexPath.row] valueForKey:@"title"];
    [self.navigationController pushViewController:ChapterPage animated:YES];
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
