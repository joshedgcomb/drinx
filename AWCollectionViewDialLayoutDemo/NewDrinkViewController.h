//
//  NewDrinkViewController.h
//  AWCollectionViewDialLayoutDemo
//
//  Created by Kevin Byrne on 4/12/14.
//  Copyright (c) 2014 Antoine Wette. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface NewDrinkViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *drinkName;
@property (strong, nonatomic) IBOutlet UITextField *firstIng;
@property (strong, nonatomic) IBOutlet UITextField *secondIng;
@property (strong, nonatomic) IBOutlet UITextField *thirdIng;
@property (strong, nonatomic) IBOutlet UITextField *fourthIng;
@property (strong, nonatomic) IBOutlet UISlider *taste;
@property (strong, nonatomic) IBOutlet UISlider *freshness;
@property (strong, nonatomic) IBOutlet UIButton *removeButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *chosenImage;
@property (strong, nonatomic) UIImagePickerController *imagePicker;

- (IBAction)removeIngred:(id)sender;

- (IBAction)addImage:(id)sender;

- (IBAction)addIngred:(id)sender;

- (IBAction)addToParse:(id)sender;

- (IBAction)backButton:(id)sender;

@end
