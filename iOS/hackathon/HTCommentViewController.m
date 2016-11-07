//
//  HTCommentViewController.m
//  hackathon
//
//  Created by GIGIGUN on 04/11/2016.
//  Copyright © 2016 hippocolors. All rights reserved.
//

#import "HTCommentViewController.h"
#import "HTCommentToolbar.h"
#import "HTWriteViewController.h"

@interface HTCommentViewController ()
@property (strong, nonatomic) IBOutlet UITextView *bibleContentTextView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomLayout;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sendBtnClicked;
@property (strong, nonatomic) IBOutlet HTCommentToolbar *commendToolBar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barbutton;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITableView *hiddenTableView;

@end

@implementation HTCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _bibleTitle;
    self.navigationController.navigationItem.title = _bibleTitle;
    _serverObj = [ServerModule getInstance];
    
    [_serverObj GetTodayBibleInfoWithParameter:_bibleInfo Success:^(id responseObj) {
        [_bibleContentTextView setText:[responseObj valueForKey:@"content"]];
    } Failure:^(NSError *error) {
        NSLog(@"GetTodayBibleInfoWithParameter fail");
    }];

//    if (_isChapter) {
        UIBarButtonItem *activePostFunctionBtn = [[UIBarButtonItem alloc] initWithTitle:@"發表" style:UIBarButtonItemStylePlain target:self action:@selector(activePostFunctionBtnClicked:)];
        self.navigationItem.rightBarButtonItem = activePostFunctionBtn;
//    }
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardDidShow:)
//                                                 name:UIKeyboardDidShowNotification
//                                               object:nil];
    
    // Do any additional setup after loading the view.
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGFloat deltaHeight = kbSize.height;
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, deltaHeight, 0);

}


-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [_bibleContentTextView becomeFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismissBtnClicked:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)postBtnClicked:(id)sender {
    
}
- (IBAction)activePostFunctionBtnClicked:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    HTWriteViewController *CommentPage = [storyboard instantiateViewControllerWithIdentifier:WritePageID];
    CommentPage.bibleinfo = _bibleInfo;
    [self.navigationController pushViewController:CommentPage animated:YES];

}
- (IBAction)barbtnClicked:(id)sender {
    
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
