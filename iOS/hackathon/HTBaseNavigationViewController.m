//
//  HTBaseNavigationViewController.m
//  hackathon
//
//  Created by GIGIGUN on 05/11/2016.
//  Copyright © 2016 hippocolors. All rights reserved.
//

#import "HTBaseNavigationViewController.h"

@interface HTBaseNavigationViewController ()

@end

@implementation HTBaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary * navBarTitleTextAttributes =
    @{ NSForegroundColorAttributeName : [UIColor whiteColor],};
    [[UINavigationBar appearance] setTitleTextAttributes:navBarTitleTextAttributes];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
