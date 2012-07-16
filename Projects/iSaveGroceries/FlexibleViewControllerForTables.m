//
//  FlexibleTableViewController.m
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 2/8/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "FlexibleViewControllerForTables.h"
#import "FlexibleTableViewCell.h"
#import "FlexibleCellDescription.h"
#import "FlexibleGradientBackgroundTable.h"
#import "FlexiblePullToRefreshTableViewHeader.h"

static const double FlexibleTableControllerTextAnimationDuration = 0.33;


@interface FlexibleViewControllerForTables ( Private )

- (BOOL)respondsToSelector:(SEL)selector;
- (void)setUseCustomHeaders:(BOOL)newValue;
- (void)setConstantRowHeight:(BOOL)newValue;
- (void)keyboardWillHideNotification:(NSNotification *)notification;
- (void)keyboardWillShowNotification:(NSNotification *)aNotification;
- (void)deselect;
@end

@implementation FlexibleViewControllerForTables{
    
	NSMutableArray *_headerViews;
	NSMutableArray *_dataArray;
	CGFloat _textFieldAnimatedDistance;
    NSMutableDictionary *_selectedIndexes;
    UITableView *_flexibleTableView;

}

#pragma mark - synthesize
@dynamic  flexibleTableView;
@synthesize constantRowHeight = _constantRowHeight;
@synthesize useCustomHeaders = _useCustomHeaders;
@synthesize currentTextField = _currentTextField;
@synthesize allowMultipleCellSelection = _allowMultipleCellSelection;
@synthesize pullToRefreshHeaderView = _pullToRefreshHeaderView;
//
// tableView
//
// This method connects to the view property by default.
//
- (UITableView *)flexibleTableView
{
	return _flexibleTableView ;
}

//
// setTableView
//
// This method connects to the view property by default.
//
- (void)setFlexibleTableView:(UITableView *)aTableView
{
	_flexibleTableView = aTableView;
    
	[_flexibleTableView setDelegate:self];
	[_flexibleTableView setDataSource:self];
	
	if (!self.nibName && !self.view)
	{
		self.view = aTableView;
	}
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
//
// loadView
//
// Construct a UITableView as the view and connect the dataSource and delegate.
//
//- (void)loadView
//{
//	if (self.nibName && [[NSBundle mainBundle] URLForResource:self.nibName withExtension:@"nib"])
//	{
//		[super loadView];
//		return;
//	}
//	
//	GradientBackgroundTable *aTableView = [[GradientBackgroundTable alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
//	self.view = aTableView;
//	_flexibleTableView = aTableView;
//}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [_dataArray count])];
	[self removeAllSectionsWithAnimation:UITableViewRowAnimationNone];
	[_flexibleTableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationNone];

}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
	if (_currentTextField)
	{
		[self keyboardWillHideNotification:nil];
	}
}

