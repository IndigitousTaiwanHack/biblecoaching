//
//  cameraViewController.m
//  EmotionTest
//
//  Created by GIGIGUN on 30/10/2016.
//  Copyright © 2016 GIGIGUN. All rights reserved.
//

#import "cameraViewController.h"
#import "LLSimpleCamera.h"
#import "ViewUtils.h"
#import "ImageViewController.h"
#import "EmotionDetect.h"
#import "SCLAlertView.h"
#import "HTMainPageViewController.h"

#define BUTTON_DIFF     85

@interface cameraViewController ()
@property (strong,nonatomic) LLSimpleCamera *simpleCamera;

@property (strong, nonatomic) UILabel *errorLabel;
//@property (strong, nonatomic) IBOutlet UIButton *snapBtn;
@property (strong, nonatomic) UIButton *snapBtn;
@property (strong, nonatomic) UIButton *switchButton;
@property (strong, nonatomic) UIButton *flashButton;
@property (strong, nonatomic) UISegmentedControl *segmentedControl;
@property (strong, nonatomic) UIButton *deleteBtn;
- (void) dismissCameraView;
@property (strong, nonatomic) IBOutlet UIScrollView *recommandScroller;

@property (strong, nonatomic) UIButton *happyBtn;
@property (strong, nonatomic) UIButton *emotion2Btn;
@property (strong, nonatomic) UIButton *emotion3Btn;
@property (strong, nonatomic) UIButton *emotion4Btn;

@end

@implementation cameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    _recommandScroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0,screenRect.size.height-100, screenRect.size.width,100)];
    
    // create camera vc
    _simpleCamera = [[LLSimpleCamera alloc] initWithQuality:AVCaptureSessionPresetHigh
                                                 position:LLCameraPositionFront
                                             videoEnabled:NO];
    
    // attach to a view controller
    [_simpleCamera attachToViewController:self withFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    
    // read: http://stackoverflow.com/questions/5427656/ios-uiimagepickercontroller-result-image-orientation-after-upload
    // you probably will want to set this to YES, if you are going view the image outside iOS.
    _simpleCamera.fixOrientationAfterCapture = NO;
    
    // take the required actions on a device change
    __weak typeof(self) weakSelf = self;
    
    [_simpleCamera setOnError:^(LLSimpleCamera *camera, NSError *error) {
        NSLog(@"Camera error: %@", error);
        
        if([error.domain isEqualToString:LLSimpleCameraErrorDomain]) {
            if(error.code == LLSimpleCameraErrorCodeCameraPermission ||
               error.code == LLSimpleCameraErrorCodeMicrophonePermission) {
                
                if(weakSelf.errorLabel) {
                    [weakSelf.errorLabel removeFromSuperview];
                }
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
                label.text = @"We need permission for the camera.\nPlease go to your settings.";
                label.numberOfLines = 2;
                label.lineBreakMode = NSLineBreakByWordWrapping;
                label.backgroundColor = [UIColor clearColor];
                label.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:13.0f];
                label.textColor = [UIColor whiteColor];
                label.textAlignment = NSTextAlignmentCenter;
                [label sizeToFit];
                label.center = CGPointMake(screenRect.size.width / 2.0f, screenRect.size.height / 2.0f);
                weakSelf.errorLabel = label;
                [weakSelf.view addSubview:weakSelf.errorLabel];
            }
        }
    }];

    [self initCameraComponent];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initCameraComponent
{

    // ----- camera buttons -------- //

    [self initScrollView];
    [self.view addSubview:_recommandScroller];
    
    [self initCancelBtn];
    [self.view addSubview:_deleteBtn];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_simpleCamera start];
}

