//
//  WatchDetailInterfaceController.m
//  Cross-platformTodoList
//
//  Created by Luay Younus on 5/9/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

#import "WatchDetailInterfaceController.h"

@interface WatchDetailInterfaceController()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *detailLabel;
@end

@implementation WatchDetailInterfaceController

-(void)awakeWithContext:(id)context{
    self.todo = (Todo *)context;
    [self.detailLabel setText:self.todo.content];
}

@end
