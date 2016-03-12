//
//  AppDelegate.h
//  DGTools
//
//  Created by Gavin on 16/3/11.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "MainTabBarController.h"

@interface AppDelegate : UIResponder
<
UIApplicationDelegate,
UITabBarControllerDelegate
>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) MainTabBarController *mainTabBarController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

