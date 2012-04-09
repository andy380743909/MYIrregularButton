//
//  MYIrregularButton.h
//  tableviewswipedelete
//
//  Created by panjun cui on 12-4-5.
//  Copyright (c) 2012年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYIrregularButton : UIButton
{
    NSArray *vertexXs;   //all vertexs of polygon
    NSArray *vertexYs;
    
    float *cArrayXs;    // convert nsarray to c array
    float *cArrayYs;
    
}

-(id)initWithFrame:(CGRect)frame withVertexXs:(NSArray *)Xs withVertexYs:(NSArray *)Ys;

// later, we will use a c float array to hold the vertex
-(id)initWithFrame:(CGRect)frame withCArrayVertexXs:(float *)Xs withCArrayVertexYs:(float *)Ys;

@end
