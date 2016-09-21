# ImageLayout
瀑布流，网络图片瀑布流


# PhotoShoot
![image](https://github.com/Zws-China/.../blob/master/image/image/layout2.gif)
![image](https://github.com/Zws-China/.../blob/master/image/image/layout22.jpeg)
![image](https://github.com/Zws-China/.../blob/master/image/image/layout222.jpeg)


# How To Use

```ruby

#import "WSLayout.h"

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) WSLayout *wslayout;




self.wslayout = [[WSLayout alloc] init];

self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) collectionViewLayout:self.wslayout];

[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
self.collectionView.dataSource = self;
self.collectionView.delegate = self;
self.collectionView.backgroundColor = [UIColor whiteColor];


[self.view addSubview:self.collectionView];

//返回每个cell的高   对应indexPath
[self.wslayout computeIndexCellHeightWithWidthBlock:^CGFloat(NSIndexPath *indexPath, CGFloat width) {
    
    return (CGFloat)arc4random_uniform(100);
}];


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.contentView.backgroundColor = [self randomColor];

    return cell;
}


- (UIColor *)randomColor {

    return [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0];

}



```