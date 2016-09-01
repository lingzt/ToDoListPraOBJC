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

@interface ViewController : UIViewController

@property (nonatomic, strong) GTLServiceTasks *service;
@property (nonatomic, strong) UITextView *output;
@property (nonatomic, retain) GTMOAuth2Authentication *auth;


@end

