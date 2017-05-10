//
//  InterfaceController.m
//  WatchKit-TodoList Extension
//
//  Created by Luay Younus on 5/9/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

#import "InterfaceController.h"
#import "Todo.h"
#import "TodoRowController.h"

@interface InterfaceController ()

@property(strong,nonatomic) NSArray<Todo *> *allTodos;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *table;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *numberOfTodos;

@end

@implementation InterfaceController

- (void)willActivate {
    [super willActivate];
}

- (void)didDeactivate {
    [super didDeactivate];
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    NSString *stringifiedNumber = [NSString stringWithFormat:@"%lu",(unsigned long)self.allTodos.count];
    [self.numberOfTodos setText:stringifiedNumber];
    
    [self setupTable];
}

-(void)setupTable{
    [self.table setNumberOfRows:self.allTodos.count withRowType:@"TodoRowController"];
    for (NSInteger i = 0; i < self.allTodos.count; i++){
        TodoRowController *rowController = [self.table rowControllerAtIndex:i];
        [rowController.titleLabel setText:self.allTodos[i].title];
        [rowController.contentLabel setText:self.allTodos[i].content];
    }
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

@end



