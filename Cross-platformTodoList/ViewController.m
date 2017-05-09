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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *todoHeightConstraint;

@property(nonatomic) FIRDatabaseHandle allTodosHandler;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self checkUserStatus];
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

- (IBAction)plusButtonPressed:(UIBarButtonItem *)sender {
    if (self.todoHeightConstraint.constant > 0){
        self.todoHeightConstraint.constant = 0;
        [UIView animateWithDuration:0.6 animations:^{
            [self.view layoutIfNeeded];
        }];
    } else {
        self.todoHeightConstraint.constant = 175;
        [UIView animateWithDuration:0.6 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    
}


- (IBAction)logoutButtonPressed:(UIBarButtonItem *)sender {
    NSError *signOutError;
    [[FIRAuth auth]signOut:&signOutError];
}




@end
