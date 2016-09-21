//
//  ViewController.m
//  瀑布流
//
//  Created by iMac on 16/9/20.
//  Copyright © 2016年 zws. All rights reserved.
//

#import "ViewController.h"
#import "WSLayout.h"

#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) WSLayout *wslayout;

@end

@implementation ViewController {
    NSMutableArray *array;
    NSMutableArray *ImgURLArray;
    NSMutableArray *ImgWidthArray;
    NSMutableArray *ImgHeightArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"瀑布流";
    self.view.backgroundColor = [UIColor whiteColor];
    //http://image.baidu.com/channel/listjson?pn=0&rn=30&tag1=美女&tag2=全部&ie=utf8
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [@"http://image.baidu.com/channel/listjson?pn=0&rn=50&tag1=美女&tag2=全部&ie=utf8" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        array = responseObject[@"data"];
        
        ImgURLArray = [NSMutableArray array];
        ImgWidthArray = [NSMutableArray array];
        ImgHeightArray = [NSMutableArray array];
        for (NSInteger i = 0; i < array.count-1; i++) {
            NSDictionary *dic = array[i];
            NSString *url = dic[@"image_url"];
            NSString *width = dic[@"image_width"];
            NSString *height = dic[@"image_height"];
            NSLog(@"----%@",url);
            [ImgURLArray addObject:url];//装图片地址
            [ImgWidthArray addObject:width];//装图片的宽
            [ImgHeightArray addObject:height];//装图片的高
        }
     
        [self _creatSubView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
  
    }];

    
 

    
}

- (void)_creatSubView {
    
    self.wslayout = [[WSLayout alloc] init];
    
    // 透明时用这个属性(保证collectionView 不会被遮挡, 也不会向下移)
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    // 不透明时用这个属性
    //self.extendedLayoutIncludesOpaqueBars = YES;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) collectionViewLayout:self.wslayout];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    

    [self.view addSubview:self.collectionView];
    
    //返回每个cell的高   对应indexPath
    [self.wslayout computeIndexCellHeightWithWidthBlock:^CGFloat(NSIndexPath *indexPath, CGFloat width) {
        
        CGFloat OW = [ImgWidthArray[indexPath.row] floatValue];
        CGFloat OH = [ImgHeightArray[indexPath.row] floatValue];
        CGFloat NW = self.view.frame.size.width/2-15;
        
        CGFloat NH = OH*NW / OW;
        
        return NH;
    }];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return array.count-1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    
    NSString *imgURL = [array objectAtIndex:indexPath.row][@"image_url"];

    
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:cell.contentView.bounds];
    [imgV sd_setImageWithURL:[NSURL URLWithString:imgURL]];
    
    cell.backgroundView = imgV;
    
    
    return cell;
}




@end
