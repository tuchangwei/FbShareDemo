//
//  ViewController.m
//  FacebookTwitterShareDemo
//
//  Created by tu changwei on 13-7-29.
//  Copyright (c) 2013年 tu changwei. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#define AppDel [[UIApplication sharedApplication]delegate]
#define AlertMSG(X) {\
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:X delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];\
                        [alert show];\
                    }
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ViewController

#pragma mark - Overrids
- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UI behavior

- (IBAction)shareToFB:(id)sender
{

//    NSURL *urlToShare = [NSURL URLWithString:@"http://developers.facebook.com/ios"];
//    BOOL displayedNativeDialog = [FBDialogs presentOSIntegratedShareDialogModallyFrom:self
//                                                                          initialText:[NSString stringWithFormat:@"Updating status at %@", [NSDate date]]
//                                                                                image:[UIImage imageNamed:@"psb.jpeg"]
//                                                                                  url:urlToShare
//                                                                              handler:nil];

//    if (!displayedNativeDialog) {


        AppDelegate *ad = AppDel;

        void (^action)(void) = ^(void){

            [FBRequestConnection startWithGraphPath:@"me/photos" parameters:@{@"message": self.titleLabel.text,@"picture":UIImageJPEGRepresentation(self.imageView.image, 1.0)} HTTPMethod:@"POST" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                NSLog(@"%@",[error description]);
            }];
        };
        if (!ad.session.isOpen)
        {
            //create session.
            ad.session = [[FBSession alloc] initWithPermissions:@[@"publish_actions"]];
           
            [ad.session openWithCompletionHandler:^(FBSession *session, FBSessionState status, NSError *error) {

                [self performPublishActionToFB:action currentSession:ad.session];

            }];
        }
        else
        {
    
            [self performPublishActionToFB:action currentSession:ad.session];

        }
//    }

}

- (IBAction)shareToTwitter:(id)sender
{
    
}

- (IBAction)changImageSize:(id)sender
{
    UIPinchGestureRecognizer *recognizer = (UIPinchGestureRecognizer *)sender;
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
}

# pragma mark - share to Facebook Helper


- (void)performPublishActionToFB:(void (^)(void)) action currentSession:(FBSession *)session
{
    [FBSession setActiveSession:session];
    action();
    

}
@end
