//
//  HackaTutorViewController.m
//  hackathon
//
//  Created by GIGIGUN on 03/11/2016.
//  Copyright © 2016 hippocolors. All rights reserved.
//

#import "HackaTutorViewController.h"

@import Firebase;
@import FirebaseAuth;
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface HackaTutorViewController () <FBSDKLoginButtonDelegate>

@end

@implementation HackaTutorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.delegate = self;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
#pragma FBSDKLoginButtonDelegate -
    
- (void)loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
              error:(NSError *)error {
    if (error == nil) {
        // ...
    } else {
        NSLog(error.localizedDescription);
    }
}
    
- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    // Not handle logout here.
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
