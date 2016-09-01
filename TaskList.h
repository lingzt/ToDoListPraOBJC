//
//  TaskList.h
//  ToDoListPraOBJC
//
//  Created by ling toby on 9/1/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
/*
 kind	string	Type of the resource. This is always "tasks#taskList".
 id	string	Task list identifier.
 etag	string	ETag of the resource.
 title	string	Title of the task list.
 selfLink	string	URL pointing to this task list. Used to retrieve, update, or delete this task list.
 updated	datetime	Last modification time of the task list (as a RFC 3339 timestamp).
 
 */

#import <Foundation/Foundation.h>

@interface TaskList : NSObject
@property (nonatomic,strong) NSString *taskListId;
@property (nonatomic,strong) NSString *taskListTitle;
@property (nonatomic,strong) NSURL *taskListUrl;

@end
