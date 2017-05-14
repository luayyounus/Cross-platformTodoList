//
//  FirebaseAPI.h
//  Cross-platformTodoList
//
//  Created by Luay Younus on 5/10/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Todo.h"

typedef void(^AllTodosCompletion)(NSArray<Todo *> *allTodos);

@interface FirebaseAPI : NSObject

+(void)fetchAllTodos:(NSString *)email andCompletion:(AllTodosCompletion)completion;
@end
