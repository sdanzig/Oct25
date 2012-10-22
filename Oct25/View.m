//
//  View.m
//  Oct25
//
//  Created by Scott Danzig on 10/20/12.
//  Copyright (c) 2012 Scott Danzig. All rights reserved.
//

#import "View.h"
#import "DataAccessObject.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation View

- (id)initWithFrame:(CGRect)frame andDao:(DataAccessObject *)d
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        fontSize = 10.0;
        marginSize = 5.0;
        titleSize = 40.0;
        titleFontSize = 32.0;
        self.backgroundColor = UIColorFromRGB(0xD8C7A9);
        dao = d;
    }
    return self;
}


- (void) drawRect: (CGRect) rect
{
    NSMutableArray *shots = dao.shots;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, titleSize)];
    titleLabel.font = [UIFont systemFontOfSize:titleFontSize];
    NSString *titleFormat = NSLocalizedString(@"Title", @"%d Shots Listed");
    titleLabel.text = [NSString stringWithFormat: titleFormat, [shots count]];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.backgroundColor = [[UIColor alloc] initWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];

    int i;
    
    for(i=0; i<[shots count]; i++) {
        CGFloat spacePerLine = (self.frame.size.height - titleSize - (marginSize * 2.0)) / 10.0;
        CGFloat screenWidth = self.frame.size.width - (marginSize * 2.0);
        UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginSize, titleSize + marginSize + i * spacePerLine, screenWidth - marginSize, spacePerLine)];
        tempLabel.font = [UIFont systemFontOfSize:fontSize];
        tempLabel.numberOfLines = 0;
        //[tempLabel setLineBreakMode:NSLineBreakByWordWrapping];
        tempLabel.text = [shots objectAtIndex:i];
        tempLabel.textColor = [UIColor blackColor];
        tempLabel.backgroundColor = [[UIColor alloc] initWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
        [self addSubview:tempLabel];
    }
}

@end
