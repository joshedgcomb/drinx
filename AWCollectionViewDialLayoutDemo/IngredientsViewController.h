//
//  IngredientsViewController.h
//  AWCollectionViewDialLayoutDemo
//
//  Created by Kevin Byrne on 4/11/14.
//  Copyright (c) 2014 Antoine Wette. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlRadialMenu.h"

@interface IngredientsViewController : UIViewController

- (IBAction)menuPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cornerButton;
@property (strong, nonatomic) ALRadialMenu *cornerMenu;

@end