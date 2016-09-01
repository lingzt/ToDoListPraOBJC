//
//  ViewController.h
//  ToDoListPraOBJC
//
//  Created by ling toby on 8/30/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTMOAuth2ViewControllerTouch.h"
#import "GTLTasks.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) GTLServiceTasks *service;
@property (nonatomic, retain) GTMOAuth2Authentication *auth;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightButton;


@end

