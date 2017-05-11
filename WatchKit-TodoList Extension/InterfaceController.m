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

@import WatchConnectivity;

@interface InterfaceController ()<WCSessionDelegate>

@property(strong,nonatomic) NSArray<Todo *> *allTodos;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *table;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *numberOfTodos;

@end

@implementation InterfaceController

- (void)willActivate {
    [super willActivate];
    
    [[WCSession defaultSession] setDelegate:self];
    [[WCSession defaultSession] activateSession];
    
    //the message parameter is where you would want to hand the iOS app new Todo data to save to Firebase
    
    [[WCSession defaultSession]sendMessage:@{} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        NSArray *todoDictionaries = replyMessage[@"todos"];
        
        NSMutableArray *allTodos = [[NSMutableArray alloc]init];
        
        for (NSDictionary *todoObject in todoDictionaries) {
            Todo *todo = [[Todo alloc]init];
            todo.title = todoObject[@"title"];
            todo.content = todoObject[@"content"];
            [allTodos addObject:todo];
        }
        
        self.allTodos = allTodos.copy;
        NSString *stringifiedNumber = [NSString stringWithFormat:@"%lu",(unsigned long)self.allTodos.count];
        [self.numberOfTodos setText:stringifiedNumber];
        
        [self setupTable];
        
    } errorHandler:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

- (void)didDeactivate {
    [super didDeactivate];
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
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

-(id)contextForSegueWithIdentifier:(NSString *)segueIdentifier inTable:(WKInterfaceTable *)table rowIndex:(NSInteger)rowIndex{
    return self.allTodos[rowIndex];
}

@end



