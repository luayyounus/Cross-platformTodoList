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
            NSLog(@"Email doesn't exist in Database!");
        }
    }];
}

@end
