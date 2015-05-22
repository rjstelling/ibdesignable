//
//  UIImageView+IBDesignable.m
//  IBDesignable
//
//  Created by Richard Stelling on 08/01/2015.
//  https://github.com/rjstelling/ibdesignable
//

#import "UIImageView+IBDesignable.h"
#import <objc/runtime.h>

#pragma mark - Private

@interface UIImageView (IBDesignable_Private)

- (UIBezierPath *)squirclePathForRect:(CGRect)rectangle __attribute__((pure));

@end

@implementation UIImageView (IBDesignable_Private)

#pragma mark - Squircle

- (UIBezierPath *)squirclePathForRect:(CGRect)rectangle
{
    //Rectangle from Fours Bezier Curves
    UIBezierPath *bezierCurvePath = [UIBezierPath bezierPath];
    bezierCurvePath.flatness = 0.20;
    
    //set coner points
    CGPoint topLPoint = CGPointMake(CGRectGetMinX(rectangle), CGRectGetMinY(rectangle));
    CGPoint topRPoint = CGPointMake(CGRectGetMaxX(rectangle), CGRectGetMinY(rectangle));
    CGPoint botLPoint = CGPointMake(CGRectGetMinX(rectangle), CGRectGetMaxY(rectangle));
    CGPoint botRPoint = CGPointMake(CGRectGetMaxX(rectangle), CGRectGetMaxY(rectangle));
    
    //set start-end points
    CGPoint midRPoint = CGPointMake(CGRectGetMaxX(rectangle), CGRectGetMidY(rectangle));
    CGPoint botMPoint = CGPointMake(CGRectGetMidX(rectangle), CGRectGetMaxY(rectangle));
    CGPoint topMPoint = CGPointMake(CGRectGetMidX(rectangle), CGRectGetMinY(rectangle));
    CGPoint midLPoint = CGPointMake(CGRectGetMinX(rectangle), CGRectGetMidY(rectangle));
    
    [bezierCurvePath moveToPoint:midLPoint];
    [bezierCurvePath addCurveToPoint:topMPoint controlPoint1:topLPoint controlPoint2:topLPoint];
    [bezierCurvePath addCurveToPoint:midRPoint controlPoint1:topRPoint controlPoint2:topRPoint];
    [bezierCurvePath addCurveToPoint:botMPoint controlPoint1:botRPoint controlPoint2:botRPoint];
    [bezierCurvePath addCurveToPoint:midLPoint controlPoint1:botLPoint controlPoint2:botLPoint];
    
    return bezierCurvePath;
}

@end

#pragma mark - Public

@implementation UIImageView (IBDesignable)

- (void)setCornerRadius:(CGFloat)val
{
    objc_setAssociatedObject(self, @selector(cornerRadius), @(val), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.layer.cornerRadius = self.cornerRadius;
        self.layer.masksToBounds = YES;
    });
}

- (CGFloat)cornerRadius
{
    NSNumber *numValue = objc_getAssociatedObject(self, @selector(cornerRadius));
    
    return [numValue floatValue];
}

- (void)setSquircle:(BOOL)yesNo
{
    objc_setAssociatedObject(self, @selector(isSquircle), @(yesNo), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if(yesNo)
        {
            CGPathRef path = [self squirclePathForRect:self.bounds].CGPath;
            
            CAShapeLayer *squircleMask = [CAShapeLayer layer];
            squircleMask.path = path;
            squircleMask.fillColor = [UIColor colorWithWhite:0.0 alpha:1.0].CGColor;
            
            self.layer.mask = squircleMask;
        }
        else
        {
            self.layer.mask = nil;
        }
    });
}

- (BOOL)isSquircle
{
    NSNumber *numValue = objc_getAssociatedObject(self, @selector(isSquircle));
    
    return [numValue boolValue];
}

- (BOOL)hasSquircleShadow
{
    NSNumber *numValue = objc_getAssociatedObject(self, @selector(hasSquircleShadow));
    
    return [numValue boolValue];
}

- (void)setSquircleShadow:(BOOL)yesNo
{
    objc_setAssociatedObject(self, @selector(hasSquircleShadow), @(yesNo), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if(yesNo)
        {
            const CGFloat SHRINK = 1;
            CGRect r = self.bounds;
            r.origin.x += SHRINK;
            r.origin.y += SHRINK;
            r.size.width -= (SHRINK * 2);
            r.size.height -= (SHRINK * 2);
            
            CGPathRef path = [self squirclePathForRect:r].CGPath;
            
            CAShapeLayer *squircleShadowLayer = [CAShapeLayer layer];
            squircleShadowLayer.path = path;
            squircleShadowLayer.shadowPath = path;
            squircleShadowLayer.shadowOffset = CGSizeMake(1, 1);
            squircleShadowLayer.shadowRadius = 2.0f;
            squircleShadowLayer.shadowOpacity = 0.50f;
            
            squircleShadowLayer.frame = self.layer.frame;
            [self.layer.superlayer insertSublayer:squircleShadowLayer below:self.layer];
            
        }
        else
        {
            //self.layer.shadowOpacity = 0.0f;
            //self.layer.shadowPath = nil;
        }
    });
}

- (void)setCircle:(BOOL)circle
{
    if(circle)
    {
        NSAssert(CGRectGetHeight(self.frame) == CGRectGetWidth(self.frame), @"UIImage view is not a square, use -setCornerRadius: instead.");
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self setCornerRadius:CGRectGetHeight(self.frame)/2.0f];
            
        });
    }
}

- (BOOL)isCircle
{
    return [self cornerRadius] == (CGRectGetHeight(self.frame)/2.0f);
}

#pragma mark - Interface Builder

//#if TARGET_INTERFACE_BUILDER

- (void)prepareForInterfaceBuilder
{
    [self drawRect:self.bounds];
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    
    [[UIColor redColor] setStroke];
    
    path.lineWidth = 4;
    
    [path stroke];
}

//#endif //TARGET_INTERFACE_BUILDER

@end
