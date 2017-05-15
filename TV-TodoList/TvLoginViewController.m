//
//  TvLoginViewController.m
//  Cross-platformTodoList
//
//  Created by Luay Younus on 5/10/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

#import "TvLoginViewController.h"
#import "FirebaseAPI.h"
#import "TVHomeViewController.h"

@interface TvLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *email;

@end

@implementation TvLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)goButtonPressed:(UIButton *)sender {
    
    [FirebaseAPI fetchAllTodos:self.email.text andCompletion:^(NSArray<Todo *> *allTodos) {
        self.allTodos = allTodos;
        if (self.allTodos.firstObject != nil) {
            [[NSUserDefaults standardUserDefaults] setObject:self.email.text forKey:@"email"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Incorrect Email" message:@"Please enter a valid Email Address" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [alert dismissViewControllerAnimated:YES completion:nil];
            }];
            
            [alert addAction:okButton];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
}

@end