-(void) showAlert:(NSString*) link andEmotion:(NSDictionary*) emotion{
    
//    NSString *title = @"Title";
//    NSString *message = @"Message";
////    NSString *cancel = @"Cancel";
//    NSString *done = @"Done";
//    
//    UIImage *image = [UIImage imageNamed:@"Like"];
////    if (type == 0) {
////        image = [UIImage imageNamed:@"Like"];
////    }
////    else if(type == 1){
////        image = [UIImage imageNamed:@"book"];
////    }
////    else
////        image = [UIImage imageNamed:@"photo-camera"];
//
//        
//    SCLALertViewButtonBuilder *doneButton = [SCLALertViewButtonBuilder new].title(done);
//
//    
//    SCLAlertViewBuilder *builder = [SCLAlertViewBuilder new]
//    .showAnimationType(SCLAlertViewShowAnimationFadeIn)
//    .hideAnimationType(SCLAlertViewHideAnimationFadeOut)
//    .shouldDismissOnTapOutside(NO)
////    .addTextFieldWithBuilder(textField)
//    .addButtonWithBuilder(doneButton);
//    
//    SCLAlertViewShowBuilder *showBuilder = [SCLAlertViewShowBuilder new]
//    .style(SCLAlertViewStyleCustom)
//    .image(image)
//    .color([UIColor clearColor])
//    .title(title)
//    .subTitle(message)
//    .closeButtonTitle(done)
//    .duration(0.0f);
//    
//    [showBuilder showAlertView:builder.alertView onViewController:self];
//    [[NSNotificationCenter defaultCenter] postNotificationName:CameraNotification object:link];
    
//    [self dismissCameraView];
    
    NSLog(@"emotion = %@",emotion );
    
    NSLog(@"%@",[emotion valueForKey:@"anger"] );
    NSLog(@"%@",[emotion valueForKey:@"contempt"] );
    NSLog(@"%@",[emotion valueForKey:@"disgust"] );
    NSLog(@"%@",[emotion valueForKey:@"fear"] );
    NSLog(@"%@",[emotion valueForKey:@"happiness"] );
    NSLog(@"%@",[emotion valueForKey:@"neutral"] );
    NSLog(@"%@",[emotion valueForKey:@"sadness"] );
    NSLog(@"%@",[emotion valueForKey:@"surprise"] );
    
    
    NSLog(@"anger = %@",[emotion valueForKey:@"anger"]);
    NSLog(@"anger = %.5f",[[NSString stringWithFormat:@"%@",[emotion valueForKey:@"anger"]] doubleValue]);
    
    //生氣 / 輕蔑 / 噁心 / 害怕  / 快樂 / 中立 / 傷心 / 驚訝
    NSNumber *emotion1 = [NSNumber numberWithFloat:[[NSString stringWithFormat:@"%@",[emotion valueForKey:@"anger"]] doubleValue]];
    NSNumber *emotion2 = [NSNumber numberWithFloat:[[NSString stringWithFormat:@"%@",[emotion valueForKey:@"contempt"]] doubleValue]];
    NSNumber *emotion3 = [NSNumber numberWithFloat:[[NSString stringWithFormat:@"%@",[emotion valueForKey:@"disgust"]] doubleValue]];
    NSNumber *emotion4 = [NSNumber numberWithFloat:[[NSString stringWithFormat:@"%@",[emotion valueForKey:@"fear"]] doubleValue]];
    NSNumber *emotion5 = [NSNumber numberWithFloat:[[NSString stringWithFormat:@"%@",[emotion valueForKey:@"happiness"]] doubleValue]];
    NSNumber *emotion6 = [NSNumber numberWithFloat:[[NSString stringWithFormat:@"%@",[emotion valueForKey:@"neutral"]] doubleValue]];
    NSNumber *emotion7 = [NSNumber numberWithFloat:[[NSString stringWithFormat:@"%@",[emotion valueForKey:@"sadness"]] doubleValue]];
    NSNumber *emotion8 = [NSNumber numberWithFloat:[[NSString stringWithFormat:@"%@",[emotion valueForKey:@"surprise"]] doubleValue]];
    
//    NSNumber *emotion2 = [NSNumber numberWithFloat:[[emotion valueForKey:@"contempt"] floatValue]];
//    NSNumber *emotion3 = [NSNumber numberWithFloat:[[emotion valueForKey:@"disgust"] floatValue]];
//    NSNumber *emotion4 = [NSNumber numberWithFloat:[[emotion valueForKey:@"fear"] floatValue]];
//    NSNumber *emotion5 = [NSNumber numberWithFloat:[[emotion valueForKey:@"happiness"] floatValue]];
//    NSNumber *emotion6 = [NSNumber numberWithFloat:[[emotion valueForKey:@"neutral"] floatValue]];
//    NSNumber *emotion7 = [NSNumber numberWithFloat:[[emotion valueForKey:@"sadness"] floatValue]];
//    NSNumber *emotion8 = [NSNumber numberWithFloat:[[emotion valueForKey:@"surprise"] floatValue]];
    
    NSArray *arr = [[NSArray alloc]initWithObjects:
                    emotion1,
                    emotion2,
                    emotion3,
                    emotion4,
                    emotion5,
                    emotion6,
                    emotion7,
                    emotion8,
                    nil];
    
    NSArray *arr2 = [[NSArray alloc]initWithObjects:
                    emotion1,
                    emotion2,
                    emotion3,
                    emotion4,
                    emotion5,
                    emotion6,
                    emotion7,
                    emotion8,
                    nil];
    
    NSArray *arr3 = [[NSArray alloc]initWithObjects:
                     @"開心點，不要生氣囉!",
                     @"微笑一下",
                     @"這並不噁心~~",
                     @"與上帝同在，不害怕！",
                     @"今天是一個好天!",
                     @"累了嗎?放鬆一下！",
                     @"一天的擔憂，一天當就好！",
                     @"哇哇哇！",
                     nil];

//
//    
//    NSNumber *max=[arr2 valueForKeyPath:@"@max.doubleValue"];
////
//    NSLog(@"max = %f",[max floatValue]);
    
//    int index = 0;
//    for (int i=0;i < [arr2 count]; i++) {
//        if ([[arr objectAtIndex:i] doubleValue] >= 0.6) {
//            index = i;
//            break;
//        }
//    }
    
    NSInteger myInteger = arc4random()%8;
    NSString *str = [NSString stringWithFormat:@"%@",[arr3 objectAtIndex:myInteger]];
//
//    
    
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:str
                                                            preferredStyle:  UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"確定"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                    [[NSNotificationCenter defaultCenter] postNotificationName:CameraNotification object:link];
                                    [self dismissCameraView];
                                    
                                }];
    
