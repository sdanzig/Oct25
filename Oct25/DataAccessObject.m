//
//  DataAccessObject.m
//  Oct25
//
//  Created by Scott Danzig on 10/21/12.
//  Copyright (c) 2012 Scott Danzig. All rights reserved.
//

#import "DataAccessObject.h"

@implementation DataAccessObject

- (id) init
{
    _shots = [[NSMutableArray alloc] init];
    // Custom initialization
    NSString *fileName =
    [NSHomeDirectory() stringByAppendingPathComponent: @"database.db"];
    
    if (sqlite3_open([fileName UTF8String], &database) != SQLITE_OK) {
        NSLog(@"sqlite3_open: %s", sqlite3_errmsg(database));
        return nil;
    }
    
    char *error;
    if (sqlite3_exec(database, "drop table if exists shots;", NULL, NULL, &error) != SQLITE_OK) {
        NSLog(@"sqlite3_exec: %s", error);
        sqlite3_free(error);
        return nil;
    }
    
    const char *const create =
    "PRAGMA foreign_keys=OFF;\n"
    "BEGIN TRANSACTION;\n"
    "CREATE TABLE shots (id INTEGER PRIMARY KEY, description TEXT NOT NULL);\n"
    "COMMIT;";
    
    if (sqlite3_exec(database, create, NULL, NULL, &error) != SQLITE_OK) {
        NSLog(@"sqlite3_exec: %s", error);
        sqlite3_free(error);
        return nil;
    }
    
    typedef struct {
        int shotnum;
        char *description;
    } shot_t;
    
    static const shot_t a[] = {
        {1,"Elizabeth's reflection in the mirror. Shadow engulfs her face"},
        {2,"A hand pulls a curtain"},
        {3,"Facing Earl from behind the candles, showing him light them"},
        {4,"Hand waving and candles light up"},
        {5,"Earl sits next to Harold, with Mr. Stone sitting in the shadows"},
        {6,"Elizabeth approaches"},
        {7,"Mr. Stone starts the ceremony and injects Harold. Elizabeth tells Earl to get his sister"},
        {8,"Mr. Stone starts the ceremony"},
        {9,"Harold talks about chairs"},
        {10,"Earl reassures Harold"}
    };
    static const size_t n = sizeof a / sizeof a[0];
    
    for (size_t i = 0; i < n; ++i) {
        char *const insert = sqlite3_mprintf(
                                             "insert into shots (description) values ('%q');",
                                             a[i].description );
        
        if (insert == NULL) {
            NSLog(@"sqlite3_mprintf failed.");
            return nil;
        }
        
        if (sqlite3_exec(database, insert, NULL, NULL, &error) != SQLITE_OK) {
            NSLog(@"%s", error);
            sqlite3_free(error);
            return nil;
        }
        
        sqlite3_free(insert);
    }
    return self;
}

static int foundRecord(void *p, int argc, char **argv, char **colName) {
    NSString *text = @"";
    NSMutableArray *shot_list = (__bridge NSMutableArray *)p;
    
	//Append each field of the record to the UITextView's text.
	for (int i = 0; i < argc; ++i) {
		//%s for pointer to char
		text = [text stringByAppendingFormat: @"%s ", argv[i]];
	}
    [shot_list addObject:text];
	return SQLITE_OK;
}

- (void) readShotsFromDb
{
	char *error;
	if (sqlite3_exec(database, "select * from shots;", foundRecord, (__bridge void *)_shots, &error)
		!= SQLITE_OK) {
		NSLog(@"%s", error);
		sqlite3_free(error);
	}
}

@end
