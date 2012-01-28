//
//  ABTableView.h
//  Easy Spend Log
//
//  Created by Aaron Bratcher on 05/14/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ABTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@class ABTableView;

@protocol ABTableViewDelegate <NSObject>
-(UITableViewCell *)tableView:(ABTableView *)tableView dataCellAtTableColumn: (NSInteger) column row: (NSInteger) row;
-(UITableViewCell *)tableView:(ABTableView *)tableView headerCellAtTableColumn: (NSInteger) column;


- (NSInteger) numberOfRowsInTableView:(ABTableView *)tableView;
- (NSInteger) numberOfColumnsInTableView:(ABTableView *)tableView;
- (CGFloat) heightOfHeaderRowInTableView:(ABTableView *)tableView;
- (CGFloat) tableView:(ABTableView *)tableView heightOfRow: (NSInteger) row;
- (CGFloat) tableView:(ABTableView *)tableView widthOfColumn: (NSInteger)column;

@optional
- (void) tableView:(ABTableView *)tableView didSelectTableColumn: (NSInteger) column;
- (void) tableView:(ABTableView *)tableView didSelectCellAtTableColumn: (NSInteger) column row: (NSInteger) row;

@end


@interface ABTableView : UIScrollView<ABTableViewCellDelegate> {
	NSMutableArray				*visibleColumnHeaders;
	NSMutableArray				*visibleDataCells;

	NSMutableDictionary			*enqueuedCells;
	
	NSMutableArray 				*columnsToShow;
	NSMutableArray				*rowsToShow;
	id<ABTableViewDelegate>		delegate;
	
	NSInteger					maxEnqueued;
	BOOL						freezeHeaders;
	BOOL						freezeLeftColumn;
}

@property (assign) BOOL freezeHeaders;
@property (assign) BOOL freezeLeftColumn;

- (id)init;
- (id)initWithFrame:(CGRect)frame;
- (id)initWithCoder:(NSCoder *)decoder;

- (void) reset;

- (ABTableViewCell *)getColumnHeader: (NSInteger) column;
- (ABTableViewCell *)getDataCellAtColumn: (NSInteger) column row: (NSInteger) row;
- (void) enqueueReusableCell: (ABTableViewCell *) cell;
- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;
- (void) layoutSubviews;
- (void) setDelegate:(id<ABTableViewDelegate>)new_delegate;
- (void) deselectColumn:(NSInteger) column animated: (BOOL) animated;
- (void) deselectCellAtColumn: (NSInteger) column row: (NSInteger) row animated: (BOOL) animated;
@end
