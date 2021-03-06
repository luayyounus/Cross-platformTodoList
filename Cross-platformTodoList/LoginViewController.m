//
//  LoginViewController.m
//  Cross-platformTodoList
//
//  Created by Luay Younus on 5/8/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

#import "LoginViewController.h"
#import "SignupViewController.h"

@import FirebaseAuth;

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.childViewControllers[0] view].hidden = YES;
}

- (IBAction)loginPressed:(id)sender {
    [[FIRAuth auth]signInWithEmail:self.emailTextField.text password:self.passwordTextField.text completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        if (error){
            NSLog(@"Error Signing In: %@",error.localizedDescription);
            [self.childViewControllers[0] view].hidden = NO;
            
        }
        if(user){
            NSLog(@"Logged In User: %@",user);
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

@end
