//
//  YXWaterFlowLayout.m
//  huocheng
//
//  Created by ios on 2018/8/30.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "YXWaterFlowLayout.h"
#import "UIView+Extension.h"

@interface YXWaterFlowLayout ()
/** 字典:用来存放每一列最大的Y值(每一列的高度) */
@property (nonatomic, strong) NSMutableDictionary *maxYDict;
/** 数组:用来存放所有的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;

@end

@implementation YXWaterFlowLayout
#pragma mark - 懒加载
- (NSMutableDictionary *)maxYDict
{
    if (!_maxYDict) {
        self.maxYDict = [[NSMutableDictionary alloc] init];
    }
    return _maxYDict;
}

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        self.attrsArray = [[NSMutableArray alloc] init];
    }
    return _attrsArray;
}

#pragma mark - 初始化间距
- (instancetype)init
{
    if(self = [super init])
    {
        self.colsCount = 2;
        self.sectionInset = UIEdgeInsetsMake(1175 + 40 + 15, 10, 10, 10);//1175 + 40 + 15
        self.marginX = 10;
        self.marginY = 10;
    }
    return self;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

#pragma mark - 对collectionview进行布局
/** 每次布局前的准备 */
- (void)prepareLayout{
    [super prepareLayout];
    // 清空最大的Y值
    for(int i=0;i<self.colsCount;++i)
    {
        NSString *column = [NSString stringWithFormat:@"%d", i];
        self.maxYDict[column] = @(self.sectionInset.top);
    }
    // 计算所有cell的属性
    [self.attrsArray removeAllObjects]; // 清空所有属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for(int i=0;i<count;i++)
    {
        UICollectionViewLayoutAttributes *att = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrsArray addObject:att];
    }
}

/** 返回滚动的尺寸 */
- (CGSize)collectionViewContentSize
{
    // 假设第0列y值最小
    __block NSString *maxColunmn = @"0";
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if([maxY floatValue] > [self.maxYDict[maxColunmn] floatValue])
            maxColunmn = column;
    }];
    return CGSizeMake(0, [self.maxYDict[maxColunmn] floatValue] + self.sectionInset.bottom);
}
/** 布局cell的属性 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 找出最短的那一列
    __block NSString *minColumn = @"0";
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if([maxY floatValue] < [self.maxYDict[minColumn] floatValue])
            minColumn = column;
    }];
    
    // 计算尺寸
    CGFloat cellW = (self.collectionView.width - self.sectionInset.left - self.sectionInset.right - (self.colsCount - 1)*self.marginX)/self.colsCount;
    CGFloat cellH = [self.delegate waterFlowLayout:self heightForWidth:cellW AtIndexPath:indexPath];
    
    // 计算位置
    CGFloat cellX = self.sectionInset.left + [minColumn intValue] * (self.marginX + cellW);
    CGFloat cellY = [self.maxYDict[minColumn] floatValue] + self.marginY;
    
    // 及时更新这一列最大的y值
    self.maxYDict[minColumn] = @(cellY + cellH);
    
    NSLog(@"rect:%@-%lf-%lf-%lf-%lf",minColumn,cellX,cellY,cellW,cellH);
    
    // 获得布局属性
    UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    att.frame = CGRectMake(cellX, cellY, cellW, cellH);
    return att;
}
/** 返回rect范围内的所有属性 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 添加瀑布流头部按钮
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
    
    [self.attrsArray addObject:attributes];
    
    return self.attrsArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    
    att.size = CGSizeMake(320, 35);
    if(elementKind == UICollectionElementKindSectionHeader)
    {
        if(self.collectionView.contentOffset.y >= 1129)
        {
            att.center = CGPointMake(self.collectionView.width*0.5, 80 + self.collectionView.contentOffset.y);
            att.zIndex = 1;
        }else{
            
            att.center = CGPointMake(self.collectionView.width*0.5, 1175 + 35);
        }
    }
    return att;
}

@end



















