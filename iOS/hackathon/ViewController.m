//
//  ViewController.m
//  hackathon
//
//  Created by Ｗill on 2016/11/3.
//  Copyright © 2016年 hippocolors. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) ServerModule *serverObj;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
#warning [Casper] ViewController has been deprecated. HTMainPageViewController is the initial page
    _serverObj = [ServerModule getInstance];
    [_serverObj GetAllBibleInfoWithSuccess:^(id responseObj) {
        
//        NSArray *test = responseObj;
//        
//        for (int i=0;i<test.count;i++) {
//            NSLog(@"title = %@", [test[0] valueForKey:@"title"]);
//        }
        
//        NSLog(@"title = %@",[responseObj objectForKey:@"title"]);
//        for (NSDictionary *Obj in responseObj) {
//            NSString *title = [NSString stringWithFormat:@"%@", responseObj];
//            NSString *content = [NSString stringWithFormat:@"%@", [Obj objectForKey:@"content"]];
//            
//            NSLog(@"title = %@",title);
        
//        }
    } Failure:^(NSError *error) {
        NSLog(@"FAIL!!!");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
