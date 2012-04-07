//
//  MYIrregularButton.h
//  tableviewswipedelete
//
//  Created by xie xu on 12-4-5.
//  Copyright (c) 2012年 yek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYIrregularButton : UIButton
{
    NSArray *vertexXs;   //all vertexs of polygon
    NSArray *vertexYs;


}

-(id)initWithFrame:(CGRect)frame withVertexXs:(NSArray *)Xs withVertexYs:(NSArray *)Ys;

@end
