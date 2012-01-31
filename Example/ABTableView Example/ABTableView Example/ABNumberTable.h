//
//  ABNumberTable.h
//  Easy Spend Log
//
//  Created by Aaron Bratcher on 05/21/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABNumberTable : NSObject {
	NSMutableArray *columnAmounts;
	
	NSInteger rows;
}



- (void) setAmount: (NSNumber*) amount atColumn: (NSInteger) column row: (NSInteger) row;

- (NSNumber *) getAmountAtColumn: (NSInteger) column row: (NSInteger) row;

- (NSInteger) columns;
- (NSInteger) rows;

@end
