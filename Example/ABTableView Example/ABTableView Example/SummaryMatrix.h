//
//  SummaryMatrix.h
//  Easy Spend Log
//
//  Created by Aaron Bratcher on 05/20/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABNumberTable.h"

@interface SummaryMatrix : NSObject {
	NSMutableArray *categories;
	NSMutableArray *monthNames;
	NSMutableArray *months;
	
	ABNumberTable *amounts;
	ABNumberTable *percents;
}

@property (nonatomic, retain) NSMutableArray *categories;
@property (nonatomic, retain) NSMutableArray *monthNames;
@property (nonatomic, retain) NSMutableArray *months;
@property (nonatomic, retain) ABNumberTable *amounts;
@property (nonatomic, retain) ABNumberTable *percents;


@end
