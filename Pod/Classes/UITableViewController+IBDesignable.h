//
//  UITableView+IBDesignable.h
//  IBDesignable
//
//  Created by Richard Stelling on 13/08/2015.
//  https://github.com/rjstelling/ibdesignable
//

#import <UIKit/UIKit.h>

@interface UITableViewController (IBDesignable)

/**
 *  @author Richard Stelling (mailto:richard@empiricalmagic.com)
 *
 *  Adds a standard refresh control (UIRefreshControl) to the UITableView
 *
 */
@property (nonatomic, getter=hasRefreshController) IBInspectable BOOL refreshController;

@end
