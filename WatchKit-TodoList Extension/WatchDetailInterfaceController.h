//
//  WatchDetailInterfaceController.h
//  Cross-platformTodoList
//
//  Created by Luay Younus on 5/9/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

#import "InterfaceController.h"
#import "Todo.h"

@interface WatchDetailInterfaceController : WKInterfaceController

@property(strong,nonatomic) Todo *todo;

@end
