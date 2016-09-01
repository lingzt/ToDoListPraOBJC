//
//  ViewController.m
//  ToDoListPraOBJC
//
//  Created by ling toby on 8/30/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "ViewController.h"



static NSString *const kKeychainItemName = @"Google Tasks API";
static NSString *const kClientID = @"224581339946-osi7sqrtm1aj2lregm6tcm703afa3vqv.apps.googleusercontent.com";

@implementation ViewController

@synthesize service = _service;
@synthesize output = _output;

// When the view loads, create necessary subviews, and initialize the Google Tasks API service.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create a UITextView to display output.
    self.output = [[UITextView alloc] initWithFrame:self.view.bounds];
    self.output.editable = false;
    self.output.contentInset = UIEdgeInsetsMake(20.0, 0.0, 20.0, 0.0);
    self.output.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.output];

    
    // Initialize the Google Tasks API service & load existing credentials from the keychain if available.
    self.service = [[GTLServiceTasks alloc] init];
    self.service.authorizer =
    [GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:kKeychainItemName
                                                          clientID:kClientID
                                                      clientSecret:nil];
}

// When the view appears, ensure that the Google Tasks API service is authorized, and perform API calls.
- (void)viewDidAppear:(BOOL)animated {
    if (!self.service.authorizer.canAuthorize) {
        // Not yet authorized, request authorization by pushing the login UI onto the UI stack.
        [self presentViewController:[self createAuthController] animated:YES completion:nil];
        
    } else {
        [self fetchTasks];
    }
    
}

// Construct a query to get a user's task lists using the Google Tasks API.
- (void)fetchTasks {
    self.output.text = @"Getting task lists...";
    GTLQueryTasks *query =
    [GTLQueryTasks queryForTasklistsList];
    query.maxResults = 10;
    [self.service executeQuery:query
                      delegate:self
             didFinishSelector:@selector(displayResultWithTicket:finishedWithObject:error:)];
}

// Process the response and display output.
- (void)displayResultWithTicket:(GTLServiceTicket *)ticket
             finishedWithObject:(GTLTasksTaskLists *)taskLists
                          error:(NSError *)error {
    if (error == nil) {
        NSMutableString *taskListsString = [[NSMutableString alloc] init];
        if (taskLists.items.count > 0) {
            [taskListsString appendString:@"Task lists:\n"];
            for (GTLTasksTaskList *taskList in taskLists) {
                [taskListsString appendFormat:@"the tastlist's title is: %@ \nThe tasklist identifier is (%@)\n", taskList.title, taskList.identifier];
                NSLog(@"the tastlist's title is: %@ \nThe tasklist identifier is (%@)\n", taskList.title, taskList.identifier);
                
                
                NSDictionary *parameters = @{@"access_token":[[NSUserDefaults standardUserDefaults] valueForKey:@"accessToken"]};
                
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.requestSerializer = [AFJSONRequestSerializer serializer];
                manager.responseSerializer = [AFJSONResponseSerializer serializer];
                manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
                manager.securityPolicy.allowInvalidCertificates = YES;
                manager.securityPolicy.validatesDomainName = NO;
                

                
                NSString *urlString = [NSString stringWithFormat:@"https://www.googleapis.com/tasks/v1/lists/%@/tasks", taskList.identifier];

                [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSLog(@"_________________________JSON: %@", responseObject);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSLog(@"_________________________Error: %@", error);
                }];
           
            }
                
            }
        }
    }
    


// Creates the auth controller for authorizing access to Google Tasks API.
- (GTMOAuth2ViewControllerTouch *)createAuthController {
    GTMOAuth2ViewControllerTouch *authController;

    // If modifying these scopes, delete your previously saved credentials by
    // resetting the iOS simulator or uninstall the app.
    NSArray *scopes = [NSArray arrayWithObjects:kGTLAuthScopeTasksReadonly, nil];
    authController = [[GTMOAuth2ViewControllerTouch alloc]
                      initWithScope:[scopes componentsJoinedByString:@" "]
                      clientID:kClientID
                      clientSecret:nil
                      keychainItemName:kKeychainItemName
                      delegate:self
                      finishedSelector:@selector(viewController:finishedWithAuth:error:)];
    return authController;
}

// Handle completion of the authorization process, and update the Google Tasks API
// with the new credentials.
- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)authResult
                 error:(NSError *)error {
    if (error != nil) {
        [self showAlert:@"Authentication Error" message:error.localizedDescription];
        self.service.authorizer = nil;
        // Authentication failed
        NSLog(@"!!!!Authentication Failed");
    }
    else {
        self.service.authorizer = authResult;
        [self dismissViewControllerAnimated:YES completion:nil];
        // Authentication succeeded
        self.auth = authResult;
        
        [[NSUserDefaults standardUserDefaults] setObject:authResult.accessToken forKey:@"accessToken"];
        [[NSUserDefaults standardUserDefaults] setObject:authResult.refreshToken forKey:@"refreshToken"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

// Helper for showing an alert
- (void)showAlert:(NSString *)title message:(NSString *)message {
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:title
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok =
    [UIAlertAction actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action)
     {
         [alert dismissViewControllerAnimated:YES completion:nil];
     }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    
}

@end
