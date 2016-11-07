//
//  HTBaseTabbarController.m
//  hackathon
//
//  Created by GIGIGUN on 04/11/2016.
//  Copyright © 2016 hippocolors. All rights reserved.
//

#import "HTBaseTabbarController.h"

@interface HTBaseTabbarController ()

@end

@implementation HTBaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[UITabBar appearance] setTintColor:GlobalColor];

    
    for (UITabBarItem *items in self.tabBar.items) {
        items.title = @"";
        items.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    }

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
