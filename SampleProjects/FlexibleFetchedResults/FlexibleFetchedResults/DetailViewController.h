//
//  DetailViewController.h
//  FlexibleFetchedResults
//
//  Created by Dirk Lewis on 8/31/12.
//  Copyright (c) 2012 VHH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