//    UIAlertAction* noButton = [UIAlertAction
//                               actionWithTitle:@"取消"
//                               style:UIAlertActionStyleCancel
//                               handler:^(UIAlertAction * action) {
//                                   //Handle no, thanks button
//                               }];
    
    [alert addAction:yesButton];
//    [alert addAction:noButton];
    
    
    [self presentViewController:alert animated:true completion:nil];
}


- (IBAction)snapBtnClicked:(id)sender {
    
//    __weak typeof(self) weakSelf = self;
    
    UIButton *btn = (UIButton*) sender;
    
    if (btn.tag == 1) {

        [_simpleCamera capture:^(LLSimpleCamera *camera, UIImage *image, NSDictionary *metadata, NSError *error) {
            if(!error) {
                
    //            ImageViewController *imageVC = [[ImageViewController alloc] initWithImage:image];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    __block NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
    //                __block UIViewController *viewController = self;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        EmotionDetect *emotionDetect = [EmotionDetect getInstance];
                        if (imageData) {
                            
                            [emotionDetect getEmotionDetectWithImageData:imageData Success:^(id responseObj) {
                                NSLog(@"response = %@", responseObj);
                                
                                
                                [[ServerModule getInstance] GetBibleFromEmotionWithSuccess:^(id responseObj2) {
                                    
                                    
                                    NSLog(@"emotion = %@",[responseObj valueForKey:@"scores"]);
                                    
                                    NSLog(@"%@",[[responseObj2 valueForKey:@"bible"] valueForKey:@"bid"]);
    //                               [self showAlert:[[responseObj valueForKey:@"bible"] valueForKey:@"bid"]];
                                    
                                    [self showAlert:[[responseObj2 valueForKey:@"bible"] valueForKey:@"bid"] andEmotion:[responseObj valueForKey:@"scores"]];
                                } Failure:^(NSError *error) {
                                    
                                }];
                                
                                
                            } Failure:^(NSError *error) {
                                NSLog(@"Failed");
                            }];
                            
                        } else {
                            NSLog(@"imageData == nil");
                        }
                    });
                });
                
    //            [weakSelf presentViewController:imageVC animated:NO completion:nil];
            }
            else {
                NSLog(@"An error has occured: %@", error);
            }
        } exactSeenImage:YES];
    }
    else{
        [[ServerModule getInstance] GetBibleFromEmotionWithSuccess:^(id responseObj3) {
            
            NSLog(@"bible link = %@",[[responseObj3 valueForKey:@"bible"] valueForKey:@"bid"]);
            [[NSNotificationCenter defaultCenter] postNotificationName:CameraNotification object:[[responseObj3 valueForKey:@"bible"] valueForKey:@"bid"]];
            [self dismissCameraView];
        } Failure:^(NSError *error) {
            NSLog(@"GetBibleFromEmotionWithSuccess Error");
        }];
    }

}

