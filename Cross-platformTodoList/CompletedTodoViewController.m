//
//  CompletedTodoViewController.m
//  Cross-platformTodoList
//
//  Created by Luay Younus on 5/10/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

#import "CompletedTodoViewController.h"
#import "Todo.h"

@interface CompletedTodoViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CompletedTodoViewController

-(void)setAllCompletedTodos:(NSMutableArray *)allCompletedTodos{
    _allCompletedTodos = allCompletedTodos;
    [self.tableView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allCompletedTodos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Todo *currentTodo = self.allCompletedTodos[indexPath.row];
    cell.textLabel.text = currentTodo.title;
    cell.detailTextLabel.text = currentTodo.content;
    
    return cell;
}

@end
