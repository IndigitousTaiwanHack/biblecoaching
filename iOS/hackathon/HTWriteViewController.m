//
//  HTWriteViewController.m
//  hackathon
//
//  Created by GIGIGUN on 05/11/2016.
//  Copyright © 2016 hippocolors. All rights reserved.
//

#import "HTWriteViewController.h"
#import "HTFBModule.h"

@interface HTWriteViewController ()
@property (strong, nonatomic) IBOutlet UITextView *writeTextView;
@property (strong, nonatomic) IBOutlet UIToolbar *writeToolbar;
@end

@implementation HTWriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _writeTextView.inputAccessoryView = _writeToolbar;
    // Do any additional setup after loading the view.
}

-(void) viewDidAppear:(BOOL)animated
{
    [_writeTextView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sendBtn:(id)sender {
    // TODO: post comment
    
    NSLog(@"kk test dic = %@",[HTFBModule GetFBInfo]);
    NSLog(@"kk fb id = %@,_bibleinfo = %@",[HTFBModule GetFBID],_bibleinfo);
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    
    
    
    NSLog(@"dic = %@",dic);
    
    if (_isReply) {
        // TODO : post replay
        [dic setValue:[HTFBModule GetFBID] forKey:@"uid"];
        [dic setValue:@"facebook" forKey:@"provider"];
        [dic setValue:_writeTextView.text forKey:@"content"];
        [dic setValue:_postid forKey:@"post_id"];
        
        [[ServerModule getInstance] PostDiscussWithParameter:dic Success:^(id responseObj) {
            if ([[responseObj valueForKey:@"result"] isEqual:[NSNumber numberWithInt:0]]) {
                NSLog(@"PostDiscussWithParameter responseObj = %@",responseObj);
            }
        } Failure:^(NSError *error) {
            NSLog(@"PostDiscussWithParameter Fail");
        }];
    } else {
        
        NSLog(@"_bibleinfo = %@",_bibleinfo);
        [dic setValue:[HTFBModule GetFBID] forKey:@"uid"];
        [dic setValue:@"facebook" forKey:@"provider"];
        [dic setValue:_writeTextView.text forKey:@"content"];
        [dic setValue:_bibleinfo forKey:@"bible_bid"];
        
        [[ServerModule getInstance] PostWithParameter:dic Success:^(id responseObj) {
            if ([[responseObj valueForKey:@"result"] isEqual:[NSNumber numberWithInt:0]]) {
                NSLog(@"PostWithParameter responseObj = %@",responseObj);
            }
        } Failure:^(NSError *error) {
            NSLog(@"PostWithParameter Fail");
        }];
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
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
