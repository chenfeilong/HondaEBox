//
//  DataBaseHelper.h
//  cao
//
//  Created by  黄超  on 12-10-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBaseHelper : NSObject
//@property (nonatomic ,retain) NSString  *databaseName;

-(NSString *) GetPath :(NSString  *)n;

-(void) TransactDataBase :(NSString  *)baseName WithSqls:(NSMutableArray *)array;
-(NSMutableArray * ) SelectInDataBase :(NSString  *)baseName WithSql:(NSString  *)sql;
@end
