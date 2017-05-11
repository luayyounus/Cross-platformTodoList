//
//  ViewController.m
//  Cross-platformTodoList
//
//  Created by Luay Younus on 5/8/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "Todo.h"
#import "CompletedTodoViewController.h"

@import Firebase;
@import FirebaseAuth;

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic) FIRDatabaseReference *userReference;
@property(strong,nonatomic) FIRUser *currentUser;
@property(nonatomic) FIRDatabaseHandle allTodosHandler;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *todoHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableTopConstraint;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic) NSMutableArray *allTodos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
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
        
        self.allTodos = [[NSMutableArray alloc]init];
        
        CompletedTodoViewController *CVC = self.tabBarController.viewControllers[1];
        CVC.allCompletedTodos = [[NSMutableArray alloc]init];
        
        
        for (FIRDataSnapshot *child in snapshot.children) {
            NSDictionary *todoData = child.value;
            
            Todo *todo = [[Todo alloc]init];
            todo.title = todoData[@"title"];
            todo.content = todoData[@"content"];
            todo.key = todoData[@"key"];
            todo.isCompleted = todoData[@"isCompleted"];
            Boolean booleanCompleted = todo.isCompleted.boolValue;
            
            if (booleanCompleted == 0) {
                [self.allTodos addObject:todo];
            } else {
                [CVC.allCompletedTodos addObject:todo];
            }
            NSLog(@"Todo Title: %@ - Content: %@ - isCompleted: %@",todo.title,todo.content,todo.isCompleted);
        }

        [self.tableView reloadData];
    }];
}

- (IBAction)plusButtonPressed:(UIBarButtonItem *)sender {
    if (self.todoHeightConstraint.constant > 0){
        self.tableTopConstraint.constant = 0;
        self.todoHeightConstraint.constant = 0;
        [UIView animateWithDuration:0.6 animations:^{
            [self.view layoutIfNeeded];
        }];
    } else {
        self.tableTopConstraint.constant = 175;
        self.todoHeightConstraint.constant = 175;
        [UIView animateWithDuration:0.6 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}
- (IBAction)logoutButtonPressed:(UIBarButtonItem *)sender {
    NSError *signOutError;
    [[FIRAuth auth]signOut:&signOutError];
    [self checkUserStatus];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allTodos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Todo *todo = self.allTodos[indexPath.row];
    cell.textLabel.text = todo.title;
    cell.detailTextLabel.text = todo.content;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Todo *todo = self.allTodos[indexPath.row];
    self.userReference = [[FIRDatabase database]reference];
    
    [[[[[[self.userReference child:@"users"]child:self.currentUser.uid]child:@"todos"]child:todo.key]child:@"isCompleted"]setValue:@1];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    Todo *todo = self.allTodos[indexPath.row];
    self.userReference = [[FIRDatabase database]reference];
    
    [[[[[self.userReference child:@"users"]child:self.currentUser.uid]child:@"todos"]child:todo.key]removeValue];
    
}

@end
