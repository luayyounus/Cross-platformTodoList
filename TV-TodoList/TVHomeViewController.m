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
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self checkUserStatus];
}

-(void)checkUserStatus{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *email = [userDefaults stringForKey:@"email"];
    
    if (!email) {
        TvLoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TvLoginViewController"];
        [self presentViewController:loginVC animated:YES completion:nil];
    } else {
        [FirebaseAPI fetchAllTodos:email andCompletion:^(NSArray<Todo *> *allTodos) {
            self.allTvTodos = allTodos;
            [self.tableView reloadData];
        }];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
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

@end
