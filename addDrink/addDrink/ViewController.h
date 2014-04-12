//
//  ViewController.h
//  addDrink
//
//  Created by jarthurcs on 4/11/14.
//  Copyright (c) 2014 jverticchio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *drinkName;
@property (strong, nonatomic) IBOutlet UITextField *firstIng;
@property (strong, nonatomic) IBOutlet UITextField *secondIng;
@property (strong, nonatomic) IBOutlet UITextField *thirdIng;
@property (strong, nonatomic) IBOutlet UITextField *fourthIng;
@property (strong, nonatomic) IBOutlet UIImageView *drinkImage;
@property (strong, nonatomic) IBOutlet UISlider *taste;
@property (strong, nonatomic) IBOutlet UISlider *freshness;
@property (strong, nonatomic) IBOutlet UIButton *removeButton;

- (IBAction)removeIngred:(id)sender;

- (IBAction)addImage:(id)sender;

- (IBAction)addIngred:(id)sender;

- (IBAction)addToParse:(id)sender;

@end
