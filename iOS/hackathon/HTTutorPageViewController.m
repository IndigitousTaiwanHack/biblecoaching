//
//  HTTutorPageViewController.m
//  hackathon
//
//  Created by GIGIGUN on 04/11/2016.
//  Copyright © 2016 hippocolors. All rights reserved.
//

#import "HTTutorPageViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "HTBaseTabbarController.h"

@interface HTTutorPageViewController (){
    NSString *idstr;
    NSString *namestr;
}

@property (strong, nonatomic) ServerModule *serverObj;

@end

@implementation HTTutorPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(test:) name:FBSDKAccessTokenDidChangeNotification object:nil];
    
    
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
        NSLog(@"Get notification appID %@", [[FBSDKAccessToken currentAccessToken] appID]);
        NSLog(@"Get notification tokenString %@", [[FBSDKAccessToken currentAccessToken] tokenString]);
        NSLog(@"Get notification expirationDate %@", [[FBSDKAccessToken currentAccessToken] expirationDate]);
        NSLog(@"Get notification userID %@", [[FBSDKAccessToken currentAccessToken] userID]);
    }
//    
//    
//    // get facebook user info
//    NSLog(@"Get notification appID %@", [[FBSDKAccessToken currentAccessToken] appID]);
//    NSLog(@"Get notification tokenString %@", [[FBSDKAccessToken currentAccessToken] tokenString]);
//    NSLog(@"Get notification expirationDate %@", [[FBSDKAccessToken currentAccessToken] expirationDate]);
//    NSLog(@"Get notification userID %@", [[FBSDKAccessToken currentAccessToken] userID]);
//    
//    
//    if ([FBSDKAccessToken currentAccessToken]) {
//        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
//         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//             if (!error) {
//                 NSLog(@"fetched user:%@", result);
//             }
//         }];
//    }
    
    // For more complex open graph stories, use `FBSDKShareAPI`
    // with `FBSDKShareOpenGraphContent`
    /* make the API call */
//    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
//                                  initWithGraphPath:@"me/picture"
//                                  parameters:@{@"height" : @100, @"redirect" : @0, @"type": @"square", @"width" : @100}
//                                  HTTPMethod:@"GET"];
//    
//    
//
//    
//    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
//                                          id result,
//                                          NSError *error) {
//        // Handle the result
//        NSLog(@"fetched user:%@, url = %@", result,[[result objectForKey:@"data"] objectForKey:@"url"]);
//        
//        if ([[result objectForKey:@"data"] objectForKey:@"url"]) {
//            [fbinfo setValue:[[result objectForKey:@"data"] objectForKey:@"url"] forKey:@"FBURL"];
//        }
//        
//        
//        
//        if ([[result objectForKey:@"data"] objectForKey:@"name"]) {
//            [fbinfo setValue:[[result objectForKey:@"data"] objectForKey:@"name"] forKey:@"FBNAME"];
//        }
//        
//        
//        // TODO: convert imageUrl to UIImage and base64 string
//        
//    }];
//
//    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) test:(NSNotification*) notification
{
    NSLog(@"Get notification appID %@", [[FBSDKAccessToken currentAccessToken] appID]);
    NSLog(@"Get notification tokenString %@", [[FBSDKAccessToken currentAccessToken] tokenString]);
    NSLog(@"Get notification expirationDate %@", [[FBSDKAccessToken currentAccessToken] expirationDate]);
    NSLog(@"Get notification userID %@", [[FBSDKAccessToken currentAccessToken] userID]);
    NSLog(@"Get notification permissions %@", [[FBSDKAccessToken currentAccessToken] permissions]);
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 
                 NSLog(@"fetched user:%@", result);
                 
                 idstr = [[NSString alloc]initWithFormat:@"%@",[result valueForKey:@"id"]];
                 namestr = [[NSString alloc]initWithFormat:@"%@",[result valueForKey:@"name"]];

                 // For more complex open graph stories, use `FBSDKShareAPI`
                 // with `FBSDKShareOpenGraphContent`
                 /* make the API call */
                 FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                               initWithGraphPath:@"me/picture"
                                               parameters:@{@"height" : @100, @"redirect" : @0, @"type": @"square", @"width" : @100}
                                               HTTPMethod:@"GET"];
                 
                 
                 [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                                       id result2,
                                                       NSError *error) {
                     // Handle the result
                     NSLog(@"fetched user:%@", result2);
                     
                     // TODO: convert imageUrl to UIImage and base64 string
                     
                     NSDictionary *test = @{@"uid":idstr,@"name":namestr,@"provider":[NSString stringWithFormat:@"facebook"],@"url":[[result2 valueForKey:@"data"] valueForKey:@"url"]};
                     
                     _serverObj = [ServerModule getInstance];
                     [_serverObj RegisterAccountWithParameters:test Success:^(id responseObj) {
                         NSLog(@"responseObj = %@,result = %@",responseObj,[responseObj objectForKey:@"result"]);
                         
                         [HTFBModule SaveFBInfo:test];
                         
                         // [Casper] present main tabController
                         [self presentWriteCommentView:nil];
                         
                     } Failure:^(NSError *error) {
                         NSLog(@"RegisterAccountWithParameters error!!");
                     }];
                 }];
             }
         }];
    }
}


-(void) presentWriteCommentView : (id) sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    HTBaseTabbarController *MainPageTabbar = [storyboard instantiateViewControllerWithIdentifier:BaseTabbarPageID];
    [self presentViewController:MainPageTabbar animated:YES completion:nil];
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
