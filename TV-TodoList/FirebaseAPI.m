//
//  FirebaseAPI.m
//  Cross-platformTodoList
//
//  Created by Luay Younus on 5/10/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

#import "FirebaseAPI.h"
#import "Credentials.h"

@implementation FirebaseAPI

+(void)fetchAllTodos:(AllTodosCompletion)completion{
    NSString *urlString = [NSString stringWithFormat:@"https://cross-platform-todo-list-4fe1e.firebaseio.com/users.json?auth=%@",APP_KEY];
    NSURL *databaseURL = [NSURL URLWithString:urlString];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
    [[session dataTaskWithURL:databaseURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"Root Object:%@",rootObject);
        
        NSMutableArray *allTodos = [[NSMutableArray alloc]init];
        
        for (NSDictionary *userTodosDictionary in [rootObject allValues]) {
            NSArray *userTodos = [userTodosDictionary[@"todos"] allValues];
            
            for (NSDictionary *todoDictionary in userTodos) {
                Todo *newTodo = [[Todo alloc]init];
                newTodo.title = todoDictionary[@"title"];
                newTodo.content = todoDictionary[@"content"];
                
                [allTodos addObject:newTodo];
            }
        }
        
        if (completion) {
            completion(allTodos);
        }
    }] resume];
}

@end