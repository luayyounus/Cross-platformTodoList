//
//  SignupViewController.m
//  Cross-platformTodoList
//
//  Created by Luay Younus on 5/8/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

#import "SignupViewController.h"
@import FirebaseAuth;

@interface SignupViewController ()

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.childViewControllers[0] view].hidden = YES;
}

-(IBAction)createAccountPressed:(UIButton *)sender {
    [[FIRAuth auth] createUserWithEmail:self.emailTextField.text password:self.passwordTextField.text completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error Signing up new User: %@", error.localizedDescription);
            [self.childViewControllers[0] view].hidden = NO;
            

        }
        if(user){
            NSLog(@"SignedUp: %@",user);
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

@end
