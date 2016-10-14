//
//  UnderLineButton.m
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "UnderLineButton.h"

@implementation UnderLineButton

- (instancetype)init {
    self = [super init];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGRect textRect = self.titleLabel.frame;
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(contextRef, self.titleLabel.textColor.CGColor);
    CGFloat x = textRect.origin.x;
    CGFloat y = textRect.origin.y + textRect.size.height * 1.1;
    CGContextMoveToPoint(contextRef, x, y);
    CGContextAddLineToPoint(contextRef, x + textRect.size.width, y);
    CGContextClosePath(contextRef);
    CGContextDrawPath(contextRef, kCGPathStroke);
}

@end
