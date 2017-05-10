//
//  watchNewTodo.m
//  Cross-platformTodoList
//
//  Created by Luay Younus on 5/9/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

#import "watchNewTodo.h"

@implementation watchNewTodo
- (IBAction)addTodo {
    NSArray *suggestions = @[@"Get groceries", @"Walk the dog", @"Pay bills"];
    [self presentTextInputControllerWithSuggestions:suggestions allowedInputMode:WKTextInputModePlain completion:^(NSArray * _Nullable results) {
        NSLog(@"%@", results);
    }];
}

@end