- (void)viewDidUnload
{
    [self setFlexibleTableView:nil];
    [self setCurrentTextField:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Pull to Refresh

- (void)flexibleRefreshTableHeaderDidTriggerRefresh:(FlexiblePullToRefreshTableViewHeader *)view{
    
    [NSException raise:@"Implement in subclass" format:nil];
}

- (BOOL)flexibleRefreshTableHeaderDataSourceIsLoading:(FlexiblePullToRefreshTableViewHeader *)view{
    
    [NSException raise:@"Implement in subclass" format:nil];
    return NO;
}

- (NSDate*)flexibleRefreshTableHeaderDataSourceLastUpdated:(FlexiblePullToRefreshTableViewHeader *)view{
    
    [NSException raise:@"Implement in subclass" format:nil];
    return nil;
}

#pragma mark - TableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [_dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (!_dataArray)
	{
		return 0;
	}
	return [[_dataArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSArray *rows = [_dataArray objectAtIndex:indexPath.section];
	FlexibleCellDescription *description = [rows objectAtIndex:indexPath.row];
	NSString *cellIdentifier = [description.cellClass reuseIdentifier];
	FlexibleTableViewCell *cell = (FlexibleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
	{
		cell = [[description.cellClass alloc] init];
	}
	[cell configureForData:description.cellData TableView:tableView IndexPath:indexPath];
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	FlexibleTableViewCell *cell = (FlexibleTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
	if (![cell isKindOfClass:[FlexibleTableViewCell class]])
	{
		return;
	}
	
	[cell handleSelectionInTableView:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class cellClass = [self cellClassForRow:indexPath.row InSection:indexPath.section];
    return [cellClass rowHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	NSString *title = [self tableView:tableView titleForHeaderInSection:section];
	if ([title length] == 0)
	{
		return 0;
	}
	
	return
    [[self tableView:tableView viewForHeaderInSection:section] bounds].size.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	NSString *title = [self tableView:tableView titleForHeaderInSection:section];
	if ([title length] == 0)
	{
		return nil;
	}
	
	if ([_headerViews count] != [_dataArray count])
	{
		if (!_headerViews)
		{
			_headerViews = [[NSMutableArray alloc] initWithCapacity:[_dataArray count]];
		}
		
		while ([_headerViews count] <= section)
		{
			BOOL isGrouped = tableView.style == UITableViewStyleGrouped;
			
			const CGFloat FlexibleTableViewSectionGroupHeaderHeight = 36;
			const CGFloat FlexibleTableViewSectionPlainHeaderHeight = 22;
			const CGFloat FlexibleTableViewSectionGroupHeaderMargin = 20;
			const CGFloat FlexibleTableViewSectionPlainHeaderMargin = 5;
            
			CGRect frame = CGRectMake(0, 0, tableView.bounds.size.width,isGrouped ? FlexibleTableViewSectionGroupHeaderHeight : FlexibleTableViewSectionPlainHeaderHeight);
			
			UIView *headerView = [[UIView alloc] initWithFrame:frame];
			headerView.backgroundColor = isGrouped ? [UIColor clearColor] : [UIColor colorWithRed:0.46 green:0.52 blue:0.56 alpha:0.5];
			
			frame.origin.x = isGrouped ? FlexibleTableViewSectionGroupHeaderMargin : FlexibleTableViewSectionPlainHeaderMargin;
			frame.size.width -= 2.0 * frame.origin.x;
            
			UILabel *label = [[UILabel alloc] initWithFrame:frame];
			label.text = [self tableView:tableView titleForHeaderInSection:[_headerViews count]];
			label.backgroundColor = [UIColor clearColor];
			label.textColor = isGrouped ?
            [UIColor colorWithRed:0.3 green:0.33 blue:0.43 alpha:1.0] :
            [UIColor whiteColor];
			label.shadowColor = isGrouped ? [UIColor whiteColor] : [UIColor darkGrayColor];
			label.shadowOffset = CGSizeMake(0, 1.0);
			label.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize] + (isGrouped ? 0 : 1)];
			label.lineBreakMode = UILineBreakModeMiddleTruncation;
			label.adjustsFontSizeToFitWidth = YES;
			label.minimumFontSize = 12.0;
			[headerView addSubview:label];
			
			[_headerViews addObject:headerView];
		}
	}
    
	return [_headerViews objectAtIndex:section];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return NO;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source        
        
        [self removeRowAtIndex:[indexPath row] InSection:[indexPath section] WithAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }  
}

- (BOOL)respondsToSelector:(SEL)selector
{
	if (selector == @selector(_flexibleTableView:heightForRowAtIndexPath:))
	{
		return !_constantRowHeight;
	}
	
	if (selector == @selector(_flexibleTableView:viewForHeaderInSection:) || selector == @selector(_flexibleTableView:heightForHeaderInSection:))
	{
		return _useCustomHeaders;
	}
	
	return [super respondsToSelector:selector];
}

- (void)setConstantRowHeight:(BOOL)newValue
{
	_constantRowHeight = newValue;
	
	//
	// Clear the delegate so the tableView knows to recheck if our
	// respondsToSelector: responses have changed.
	//
	self.flexibleTableView.delegate = nil;
	self.flexibleTableView.delegate = self;
}

- (void)setUseCustomHeaders:(BOOL)newValue
{
	_useCustomHeaders = newValue;
	
	//
	// Clear the delegate so the tableView knows to recheck if our
	// respondsToSelector: responses have changed.
	//
	self.flexibleTableView.delegate = nil;
	self.flexibleTableView.delegate = self;
}

- (void)headerSectionsReordered{
    _headerViews = nil;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark - TextField handling

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
	self.currentTextField = textField;
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
	[textField resignFirstResponder];
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	if ([_currentTextField isEqual:textField])
	{
		self.currentTextField = nil;
	}
}

#pragma mark - Keyboard visibility and table scrolling

- (IBAction)dismissKeyboard:(id)sender
{
	[_currentTextField resignFirstResponder];
}

- (void)keyboardWillHideNotification:(NSNotification *)notification{
	if (_textFieldAnimatedDistance == 0)
	{
		return;
	}
	
	CGRect viewFrame = self.view.frame;
	viewFrame.size.height += _textFieldAnimatedDistance;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:FlexibleTableControllerTextAnimationDuration];
	[self.view setFrame:viewFrame];
	[UIView commitAnimations];
	
	_textFieldAnimatedDistance = 0;
}

- (void)keyboardWillShowNotification:(NSNotification *)aNotification{
	//
	// Remove any previous view offset.
	//
	[self keyboardWillHideNotification:nil];
	
	//
	// Only animate if the text field is part of the hierarchy that we manage.
	//
	UIView *parentView = [_currentTextField superview];
	while (parentView != nil && ![parentView isEqual:self.view])
	{
		parentView = [parentView superview];
	}
	if (parentView == nil)
	{
		//
		// Not our hierarchy... ignore.
		//
		return;
	}
	
	CGRect keyboardRect = CGRectZero;
	
	//
	// Perform different work on iOS 4 and iOS 3.x. Note: This requires that
	// UIKit is weak-linked. Failure to do so will cause a dylib error trying
	// to resolve UIKeyboardFrameEndUserInfoKey on startup.
	//
	if (UIKeyboardFrameEndUserInfoKey != nil)
	{
		keyboardRect = [self.view.superview convertRect:[[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue] fromView:nil];
	}
	else
	{
		NSArray *topLevelViews = [self.view.window subviews];
		if ([topLevelViews count] == 0)
		{
			return;
		}
		
		UIView *topLevelView = [[self.view.window subviews] objectAtIndex:0];
		
		//
		// UIKeyboardBoundsUserInfoKey is used as an actual string to avoid
		// deprecated warnings in the compiler.
		//
		keyboardRect = [[[aNotification userInfo] objectForKey:@"UIKeyboardBoundsUserInfoKey"] CGRectValue];
		keyboardRect.origin.y = topLevelView.bounds.size.height - keyboardRect.size.height;
		keyboardRect = [self.view.superview convertRect:keyboardRect fromView:topLevelView];
	}
	
	CGRect viewFrame = self.view.frame;
    
	_textFieldAnimatedDistance = 0;
	if (keyboardRect.origin.y < viewFrame.origin.y + viewFrame.size.height)
	{
		_textFieldAnimatedDistance = (viewFrame.origin.y + viewFrame.size.height) - (keyboardRect.origin.y - viewFrame.origin.y);
		viewFrame.size.height = keyboardRect.origin.y - viewFrame.origin.y;
        
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:FlexibleTableControllerTextAnimationDuration];
		[self.view setFrame:viewFrame];
		[UIView commitAnimations];
	}
	
	const CGFloat FlexibleTableViewControllerTextFieldScrollSpacing = 40;
    
	CGRect textFieldRect = [self.flexibleTableView convertRect:_currentTextField.bounds fromView:_currentTextField];
	textFieldRect = CGRectInset(textFieldRect, 0, -FlexibleTableViewControllerTextFieldScrollSpacing);
	[self.flexibleTableView scrollRectToVisible:textFieldRect animated:NO];
}

#pragma mark - TableView manipulation

- (NSArray *)sectionAtIndex:(NSInteger)sectionIndex{

    if ([_dataArray count] <= sectionIndex)
	{
		return nil;
	}
	
	return [_dataArray objectAtIndex:sectionIndex];

}

- (id)dataForRow:(NSInteger)rowIndex InSection:(NSInteger)sectionIndex{
    
	if ([_dataArray count] <= sectionIndex)
	{
		return nil;
	}
	
	NSArray *section = [_dataArray objectAtIndex:sectionIndex];
	if ([section count] <= rowIndex)
	{
		return nil;
	}
	
    id data = [[section objectAtIndex:rowIndex] cellData];
	return data;
}

- (NSArray *)allDataInSection:(NSInteger)sectionIndex{
    
    if ([_dataArray count] <= sectionIndex)
	{
		return nil;
	}

	return [[_dataArray objectAtIndex:sectionIndex] valueForKey:@"cellData"];
}

- (void)setData:(id)dataObject ForRow:(NSInteger)rowIndex InSection:(NSInteger)sectionIndex{

    [[[_dataArray objectAtIndex:sectionIndex] objectAtIndex:rowIndex] setCellData:dataObject];
	NSIndexPath *indexPath =  [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
	FlexibleTableViewCell *cell = (FlexibleTableViewCell*)[self.flexibleTableView cellForRowAtIndexPath:indexPath];
	[cell configureForData:dataObject TableView:self.flexibleTableView IndexPath:indexPath];
}

- (void)refreshCellForRow:(NSInteger)rowIndex InSection:(NSInteger)sectionIndex{
	NSDictionary *dataObject = [self dataForRow:rowIndex InSection:sectionIndex];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
	FlexibleTableViewCell *cell = (FlexibleTableViewCell *)[self.flexibleTableView cellForRowAtIndexPath:indexPath];
	[cell configureForData:dataObject TableView:self.flexibleTableView IndexPath:indexPath];
}

- (Class)cellClassForRow:(NSInteger)rowIndex InSection:(NSInteger)sectionIndex{
    
	if ([_dataArray count] <= sectionIndex)
	{
		return nil;
	}
	
	NSArray *section = [_dataArray objectAtIndex:sectionIndex];
	if ([section count] <= rowIndex)
	{
		return nil;
	}
    
	return [[section objectAtIndex:rowIndex] cellClass];
}

- (void)addSectionAtIndex:(NSInteger)sectionIndex WithAnimation:(UITableViewRowAnimation)animation{
    if (!_dataArray)
	{
		_dataArray = [[NSMutableArray alloc] init];
	}
	
	if (sectionIndex > [_dataArray count])
	{
		sectionIndex = [_dataArray count];
	}
	
	[_dataArray insertObject:[[NSMutableArray alloc] init] atIndex:sectionIndex];
    
	if (animation != UITableViewRowAnimationNone)
	{
		[self.flexibleTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:animation];
	}
	
	[self headerSectionsReordered];
}

- (void)removeRowAtIndex:(NSInteger)rowIndex InSection:(NSInteger)sectionIndex WithAnimation:(UITableViewRowAnimation)animation{

    if (sectionIndex >= [_dataArray count])
	{
		return;
	}
	
	NSMutableArray *section = [_dataArray objectAtIndex:sectionIndex];
	
	if (rowIndex >= [section count])
	{
		return;
	}
	
	[section removeObjectAtIndex:rowIndex];
    
	if (animation != UITableViewRowAnimationNone)
	{
		[self.flexibleTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex]]withRowAnimation:animation];
	}
}

- (void)removeAllSectionsWithAnimation:(UITableViewRowAnimation)animation{
    while ([_dataArray count] > 0)
	{
		[self removeSectionAtIndex:0 WithAnimation:animation];
	}
    
    _dataArray = nil;
}

- (void)appendRowToSection:(NSInteger)sectionIndex CellClass:(Class)cellClass CellData:(id)cellData WithAnimation:(UITableViewRowAnimation)animation{
    [self addRowAtIndex:NSIntegerMax InSection:sectionIndex CellClass:cellClass CellData:cellData WithAnimation:animation];
}


- (void)addRowAtIndex:(NSInteger)rowIndex InSection:(NSInteger)sectionIndex CellClass:(Class)cellClass CellData:(id)cellData WithAnimation:(UITableViewRowAnimation)animation{

    if (!_dataArray)
	{
		_dataArray = [[NSMutableArray alloc] init];
	}
	if ([_dataArray count] == 0)
	{
		[self addSectionAtIndex:0 WithAnimation:animation];
	}
	
	if (sectionIndex > [_dataArray count] - 1)
	{
		sectionIndex = [_dataArray count] - 1;
	}
	NSMutableArray *tableSection = [_dataArray objectAtIndex:sectionIndex];
	if (rowIndex > [tableSection count])
	{
		rowIndex = [tableSection count];
	}
	
	[tableSection insertObject:[[FlexibleCellDescription alloc]initWithCellClass:cellClass AndData:cellData] atIndex:rowIndex];
	
	if (self.flexibleTableView.style == UITableViewStyleGrouped)
	{
		if (rowIndex == [tableSection count] - 1 && rowIndex > 0)
		{
            [self refreshCellForRow:rowIndex -1 InSection:sectionIndex];
		}
	}
	if (animation != UITableViewRowAnimationNone)
	{
		[self.flexibleTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex]] withRowAnimation:animation];
	}
}
- (void)emptySectionAtIndex:(NSInteger)sectionIndex WithAnimation:(UITableViewRowAnimation)animation{
    
    if (sectionIndex >= [_dataArray count])
	{
		if (sectionIndex == [_dataArray count])
		{
            [self addSectionAtIndex:0 WithAnimation:animation];
		}
		return;
	}
	
	NSMutableArray *indexPaths = [NSMutableArray array];
	int i;
	int count = [[_dataArray objectAtIndex:sectionIndex] count];
	for (i = 0; i < count; i++)
	{
		[indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:sectionIndex]];
	}
    
	[[_dataArray objectAtIndex:sectionIndex] removeAllObjects];
    
	if (count && animation != UITableViewRowAnimationNone)
	{
		[self.flexibleTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
	}
}

- (void)removeSectionAtIndex:(NSInteger)sectionIndex WithAnimation:(UITableViewRowAnimation)animation{

    if (sectionIndex >= [_dataArray count])
	{
		return;
	}
	
	[_dataArray removeObjectAtIndex:sectionIndex];
    
//	if (animation != UITableViewRowAnimationNone)
//	{
		[self.flexibleTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:animation];
//	}
    
	[self headerSectionsReordered];

}

- (void)deselect{

    [self.flexibleTableView deselectRowAtIndexPath:[self.flexibleTableView indexPathForSelectedRow] animated:YES];

}

- (BOOL)cellIsSelected:(NSIndexPath *)indexPath {
    // Return whether the cell at the specified index path is selected or not
    if (!_selectedIndexes) {
        _selectedIndexes = [NSMutableDictionary dictionary];
    }
    NSNumber *selectedIndex = [_selectedIndexes objectForKey:indexPath];
    return selectedIndex == nil ? FALSE : [selectedIndex boolValue];
}

- (void)setCellIsSelected:(NSNumber*)selectedIndex forKey:(id)key{
    if (!self.allowMultipleCellSelection) {
        [_selectedIndexes removeAllObjects];
    }    [_selectedIndexes setObject:selectedIndex forKey:key];
}

- (NSIndexPath*)indexPathForFlexibleCell:(FlexibleTableViewCell*)flexibleCell{
    
    return [self.flexibleTableView indexPathForCell:flexibleCell];
}

@end
