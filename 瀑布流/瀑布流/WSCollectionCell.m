//
//  WSCollectionCell.m
//  瀑布流
//
//  Created by iMac on 16/12/26.
//  Copyright © 2016年 zws. All rights reserved.
//

#import "WSCollectionCell.h"
#import "UIImageView+WebCache.h"

@implementation WSCollectionCell




- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self creatSubView];
        
    }
    return self;
}

- (void)creatSubView {
    
    UIImageView *imgV = [[UIImageView alloc]init];
    imgV.tag = 10;
    [self addSubview:imgV];
    
    
    UIVisualEffectView *visulEffectView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    visulEffectView.tag = 20;
    [self addSubview:visulEffectView];
    
    UILabel *label = [[UILabel alloc]init];
    label.tag = 30;
    label.font = [UIFont systemFontOfSize:10];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [visulEffectView addSubview:label];
}


-(void)setModel:(CellModel *)model {
    _model = model;
    UIImageView *imgV = (UIImageView *)[self viewWithTag:10];
    UIVisualEffectView *visulEffectView = (UIVisualEffectView *)[self viewWithTag:20];
    UILabel *label = (UILabel *)[self viewWithTag:30];

    imgV.frame = self.bounds;
    visulEffectView.frame = CGRectMake(0, self.frame.size.height-16, self.frame.size.width, 16);
    label.frame = CGRectMake(0, 3, CGRectGetWidth(visulEffectView.frame), 10);
    
    [imgV sd_setImageWithURL:[NSURL URLWithString:_model.imgURL]];
    label.text = _model.title;
    
}

@end
