//
//  TVHomeViewController.m
//  Cross-platformTodoList
//
//  Created by Luay Younus on 5/9/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

#import "TVHomeViewController.h"
#import "TvDetailsViewController.h"
#import "Todo.h"
#import "FirebaseAPI.h"
#import "TvLoginViewController.h"

@interface TVHomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray<Todo *> *allTodos;

@end

@implementation TVHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self checkUserStatus];
    [FirebaseAPI fetchAllTodos:^(NSArray<Todo *> *allTodos) {
        NSLog(@"All Todos: %@",allTodos);
        self.allTodos = allTodos;
        [self.tableView reloadData];
    }];
}

-(void)checkUserStatus{
    if (!self.allTodos.firstObject.email) {
        TvLoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TvLoginViewController"];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"TvDetailsViewController" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [super prepareForSegue:segue sender:self];
    Todo *todo = self.allTodos[self.tableView.indexPathForSelectedRow.row];
    TvDetailsViewController *detailsVC = segue.destinationViewController;
    detailsVC.todo = todo;
}

@end
