//
//  TVHomeViewController.h
//  Cross-platformTodoList
//
//  Created by Luay Younus on 5/9/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"

@interface TVHomeViewController : UIViewController

@property (strong, nonatomic) NSArray<Todo *> *allTvTodos;

@end
