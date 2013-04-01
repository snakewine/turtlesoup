//
//  GraphView.m
//  graphCaluator
//
//  Created by Damir Okic on 31/03/2013.
//  Copyright (c) 2013 OkicDowejko. All rights reserved.
//

#import "GraphView.h"
#define kGraphHeight 703
#define kDefaultGraphWidth 750
#define kOffsetX -9
#define kStepX 40
#define kGraphBottom 704
#define kGraphTop 0
#define kStepY 20
#define kOffsetY 11

@implementation GraphView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
   
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 0.2);
    CGContextSetStrokeColorWithColor(context, [[UIColor lightGrayColor] CGColor]);
    
    // number of lines
    int numberOfLines = (kDefaultGraphWidth - kOffsetX) / kStepX;
    // Here the lines go
    for (int i = 0; i < numberOfLines; i++)
    {
        CGContextMoveToPoint(context, kOffsetX + i * kStepX, kGraphTop);
        CGContextAddLineToPoint(context, kOffsetX + i * kStepX, kGraphBottom);
    }
    
    int howManyHorizontal = (kGraphBottom - kGraphTop - kOffsetY) / kStepY;
    for (int i = 0; i <= howManyHorizontal; i++)
    {
        CGContextMoveToPoint(context, kOffsetX, kGraphBottom - kOffsetY - i * kStepY);
        CGContextAddLineToPoint(context, kDefaultGraphWidth, kGraphBottom - kOffsetY - i * kStepY);
    }
    
    //new code for sine function
    /*
     
     int x;
     for(int y=rect.origin.y; y < rect.size.height; y++)
     {
     x = ((rect.size.width/4) * sin(((y*4) % 360) * M_PI/180)) + rect.size.width/2;
     
     if(y == 0)
     {
     CGContextMoveToPoint(context, x, y);
     }
     else
     {
     CGContextAddLineToPoint(context, x, y);
     }
     }
     
     */
    
    //end  new code for sine function
    
  /* for (int i=12; i<=20*35; i+=20) {
       CGContextSetLineWidth(context, 2);
       CGContextSetStrokeColorWithColor(context, [[UIColor blueColor] CGColor]);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, 341.5, i);
        CGContextAddLineToPoint(context, 361.5, i);
        CGContextStrokePath(context);
        
    }*/
    CGContextStrokePath(context);
    
    [self drawSineFunction:4];
    [self drawAxes];
    [self drawGrid];
    [self drawNumbers];
    
}


-(void) drawAxes {
    
    //main axes
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(ctx, 2);
    CGContextSetStrokeColorWithColor(ctx, [[UIColor blueColor] CGColor]);
    
    CGContextMoveToPoint(ctx, 352, 0);
    CGContextAddLineToPoint(ctx, 352, 710);
    
    CGContextMoveToPoint(ctx, 0, 352);
    CGContextAddLineToPoint(ctx, 710, 352);
    
     CGContextMoveToPoint(ctx, 12, 341.5);
    CGContextAddLineToPoint(ctx, 12, 361.5);
    
    CGContextStrokePath(ctx);
    
    
    
}



- (void) drawSineFunction: (float)mynum{

            CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(ctx, 2);
    CGContextSetStrokeColorWithColor(ctx, [[UIColor redColor] CGColor]);
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    float x=200;
    float yc=-100;
    float w=0;
    float h=self.bounds.size.height;
    
    while (w<=self.bounds.size.width) {
        CGPathMoveToPoint(path, nil, w,h/2);
        CGPathAddQuadCurveToPoint(path, nil, w+x/4, -yc,w+ x/2, h/2);
        CGPathMoveToPoint(path, nil, w+x/2,h/2);
        CGPathAddQuadCurveToPoint(path, nil, w+3*x/4, h+yc, w+x, h/2);
        CGContextAddPath(ctx, path);
        CGContextDrawPath(ctx, kCGPathStroke);
        w+=x;
    }


}


-(void) drawGrid{
CGContextRef context = UIGraphicsGetCurrentContext();
    
    //axes scale
    
    for (int i=12; i<=20*35; i+=20) {
        CGContextSetLineWidth(context, 2);
        CGContextSetStrokeColorWithColor(context, [[UIColor blueColor] CGColor]);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, 341.5, i);
        CGContextAddLineToPoint(context, 361.5, i);
        CGContextMoveToPoint(context, i, 341.5);
        CGContextAddLineToPoint(context, i, 361.5);
        CGContextStrokePath(context);
        
    }

}


-(void) drawNumbers{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context, CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0));
    CGContextSelectFont(context, "Helvetica", 13, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetFillColorWithColor(context, [[UIColor greenColor] CGColor]);
   for (int i = 1; i < 9; i++)
    {
        NSString *theText = [NSString stringWithFormat:@"%d", i];
        CGContextShowTextAtPoint(context, 348 + i * 40, kGraphBottom -327, [theText cStringUsingEncoding:NSUTF8StringEncoding], [theText length]);
    }
    
    for (int i = -8; i < 0; i++)
    {
        NSString *theText = [NSString stringWithFormat:@"%d", i];
        CGContextShowTextAtPoint(context, 345 + i * 40, kGraphBottom -327, [theText cStringUsingEncoding:NSUTF8StringEncoding], [theText length]);
    }
    
    for (int i = 8,  j=1; i > 0; i--,j++)
    {
        NSString *theText = [NSString stringWithFormat:@"%d", j];
        CGContextShowTextAtPoint(context, 370 , (kGraphBottom -706)+ i * 40, [theText cStringUsingEncoding:NSUTF8StringEncoding], [theText length]);
    }
    
    for (int i = 8,  j=-8; i > 0; i--,j+=1)
    {
        NSString *theText = [NSString stringWithFormat:@"%d", j];
        CGContextShowTextAtPoint(context, 370 , (kGraphBottom -346)+ i * 40, [theText cStringUsingEncoding:NSUTF8StringEncoding], [theText length]);
    }


}

/*
 
 // [self drawFunction:sin from:-2 to: 2 * M_PI];
 
 
 - (void)drawFunction:(double (*)(double))fn from:(double)x1 to:(double)x2
 {
 CGContextRef ctx = UIGraphicsGetCurrentContext();
 
 CGContextSetLineWidth(ctx, 2);
 CGContextSetStrokeColorWithColor(ctx, [[UIColor redColor] CGColor]);
 
 const double dx = 0.2; // precision
 double scale_x = self.bounds.size.width;
 double off_x = scale_x / 1000;
 double scale_y = self.bounds.size.height;
 double off_y = scale_y / 1000;
 
 CGContextMoveToPoint(ctx, x1 * scale_x + off_x, fn(x1) * scale_y - off_y);
 
 for (double x = x1 + dx; x <= x2; x += dx) {
 double y = fn(x);
 CGContextAddLineToPoint(ctx, x * scale_x + off_x, y * scale_y - off_y);
 }
 
 CGContextStrokePath(ctx);
 
 }
 */


@end
