//
//  TvLoginViewController.m
//  Cross-platformTodoList
//
//  Created by Luay Younus on 5/10/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

#import "TvLoginViewController.h"
#import "FirebaseAPI.h"


@interface TvLoginViewController ()

@property (strong, nonatomic) NSArray<Todo *> *allTodos;
@property (weak, nonatomic) IBOutlet UITextField *email;

@end

@implementation TvLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [FirebaseAPI fetchAllTodos:^(NSArray<Todo *> *allTodos) {
        self.allTodos = allTodos;
    }];
}
- (IBAction)goButtonPressed:(UIButton *)sender {
    if (![self.email.text isEqualToString:self.allTodos.firstObject.email]) {
        NSLog(@"Not FOUND");
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
