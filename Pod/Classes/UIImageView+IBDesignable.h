//
//  UIImageView+IBDesignable.h
//  IBDesignable
//
//  Created by Richard Stelling on 08/01/2015.
//  https://github.com/rjstelling/ibdesignable
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface UIImageView (IBDesignable)

/**
 *  @author Richard Stelling (mailto:richard@empiricalmagic.com)
 *
 *  Sets the corner radius of a UIImageView
 */
@property (nonatomic) IBInspectable CGFloat cornerRadius;

/**
 *  @author Richard Stelling (mailto:richard@empiricalmagic.com)
 *
 *  Sets the mask of the image to an iOS 7/8 super-elipse aka squircle.
 */
@property (nonatomic, getter=isSquircle) IBInspectable BOOL squircle;
@property (nonatomic, getter=hasSquircleShadow) IBInspectable BOOL squircleShadow;

/**
 *  @author Richard Stelling (mailto:richard@empiricalmagic.com)
 *
 *  Sets the UIImageView to a circle. This call is ignored if the view is not a square.
 */
@property (nonatomic, getter=isCircle) IBInspectable BOOL circle;

@end
