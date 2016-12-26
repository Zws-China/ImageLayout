# ImageLayout
瀑布流，网络图片瀑布流


[GitHub: https://github.com/Zws-China/ImageLayout](https://github.com/Zws-China/ImageLayout)  


# PhotoShoot
![image]()
![image](https://github.com/Zws-China/.../blob/master/image/image/layout2.gif)
![image](https://github.com/Zws-China/.../blob/master/image/image/layout22.jpeg)
![image](https://github.com/Zws-China/.../blob/master/image/image/layout222.jpeg)


# How To Use

```ruby

#import "WSLayout.h"

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) WSLayout *wslayout;


self.wslayout = [[WSLayout alloc] init];
self.wslayout.lineNumber = 2; //列数
self.wslayout.rowSpacing = 5; //行间距
self.wslayout.lineSpacing = 5; //列间距
self.wslayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5); //内边距


// 透明时用这个属性(保证collectionView 不会被遮挡, 也不会向下移)
//self.edgesForExtendedLayout = UIRectEdgeNone;
// 不透明时用这个属性
//self.extendedLayoutIncludesOpaqueBars = YES;
self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) collectionViewLayout:self.wslayout];

[self.collectionView registerClass:[WSCollectionCell class] forCellWithReuseIdentifier:@"collectionCell"];
self.collectionView.dataSource = self;
self.collectionView.delegate = self;
self.collectionView.backgroundColor = [UIColor lightGrayColor];
[self.view addSubview:self.collectionView];


//返回每个cell的高   对应indexPath
[self.wslayout computeIndexCellHeightWithWidthBlock:^CGFloat(NSIndexPath *indexPath, CGFloat width) {

    CellModel *model = modelArray[indexPath.row];
    CGFloat oldWidth = model.imgWidth;
    CGFloat oldHeight = model.imgHeight;

    CGFloat newWidth = width;
    CGFloat newHeigth = oldHeight*newWidth / oldWidth;
    return newHeigth;
}];


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return modelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    WSCollectionCell *cell = (WSCollectionCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];

    cell.model = modelArray[indexPath.row];

    return cell;
}




```