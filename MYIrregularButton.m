//
//  MYIrregularButton.m
//  tableviewswipedelete
//
//  Created by panjun cui on 12-4-5.
//  Copyright (c) 2012年 . All rights reserved.
//

#import "MYIrregularButton.h"

int pnpoly(int nvert, float *vertx, float *verty, float testx, float testy);

int pnpoly(int nvert, float *vertx, float *verty, float testx, float testy)
{
    int i, j, c = 0;
    for (i = 0, j = nvert-1; i < nvert; j = i++) {
        if ( ((verty[i]>testy) != (verty[j]>testy)) &&
            (testx < (vertx[j]-vertx[i]) * (testy-verty[i]) / (verty[j]-verty[i]) + vertx[i]) )
            c = !c;
    }
    return c;
}

@implementation MYIrregularButton

-(id)initWithFrame:(CGRect)frame withVertexXs:(NSArray *)Xs withVertexYs:(NSArray *)Ys{

    if (self = [super initWithFrame:frame]) {
        
        vertexXs = [Xs retain];
        vertexYs = [Ys retain];
        
    }
    self.backgroundColor = [UIColor grayColor];
    return self;
    
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{

    int vertexsCount = [vertexXs count];
    if (vertexsCount) {
        
        //float vertXs[vertexsCount];  
        //float vertYs[vertexsCount];
        
        float *vertXs = malloc(sizeof(float)*vertexsCount);
        float *vertYs = malloc(sizeof(float)*vertexsCount);
        
        for (int i = 0 ; i < vertexsCount ; i ++ ) {
            vertXs[i] = [[vertexXs objectAtIndex:i] floatValue];
            vertYs[i] = [[vertexYs objectAtIndex:i] floatValue];
        }
        
        if (pnpoly(vertexsCount, vertXs, vertYs, point.x, point.y)) {
            return YES;
        }
    }
    
    return NO;

}

-(void)drawRect:(CGRect)rect{

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGPoint startPoint = CGPointMake([[vertexXs lastObject] floatValue], [[vertexYs lastObject] floatValue]);
    NSLog(@"X: %.2f, Y: %.2f", startPoint.x, startPoint.y);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    
    int vertexsCount = [vertexXs count];
    
    for (int i = 0 ; i < vertexsCount ; i++ ) {

        CGContextAddLineToPoint(context, [[vertexXs objectAtIndex:i] floatValue], [[vertexYs objectAtIndex:i] floatValue]);
    }
    CGContextClosePath(context);
    [[UIColor redColor] setFill];
    [[UIColor blackColor] setStroke];
    CGContextDrawPath(context, kCGPathFillStroke);

}

/**
 * from stackoverflow
 *
- (BOOL)shape:(NSBezierPath *)path containsPoint:(NSPoint)point
{
    NSBezierPath *currentPath = [path bezierPathByFlatteningPath];
    BOOL result;
    float aggregateX = 0; //I use these to calculate the centroid of the shape
    float aggregateY = 0;
    NSPoint firstPoint[1];
    [currentPath elementAtIndex:0 associatedPoints:firstPoint];
    float olderX = firstPoint[0].x;
    float olderY = firstPoint[0].y;
    NSPoint interPoint;
    int noOfIntersections = 0;
    
    for (int n = 0; n < [currentPath elementCount]; n++) {
        NSPoint points[1];
        [currentPath elementAtIndex:n associatedPoints:points];
        aggregateX += points[0].x;
        aggregateY += points[0].y;
    }
    
    for (int n = 0; n < [currentPath elementCount]; n++) {
        NSPoint points[1];
        
        [currentPath elementAtIndex:n associatedPoints:points];
        //line equations in Ax + By = C form
        float _A_FOO = (aggregateY/[currentPath elementCount]) - point.y;  
        float _B_FOO = point.x - (aggregateX/[currentPath elementCount]);
        float _C_FOO = (_A_FOO * point.x) + (_B_FOO * point.y);
        
        float _A_BAR = olderY - points[0].y;
        float _B_BAR = points[0].x - olderX;
        float _C_BAR = (_A_BAR * olderX) + (_B_BAR * olderY);
        
        float det = (_A_FOO * _B_BAR) - (_A_BAR * _B_FOO);
        if (det != 0) {
            //intersection points with the edges
            float xIntersectionPoint = ((_B_BAR * _C_FOO) - (_B_FOO * _C_BAR)) / det;
            float yIntersectionPoint = ((_A_FOO * _C_BAR) - (_A_BAR * _C_FOO)) / det;
            interPoint = NSMakePoint(xIntersectionPoint, yIntersectionPoint);
            if (olderX <= points[0].x) {
                //doesn't matter in which direction the ray goes, so I send it right-ward.
                if ((interPoint.x >= olderX && interPoint.x <= points[0].x) && (interPoint.x > point.x)) {  
                    noOfIntersections++;
                }
            } else {
                if ((interPoint.x >= points[0].x && interPoint.x <= olderX) && (interPoint.x > point.x)) {
                    noOfIntersections++;
                } 
            }
        }
        olderX = points[0].x;
        olderY = points[0].y;
    }
    if (noOfIntersections % 2 == 0) {
        result = FALSE;
    } else {
        result = TRUE;
    }
    return result;
}
*/
@end
