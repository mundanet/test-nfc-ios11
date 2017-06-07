//
//  AppDelegate.h
//  testNFC
//
//  Created by Matjaž Munda on 07/06/2017.
//  Copyright © 2017 Matjaž Munda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

