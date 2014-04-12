//
//  NewDrinkViewController.m
//  AWCollectionViewDialLayoutDemo
//
//  Created by Kevin Byrne on 4/12/14.
//  Copyright (c) 2014 Antoine Wette. All rights reserved.
//

#import "NewDrinkViewController.h"

@interface NewDrinkViewController ()

@end

@implementation NewDrinkViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.secondIng setHidden:TRUE];
    [self.thirdIng setHidden:TRUE];
    [self.fourthIng setHidden:TRUE];
    [self.removeButton setHidden:TRUE];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"You entered %@",self.drinkName.text);
    [self.drinkName resignFirstResponder];
    [self.firstIng resignFirstResponder];
    [self.secondIng resignFirstResponder];
    [self.thirdIng resignFirstResponder];
    [self.fourthIng resignFirstResponder];
    return YES;
}


- (IBAction)removeIngred:(id)sender {
    NSLog(@"remove");
    if (self.fourthIng.isHidden == FALSE) {
        [self.fourthIng setText:nil];
        [self.fourthIng setHidden:TRUE];
        NSLog(@"4");
        NSLog(self.fourthIng.isHidden ? @"Yes": @"No");
    }
    else if (self.thirdIng.isHidden == FALSE){
        [self.thirdIng setText:nil];
        [self.thirdIng setHidden:TRUE];
        NSLog(@"3");
    }
    else if (self.secondIng.isHidden == FALSE){
        [self.secondIng setText:nil];
        [self.secondIng setHidden:TRUE];
        [self.removeButton setHidden:TRUE];
        NSLog(@"2");
    }
}

- (IBAction)addImage:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:    (NSDictionary *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.drinkImage setImage:image];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (IBAction)addIngred:(id)sender {
    NSLog(@"add");
    if (self.secondIng.isHidden == TRUE) {
        [self.secondIng setHidden:FALSE];
        [self.removeButton setHidden:FALSE];
    }
    else if (self.thirdIng.isHidden == TRUE){
        [self.thirdIng setHidden:FALSE];
    }
    else if (self.fourthIng.isHidden == TRUE){
        [self.fourthIng setHidden:FALSE];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Slow Down!" message:@"Let's keep it to four ingredients, eh?" delegate:nil cancelButtonTitle:@"Ugh, fine" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)addToParse:(id)sender {
    PFObject *drink = [PFObject objectWithClassName:@"Drink"];
    //NSString *name = [NSString stringWithFormat:self.drinkName.text];
    //float taste = [self.taste value];
    //float freshness = [self.freshness value];
    //NSNumber *tasteNum = [NSNumber numberWithFloat:taste];
    //NSNumber *freshNum = [NSNumber numberWithFloat:freshness];
    
    NSLog([NSString stringWithFormat:self.drinkName.text]);
    
    drink[@"name"] = [NSString stringWithFormat:self.drinkName.text];
    drink[@"firstIngred"] = [NSString stringWithFormat:self.firstIng.text];
    drink[@"secondIngred"] = [NSString stringWithFormat:self.secondIng.text];
    drink[@"thirdIngred"] = [NSString stringWithFormat:self.thirdIng.text];
    drink[@"fourthIngred"] = [NSString stringWithFormat:self.fourthIng.text];
    
    //NSLog(@"up to image");
    //drink[@"image"] = self.drinkImage.image;
    //NSLog(@"after image");
    
    NSData *imageData = UIImageJPEGRepresentation(self.drinkImage.image, 0.8);
    NSString *filename = [NSString stringWithFormat:@"%@.png", self.drinkName.text];
    PFFile *imageFile = [PFFile fileWithName:filename data:imageData];
    [drink setObject:imageFile forKey:@"image"];
    drink[@"taste"] = [NSNumber numberWithFloat:self.taste.value];
    drink[@"freshness"] = [NSNumber numberWithFloat:self.freshness.value];
    
    [drink saveInBackground];
}

- (IBAction)backButton:(id)sender {
    [self performSegueWithIdentifier:@"fromNew" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"bonerSegue"])   {
        
    }
}

@end
