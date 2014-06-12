//
//  DataBaseHelper.m
//  cao
//
//  Created by  黄超  on 12-10-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DataBaseHelper.h"
#import "FMDatabase.h"
@implementation DataBaseHelper


-(NSString *) GetPath:(NSString *)n
{
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDirectory, YES);
    NSString *documentDirectory = [path objectAtIndex:0];
    n  =[n  stringByAppendingString:@".db"];
    NSString *DBPath = [documentDirectory stringByAppendingPathComponent:n];
           
    return DBPath;
}


-(void) TransactDataBase :(NSString  *)baseName WithSqls:(NSMutableArray *)array;
{
    FMDatabase* db = [FMDatabase databaseWithPath:[self GetPath:baseName]];
    if ([db open]) {
        [db setShouldCacheStatements:YES];
        for (NSString *sql in array) {
            [db executeUpdate:sql];
        }
    }else {
        NSLog(@"Failed to open db!");
    }
    [db close];
}

-(NSMutableArray * ) SelectInDataBase :(NSString  *)baseName WithSql:(NSString  *)sql
{
    FMDatabase* db = [FMDatabase databaseWithPath:[self GetPath :baseName]];
    
    if ([db open]) {
        
        [db setShouldCacheStatements:YES];
        FMResultSet *rs=[db executeQuery:sql];
        
        
        NSMutableArray *array=[[[NSMutableArray alloc] initWithCapacity:0] autorelease];
        while ([rs next]){
            //NSString  *value=@"";
            NSMutableDictionary  *dic=[[NSMutableDictionary alloc] initWithCapacity:0];
            for (int i=0; i<rs.columnCount; i++) {
                NSString *columnValue=[rs stringForColumnIndex:i];
                NSString  *colunsName=[rs  columnNameForIndex:i];
                [dic  setObject:columnValue forKey:colunsName];
                
            }
            [array  addObject:dic];
            [dic release];
        }
        
        [rs close];
        [db close];
        return  array;

    }else {
        return nil;
    }
        
}
//                if (i==rs.columnCount-1) {
//                    
//                    NSString *columnValue=[rs stringForColumnIndex:i];
//                    value=[value stringByAppendingString:columnValue];
//                    
//                }else {
//                    NSString *columnValue=[rs stringForColumnIndex:i];
//                    value=[value stringByAppendingString:columnValue];
//                    value=[value stringByAppendingString:@"#"];
//                    
//                }

@end
