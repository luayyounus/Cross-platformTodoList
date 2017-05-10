//
//  TvDetailsViewController.m
//  Cross-platformTodoList
//
//  Created by Luay Younus on 5/9/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

#import "TvDetailsViewController.h"

@interface TvDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *todoContent;

@end

@implementation TvDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.todo.title;
    self.todoContent.text = self.todo.content;
}

@end
