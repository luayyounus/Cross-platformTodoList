//
//  ViewController.m
//  Cross-platformTodoList
//
//  Created by Luay Younus on 5/8/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"

@import Firebase;
@import FirebaseAuth;

@interface ViewController ()

@property(strong,nonatomic) FIRDatabaseReference *userReference;
@property(strong,nonatomic) FIRUser *currentUser;

@property(nonatomic) FIRDatabaseHandle allTodosHandler;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self checkUserStatus];
    //    [self setupFirebase];
}

-(void)checkUserStatus{
    if (![[FIRAuth auth] currentUser]){
        LoginViewController *loginController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self presentViewController:loginController animated:YES completion:nil];
    } else {
        [self setupFirebase];
        [self startMonitoringTodoUpdates];
    }
    return;
}

-(void)setupFirebase{
    FIRDatabaseReference *databaseReference = [[FIRDatabase database]reference];
    self.currentUser = [[FIRAuth auth]currentUser];
    self.userReference = [[databaseReference child:@"users"] child:self.currentUser.uid];
    NSLog(@"USER REFEREE: %@",self.userReference);
}
-(void)startMonitoringTodoUpdates{
    self.allTodosHandler = [[self.userReference child:@"todos"]observeEventType:FIRDataEventTypeValue andPreviousSiblingKeyWithBlock:^(FIRDataSnapshot * _Nonnull snapshot, NSString * _Nullable prevKey) {
        
        //        NSMutableArray *allTodos = [[NSMutableArray alloc]init];
        for (FIRDataSnapshot *child in snapshot.children) {
            NSDictionary *todoData = child.value;
            
            NSString *todoTitle = todoData[@"title"];
            NSString *todoContent = todoData[@"content"];
            
            //append new todo to all todoArray//
            
            NSLog(@"Todo Title: %@ - Content: %@",todoTitle,todoContent);
        }
    }];
}

- (IBAction)logoutButtonPressed:(UIBarButtonItem *)sender {
    NSError *signOutError;
    [[FIRAuth auth]signOut:&signOutError];
}




@end
