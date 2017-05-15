//
//  TVHomeViewController.m
//  Cross-platformTodoList
//
//  Created by Luay Younus on 5/9/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

#import "TVHomeViewController.h"
#import "TvDetailsViewController.h"
#import "FirebaseAPI.h"
#import "TvLoginViewController.h"

@interface TVHomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation TVHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:@"displayTodosOnTv" object:nil];
    [self checkUserStatus];
}

-(void)checkUserStatus{
    TvLoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TvLoginViewController"];
    [self presentViewController:loginVC animated:YES completion:nil];
}

-(void)setAllTvTodos:(NSArray<Todo *> *)allTvTodos{
    _allTvTodos = allTvTodos;
    NSLog(@"Todos inside the Setter: %@",self.allTvTodos);
}

- (void)reloadTableView{
    NSLog(@"Todos outside the setter %@",self.allTvTodos);

    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"number of row in section %@",self.allTvTodos);
    return self.allTvTodos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.allTvTodos[indexPath.row].title;
    cell.detailTextLabel.text = self.allTvTodos[indexPath.row].content;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"TvDetailsViewController" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [super prepareForSegue:segue sender:self];
    Todo *todo = self.allTvTodos[self.tableView.indexPathForSelectedRow.row];
    TvDetailsViewController *detailsVC = segue.destinationViewController;
    detailsVC.todo = todo;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"displayTodosOnTv" object:nil];
}

@end
