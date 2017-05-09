//
//  NewTodoViewController.m
//  Cross-platformTodoList
//
//  Created by Luay Younus on 5/8/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

#import "NewTodoViewController.h"

@import Firebase;
@import FirebaseAuth;

@interface NewTodoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;

@end

@implementation NewTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)addTodoPressed:(UIButton *)sender {
    FIRDatabaseReference *databaseReference = [[FIRDatabase database]reference];
    FIRUser *currentUser = [[FIRAuth auth]currentUser];
    
    FIRDatabaseReference *userReference = [[databaseReference child:@"users"] child:currentUser.uid];
    FIRDatabaseReference *newTodoReference = [[userReference child:@"todos"] childByAutoId];
    
    [[newTodoReference child:@"title"] setValue:self.titleTextField.text];
    [[newTodoReference child:@"content"] setValue:self.contentTextField.text];
}

@end
