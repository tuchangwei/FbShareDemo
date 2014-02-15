//
//  AppDelegate.h
//  FacebookTwitterShareDemo
//
//  Created by tu changwei on 13-7-29.
//  Copyright (c) 2013年 tu changwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (strong, nonatomic) FBSession *session;
@end
