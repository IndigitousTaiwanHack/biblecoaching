//
//  HTHotBibleViewController.m
//  hackathon
//
//  Created by GIGIGUN on 04/11/2016.
//  Copyright © 2016 hippocolors. All rights reserved.
//

#import "HTHotBibleViewController.h"
#import "HTPostTableViewCell.h"
#import "HTPostViewViewController.h"
#define HotPostCellName            @"PostCell"

@interface HTHotBibleViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HTHotBibleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"熱門經文";
    
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 300;
    
        [_tableView registerNib:[UINib nibWithNibName:@"HTPostTableViewCell" bundle:nil] forCellReuseIdentifier:HotPostCellName];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HTPostTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:HotPostCellName];
    
    if (Cell == nil) {
        Cell = [[HTPostTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HotPostCellName];
    }
    Cell.likeBtn.hidden = YES;
    
    return Cell;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    HTPostViewViewController *hotBiblePage = [storyboard instantiateViewControllerWithIdentifier:PostsPageID];
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
