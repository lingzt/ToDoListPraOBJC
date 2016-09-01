//
//  Task.m
//  ToDoListPraOBJC
//
//  Created by ling toby on 9/1/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
/*
 @property (nonatomic, strong) NSString *taskId;
 @property (nonatomic, strong) NSString *taskTitle;
 @property (nonatomic, strong) NSURL *taskUrl;
 @property (nonatomic) int position;
 @property (nonatomic, strong) NSString *taskNote;
 @property (nonatomic) Boolean taskStatus;
 @property (nonatomic, strong) NSDate *taskDueDate;
 @property (nonatomic, strong) NSDate *taskCompletedDate;
 @property (nonatomic) Boolean taskDeleted;
 */

#import "Task.h"

@implementation Task

-(id)initTaskWithDictionary: (NSDictionary *)jSonDict{
    self = [super init];
    self.taskId = jSonDict[@"id"];
    self.taskTitle = jSonDict[@"position"];
    if (jSonDict[@"title"]){
        self.taskTitle = jSonDict[@"title"];
    }
    if (jSonDict[@"selfLink"]){
        self.taskTitle = jSonDict[@"selfLink"];
    }
    if (jSonDict[@"position"]){
        self.taskTitle = jSonDict[@"position"];
    }
    if ([jSonDict[@"status"]  isEqual: @"needsAction"]){
        self.taskStatus = false;
    }else if ([jSonDict[@"status"]  isEqual: @"completed"]){
        self.taskStatus = true;
    }
    return self;
}

@end
