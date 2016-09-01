//
//  CheckUserTokenViewController.m
//  ToDoListPraOBJC
//
//  Created by ling toby on 9/1/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "CheckUserTokenViewController.h"

@interface CheckUserTokenViewController ()

@end

@implementation CheckUserTokenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"lajasalkdgjlasjdg____________%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"accessToken"]);
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
