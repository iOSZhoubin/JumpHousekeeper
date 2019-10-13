//
//  RefreshHelper.m
//  Jump
//
//  Created by jumpapp1 on 2018/12/14.
//  Copyright © 2018年 zhoubin. All rights reserved.
//

#import "RefreshHelper.h"

@implementation RefreshHelper

+(void)refreshHelperWithScrollView:(UIScrollView *)scrollView target:(id)target loadNewData:(SEL)loadNewData loadMoreData:(SEL)loadMoreData isBeginRefresh:(BOOL)beginRefreshing{
    
    if (loadNewData) {
        
        MJRefreshNormalHeader *mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:loadNewData];
        mj_header.automaticallyChangeAlpha = YES;
        
        if (beginRefreshing) {
            
            [mj_header beginRefreshing];
        }
        
        scrollView.mj_header = mj_header;
    }
    if (loadMoreData) {
        
        MJRefreshBackNormalFooter *mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:loadMoreData ];
        mj_footer.automaticallyChangeAlpha = YES;
        scrollView.mj_footer = mj_footer;
    }
    
    
}

@end