- (IBAction)switchBtnClicked:(id)sender {
    [_simpleCamera togglePosition];
}

- (IBAction)flashBtnClicked:(id)sender {
    
    
    if (IS_OS_10_OR_LATER) {
        
        NSLog(@"!!!");
        AVCapturePhotoSettings *setting = [AVCapturePhotoSettings photoSettings];
        
        if (setting.flashMode == AVCaptureFlashModeOn) {
            setting.flashMode = AVCaptureFlashModeOff;
        } else {
            setting.flashMode = AVCaptureFlashModeOn;
//            [device setTorchMode:AVCaptureTorchModeOn];

        }
        
    } else {
    
        if(_simpleCamera.flash == LLCameraFlashOff) {
            BOOL done = [_simpleCamera updateFlashMode:LLCameraFlashOn];
            if(done) {
                self.flashButton.selected = YES;
                self.flashButton.tintColor = [UIColor yellowColor];
            }
        } else {
            BOOL done = [_simpleCamera updateFlashMode:LLCameraFlashOff];
            if(done) {
                self.flashButton.selected = NO;
                self.flashButton.tintColor = [UIColor whiteColor];
            }
        }
    }
}

-(void) initSnapBtn
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    _snapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _snapBtn.clipsToBounds = YES;
    _snapBtn.frame = CGRectMake(self.view.center.x - (70.0f/2), (screenRect.size.height - 30 - 70.0f), 70.0f, 70.0f);
    _snapBtn.layer.cornerRadius = _snapBtn.width / 2.0f;
    _snapBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _snapBtn.layer.borderWidth = 2.0f;
    _snapBtn.backgroundColor = GlobalColor;
    _snapBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _snapBtn.layer.shouldRasterize = YES;
    [_snapBtn addTarget:self action:@selector(snapBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [_snapBtn setCenter:self.view.center];
}

-(void) initScrollView{
    
    _snapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _snapBtn.clipsToBounds = YES;
    _snapBtn.frame = CGRectMake(10+BUTTON_DIFF*0,20, 60.0f, 60.0f);
    _snapBtn.layer.cornerRadius = _snapBtn.width / 2.0f;
    _snapBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _snapBtn.layer.borderWidth = 2.0f;
    _snapBtn.backgroundColor = GlobalColor;
    _snapBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _snapBtn.layer.shouldRasterize = YES;
    [_snapBtn addTarget:self action:@selector(snapBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _snapBtn.tag = 1;
    
    [_recommandScroller addSubview:_snapBtn];
    
    _happyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _happyBtn.clipsToBounds = YES;
    _happyBtn.frame = CGRectMake(BUTTON_DIFF*1,20, 60.0f, 60.0f);
//    _happyBtn.imageView.image = [UIImage imageNamed:@"happy1"];
    [_happyBtn setImage:[UIImage imageNamed:@"happy1"] forState:UIControlStateNormal];
    _happyBtn.layer.cornerRadius = _snapBtn.width / 2.0f;
    _happyBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _happyBtn.layer.borderWidth = 2.0f;
    _happyBtn.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    _happyBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _happyBtn.layer.shouldRasterize = YES;
    [_happyBtn addTarget:self action:@selector(snapBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _happyBtn.tag = 2;
    
    [_recommandScroller addSubview:_happyBtn];
    
    _emotion2Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _emotion2Btn.clipsToBounds = YES;
    _emotion2Btn.frame = CGRectMake(BUTTON_DIFF*2,20, 60.0f, 60.0f);
    _emotion2Btn.layer.cornerRadius = _snapBtn.width / 2.0f;
    _emotion2Btn.layer.borderColor = [UIColor whiteColor].CGColor;
    _emotion2Btn.layer.borderWidth = 2.0f;
    _emotion2Btn.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [_emotion2Btn setImage:[UIImage imageNamed:@"angry"] forState:UIControlStateNormal];

    _emotion2Btn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _emotion2Btn.layer.shouldRasterize = YES;
    [_emotion2Btn addTarget:self action:@selector(snapBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _emotion2Btn.tag = 3;
    
    [_recommandScroller addSubview:_emotion2Btn];
    
    
    _emotion3Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _emotion3Btn.clipsToBounds = YES;
    _emotion3Btn.frame = CGRectMake(BUTTON_DIFF*3,20, 60.0f, 60.0f);
    _emotion3Btn.layer.cornerRadius = _snapBtn.width / 2.0f;
    _emotion3Btn.layer.borderColor = [UIColor whiteColor].CGColor;
    _emotion3Btn.layer.borderWidth = 2.0f;
    _emotion3Btn.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    _emotion3Btn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _emotion3Btn.layer.shouldRasterize = YES;
    [_emotion3Btn setImage:[UIImage imageNamed:@"sad"] forState:UIControlStateNormal];

    [_emotion3Btn addTarget:self action:@selector(snapBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _emotion3Btn.tag = 4;
    
    [_recommandScroller addSubview:_emotion3Btn];
    
    
    _emotion4Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _emotion4Btn.clipsToBounds = YES;
    _emotion4Btn.frame = CGRectMake(BUTTON_DIFF*4,20, 60.0f, 60.0f);
    _emotion4Btn.layer.cornerRadius = _snapBtn.width / 2.0f;
    _emotion4Btn.layer.borderColor = [UIColor whiteColor].CGColor;
    _emotion4Btn.layer.borderWidth = 2.0f;
    _emotion4Btn.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    _emotion4Btn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _emotion4Btn.layer.shouldRasterize = YES;
    [_emotion4Btn setImage:[UIImage imageNamed:@"happy"] forState:UIControlStateNormal];
    _emotion4Btn.tag = 5;

    [_emotion4Btn addTarget:self action:@selector(snapBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [_recommandScroller addSubview:_emotion4Btn];
    
    CGSize size = CGSizeMake(88 * (4 + 1),0);
    _recommandScroller.contentSize = size;
    _recommandScroller.backgroundColor = ScrollBgColor;
}

-(void) initCancelBtn{
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteBtn.clipsToBounds = YES;
    _deleteBtn.frame = CGRectMake(20,30, 25, 25);
//    _deleteBtn.layer.cornerRadius = _deleteBtn.width / 2.0f;
//    _deleteBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//    _deleteBtn.layer.borderWidth = 2.0f;
//    _deleteBtn.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
////    [_deleteBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    _deleteBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _deleteBtn.layer.shouldRasterize = YES;
    [_deleteBtn setImage:[UIImage imageNamed:@"close-button"] forState:UIControlStateNormal];

    [_deleteBtn addTarget:self action:@selector(dismissCameraView) forControlEvents:UIControlEventTouchUpInside];
}

- (void) dismissCameraView{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void) initFlashBtn
{
    // button to toggle flash
    _flashButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _flashButton.tintColor = [UIColor whiteColor];
    [_flashButton setImage:[UIImage imageNamed:@"flash-on-indicator"] forState:UIControlStateNormal];
    [_flashButton addTarget:self action:@selector(flashBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_flashButton setCenter:self.view.center];
    
    CGRect frame = _flashButton.frame;
    frame.size = CGSizeMake(30, 30);
    frame.origin = CGPointMake(self.view.center.x - (frame.size.width/2), 20);
    _flashButton.frame = frame;
    
}

-(void) showEmotionLabel
{
    
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
