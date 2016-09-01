//
//  Task.h
//  ToDoListPraOBJC
//
//  Created by ling toby on 9/1/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
/*
 kind	string	Type of the resource. This is always "tasks#task".
 id	string	Task identifier.
 etag	etag	ETag of the resource.
 title	string	Title of the task.
 updated	datetime	Last modification time of the task (as a RFC 3339 timestamp).
 selfLink	string	URL pointing to this task. Used to retrieve, update, or delete this task.
 parent	string	Parent task identifier. This field is omitted if it is a top-level task. This field is read-only. Use the "move" method to move the task under a different parent or to the top level.
 position	string	String indicating the position of the task among its sibling tasks under the same parent task or at the top level. If this string is greater than another task's corresponding position string according to lexicographical ordering, the task is positioned after the other task under the same parent task (or at the top level). This field is read-only. Use the "move" method to move the task to another position.
 notes	string	Notes describing the task. Optional.
 status	string	Status of the task. This is either "needsAction" or "completed".
 due	datetime	Due date of the task (as a RFC 3339 timestamp). Optional.
 completed	datetime	Completion date of the task (as a RFC 3339 timestamp). This field is omitted if the task has not been completed.
 deleted	boolean	Flag indicating whether the task has been deleted. The default if False.
 hidden	boolean	Flag indicating whether the task is hidden. This is the case if the task had been marked completed when the task list was last cleared. The default is False. This field is read-only.
 links[]	list	Collection of links. This collection is read-only.
 links[].type	string	Type of the link, e.g. "email".
 links[].description	string	The description. In HTML speak: Everything between <a> and </a>.
 links[].link	string	The URL. */

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (nonatomic, strong) NSString *taskId;
@property (nonatomic, strong) NSString *taskTitle;
@property (nonatomic, strong) NSURL *taskUrl;
@property (nonatomic) int position;
@property (nonatomic, strong) NSString *taskNote;
@property (nonatomic) Boolean taskStatus;
@property (nonatomic, strong) NSDate *taskDueDate;
@property (nonatomic, strong) NSDate *taskCompletedDate;
@property (nonatomic) Boolean taskDeleted;



@end
