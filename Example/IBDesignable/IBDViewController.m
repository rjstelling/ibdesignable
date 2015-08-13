//
//  IBDViewController.m
//  IBDesignable
//
//  Created by Richard Stelling on 15/05/2015.
//  Copyright (c) 2015 Richard Stelling. All rights reserved.
//

#import "IBDViewController.h"
#import "UITableViewController+IBDesignable.h"

@implementation IBDViewController

- (IBAction)onToggleRefreshController:(UISwitch *)sender
{
    // If you want to set or get the value of refreshController
    // you first need to:
    //    #import "UITableViewController+IBDesignable.h"
    
    self.refreshController = sender.on;
}

@end
