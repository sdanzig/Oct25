//
//  Oct25AppDelegate.h
//  Oct25
//
//  Created by Scott Danzig on 10/20/12.
//  Copyright (c) 2012 Scott Danzig. All rights reserved.
//

#import <UIKit/UIKit.h>
@class View;

@interface Oct25AppDelegate : UIResponder <UIApplicationDelegate> {
    View *view;
    UIWindow *_window;
}

@property (strong, nonatomic) UIWindow *window;

@end
