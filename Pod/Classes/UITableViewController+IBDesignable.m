//
//  UITableView+IBDesignable.m
//  Pods
//
//  Created by Richard Stelling on 13/08/2015.
//  https://github.com/rjstelling/ibdesignable
//

#import "UITableViewController+IBDesignable.h"
#import <objc/runtime.h>

@implementation UITableViewController (IBDesignable)

- (void)setRefreshController:(BOOL)yesNo
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    BOOL currentHasRefreshController = self.hasRefreshController;
    BOOL newHasRefreshController = yesNo;
    
    if(currentHasRefreshController == newHasRefreshController)
        return; //Do nothing if the valu has not changed
    
    if(newHasRefreshController) //If we are trying to add a controler to a TVC without a RC
    {
        objc_setAssociatedObject(self, @selector(hasRefreshController), @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
            self.refreshControl = refreshControl;
            
        });
    }
    else //Try to remove RC from TVC with RC
    {
        objc_setAssociatedObject(self, @selector(hasRefreshController), @NO, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.refreshControl = nil;
            
        });
    }
}

- (BOOL)hasRefreshController
{
    NSNumber *numValue = objc_getAssociatedObject(self, @selector(hasRefreshController));
    
    return [numValue boolValue];
}

@end
