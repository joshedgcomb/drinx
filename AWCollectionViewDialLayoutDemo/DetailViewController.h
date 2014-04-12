//
//  DetailViewController.h
//  addDrink
//
//  Created by jarthurcs on 4/12/14.
//  Copyright (c) 2014 jverticchio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface DetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *firstIngred;
@property (strong, nonatomic) IBOutlet UILabel *secondIngred;
@property (strong, nonatomic) IBOutlet UILabel *thirdIngred;
@property (strong, nonatomic) IBOutlet UILabel *fourthIngred;
@property (strong, nonatomic) IBOutlet UISlider *tasteSlide;
@property (strong, nonatomic) IBOutlet UISlider *freshSlide;
@property PFObject *theDrink;
@property NSArray *objects;
@property float ttt;
@property float fff;
- (IBAction)rate:(id)sender;
- (IBAction)favorite:(id)sender;
- (IBAction)goBack:(id)sender;


@end
