//
//  AppDelegate.h
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/18.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property(nonatomic,assign)BOOL allowRotation;//是否允许转向


- (void)saveContext;

@property (nonatomic,assign)NSInteger allowRotate;

@end

