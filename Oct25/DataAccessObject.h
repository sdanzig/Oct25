//
//  DataAccessObject.h
//  Oct25
//
//  Created by Scott Danzig on 10/21/12.
//  Copyright (c) 2012 Scott Danzig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "/opt/local/include/sqlite3.h"

@interface DataAccessObject : NSObject {
    @private
    sqlite3 *database;
}

@property (nonatomic) NSMutableArray *shots;

- (void) readShotsFromDb;

@end
