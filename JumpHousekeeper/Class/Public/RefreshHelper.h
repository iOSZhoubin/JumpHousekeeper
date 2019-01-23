//
//  RefreshHelper.h
//  Jump
//
//  Created by jumpapp1 on 2018/12/14.
//  Copyright © 2018年 zhoubin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RefreshHelper : NSObject

/**
 *  刷新方法
 *
 *  @param scrollView   需要刷新的页面
 *  @param target       控制器
 *  @param loadNewData  下拉
 *  @param loadMoreData 上拉
 */
+(void)refreshHelperWithScrollView:(UIScrollView *)scrollView target:(id)target loadNewData:(SEL)loadNewData loadMoreData:(SEL)loadMoreData isBeginRefresh:(BOOL )beginRefreshing;


@end
