//
//  View.h
//  Oct25
//
//  Created by Scott Danzig on 10/20/12.
//  Copyright (c) 2012 Scott Danzig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccessObject.h"

@interface View : UIView {
    @private
    CGFloat fontSize;
    CGFloat marginSize;
    CGFloat titleSize;
    CGFloat titleFontSize;
    DataAccessObject *dao;
}

- (id)initWithFrame:(CGRect)frame andDao:(DataAccessObject *)dao;

@end
