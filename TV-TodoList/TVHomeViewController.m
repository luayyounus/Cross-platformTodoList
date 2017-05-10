//
//  TVHomeViewController.m
//  Cross-platformTodoList
//
//  Created by Luay Younus on 5/9/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

#import "TVHomeViewController.h"
#import "Todo.h"

@interface TVHomeViewController ()<UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray<Todo *> *allTodos;

@end

@implementation TVHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    
}

-(NSArray<Todo *> *)allTodos{
    Todo *firstTodo = [[Todo alloc]init];
    firstTodo.title = @"First Todo";
    firstTodo.content = @"This is a todo";
    
    Todo *secondTodo = [[Todo alloc]init];
    secondTodo.title = @"Second Todo";
    secondTodo.content = @"This is another todo";
    
    Todo *thirdTodo = [[Todo alloc]init];
    thirdTodo.title = @"First Todo";
    thirdTodo.content = @"This is another todo";
    
    return @[firstTodo,secondTodo, thirdTodo];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.allTodos[indexPath.row].title;
    cell.detailTextLabel.text = self.allTodos[indexPath.row].content;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allTodos.count;
}

@end
