//
//  ErrorViewController.m
//  Cross-platformTodoList
//
//  Created by Luay Younus on 5/9/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

#import "ErrorViewController.h"

@interface ErrorViewController ()

@end

@implementation ErrorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)closeSignupErrorPressed:(UIButton *)sender {
    self.view.hidden = YES;
    
}

- (IBAction)closeLoginErrorPressed:(UIButton *)sender {
    self.view.hidden = YES;
}
@end
