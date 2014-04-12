//
//  ViewController.h
//  AWCollectionViewDialLayoutDemo
//
//  Created by Antoine Wette on 14.03.14.
//  Copyright (c) 2014 Antoine Wette. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate> {
    
    NSMutableArray *allDrinks;
    NSMutableArray *myImages;
}

@property (weak, nonatomic) IBOutlet UILabel *myTitle;

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *editBtn;
@property NSArray *items;
@property NSString *viewTitle;
- (IBAction)backButton:(id)sender;
@end
