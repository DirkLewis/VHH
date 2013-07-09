//
//  VHHCollectionViewController.m
//  WAHS
//
//  Created by Dirk Lewis on 6/28/13.
//  Copyright (c) 2013 VHH. All rights reserved.
//

#import "VHHCollectionViewController.h"
#import "VHHPhotoAlbumLayout.h"
#import "VHHPhotoCell.h"
#import "VHHAlbum.h"
#import "VHHPhoto.h"
#import "VHHAlbumTitleReusableView.h"

static NSString *const PhotoCellIdentifier = @"photocell";
static NSString * const AlbumTitleIdentifier = @"albumtitle";

@interface VHHCollectionViewController ()

@property (weak, nonatomic) IBOutlet VHHPhotoAlbumLayout *albumLayout;
@property (strong, nonatomic)NSMutableArray *albums;
@property (nonatomic,strong)NSOperationQueue *thumbNailQueue;
@end

@implementation VHHCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *patternImage = [UIImage imageNamed:@"concrete_wall"];
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:patternImage];
    self.thumbNailQueue = [[NSOperationQueue alloc]init];
    self.thumbNailQueue.maxConcurrentOperationCount = 3;
    
	// Do any additional setup after loading the view.
    //self.collectionView.backgroundColor = [UIColor colorWithWhite:0.25f alpha:1.0f];
    [self.collectionView registerClass:[VHHPhotoCell class] forCellWithReuseIdentifier:PhotoCellIdentifier];
    self.albums = [NSMutableArray array];
    NSURL *urlPrefix = [NSURL URLWithString:@"https://raw.github.com/ShadoFlameX/PhotoCollectionView/master/Photos/"];
    NSInteger photoIndex = 0;
    for (NSInteger a = 0; a < 12; a++) {
        VHHAlbum *album = [[VHHAlbum alloc]init];
        album.name = [NSString stringWithFormat:@"Photo Album %d",a+1];
        NSUInteger photoCount = 6;// arc4random()%4 + 2;
        for (NSInteger p = 0; p < photoCount; p++) {
            NSString *photoFilename = [NSString stringWithFormat:@"thumbnail%d.jpg",(photoIndex % 25)];
            NSURL *photoURL = [urlPrefix URLByAppendingPathComponent:photoFilename];
            VHHPhoto *photo = [VHHPhoto photoWithImageURL:photoURL];
            [album addPhoto:photo];
            photoIndex ++;
        }
        [self.albums addObject:album];
    }
    
    [self.collectionView registerClass:[VHHAlbumTitleReusableView class] forSupplementaryViewOfKind:VHHPhotoAlbumLayoutAlbumTitleKind withReuseIdentifier:AlbumTitleIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        self.albumLayout.numberOfColumns = 3;
        NSLog(@"width %f, height %f", [UIScreen mainScreen].preferredMode.size.width, [UIScreen mainScreen].preferredMode.size.height);
        CGFloat sideInset = [UIScreen mainScreen].preferredMode.size.width == 1136.0f ? 45.0f : 25.0f;
        NSLog(@"side inset %f",sideInset);
        self.albumLayout.itemInsets = UIEdgeInsetsMake(22.0f, sideInset, 13.0f, sideInset);
        
    }
    else{
        self.albumLayout.numberOfColumns = 2;
        self.albumLayout.itemInsets = UIEdgeInsetsMake(22.0f, 22.0f, 13.0f, 22.0f);
    }
}

#pragma mark - datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.albums.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    VHHAlbum *album = self.albums[section];
    return album.photos.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    VHHPhotoCell *photocell = [collectionView dequeueReusableCellWithReuseIdentifier:PhotoCellIdentifier forIndexPath:indexPath];
    VHHAlbum *album = self.albums[indexPath.section];
    VHHPhoto *photo = album.photos[indexPath.item];
    
    __weak VHHCollectionViewController *weakSelf = self;
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        UIImage *image = [photo image];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([weakSelf.collectionView.indexPathsForVisibleItems containsObject:indexPath]) {
                VHHPhotoCell *cell = (VHHPhotoCell*)[weakSelf.collectionView cellForItemAtIndexPath:indexPath];
                cell.imageView.image = image;
            }
        });
    }];
    
    operation.queuePriority = (indexPath.item == 0) ? NSOperationQueuePriorityHigh : NSOperationQueuePriorityNormal;
    [self.thumbNailQueue addOperation:operation];
    return photocell;
}


- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    VHHAlbumTitleReusableView *titleView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:AlbumTitleIdentifier forIndexPath:indexPath];
    VHHAlbum *album = self.albums[indexPath.section];
    titleView.titleLabel.text = album.name;
    return titleView;
}












@end
