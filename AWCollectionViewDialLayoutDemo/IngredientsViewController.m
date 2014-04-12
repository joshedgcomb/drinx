//
//  IngredientsViewController.m
//  AWCollectionViewDialLayoutDemo
//
//  Created by Kevin Byrne on 4/11/14.
//  Copyright (c) 2014 Antoine Wette. All rights reserved.
//

#import "IngredientsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"
#import "DetailViewController.h"

@interface IngredientsViewController ()

@end

@implementation IngredientsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //NSLog(@"You entered %@",self.drinkName.text);
    [self.firstIngred resignFirstResponder];
    [self.secondIngred resignFirstResponder];
    [self.thirdIngred resignFirstResponder];
    [self.fourthIngred resignFirstResponder];
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //hide ingredient things
    [self.secondIngred setHidden:TRUE];
    [self.thirdIngred setHidden:TRUE];
    [self.fourthIngred setHidden:TRUE];
    [self.removeButton setHidden:TRUE];
    
    //Corner menu instantiation
    self.cornerMenu = [[ALRadialMenu alloc] init];
    self.cornerMenu.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.firstIngred resignFirstResponder];
    [self.secondIngred resignFirstResponder];
    [self.thirdIngred resignFirstResponder];
    [self.fourthIngred resignFirstResponder];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)menuPressed:(id)sender {
    if (sender == self.cornerButton) {
		[self.cornerMenu buttonsWillAnimateFromButton:sender withFrame:self.cornerButton.frame inView:self.view];
	}
}

#pragma mark - radial menu delegate methods
- (NSInteger) numberOfItemsInRadialMenu:(ALRadialMenu *)radialMenu {
	if (radialMenu == self.cornerMenu) {
		return 3;
	}
    return 0;
}

- (NSInteger) arcSizeForRadialMenu:(ALRadialMenu *)radialMenu {
	if (radialMenu == self.cornerMenu) {
		return 90;
	}
	
	return 0;
}

- (NSInteger) arcRadiusForRadialMenu:(ALRadialMenu *)radialMenu {
	if (radialMenu == self.cornerMenu) {
		return 50;
	}
	
	return 0;
}

- (UIImage *) radialMenu:(ALRadialMenu *)radialMenu imageForIndex:(NSInteger) index {
	if (radialMenu == self.cornerMenu) {
		if (index == 1) {
			return [UIImage imageNamed:@"addthis500"];
		} else if (index == 2) {
			return [UIImage imageNamed:@"favoritesbutton"];
		} else if (index == 3) {
			return [UIImage imageNamed:@"drinksbutton"];
		}
	}
	
	return nil;
}

- (void) radialMenu:(ALRadialMenu *)radialMenu didSelectItemAtIndex:(NSInteger)index {
    self.myIndex = index;
	if (radialMenu == self.cornerMenu) {
		[self.cornerMenu itemsWillDisapearIntoButton:self.cornerButton];
		if (index == 1) {
			NSLog(@"add");
            [self performSegueWithIdentifier:@"add" sender:self.cornerButton];
		} else if (index == 2) {
			NSLog(@"favs");
            [self performSegueWithIdentifier:@"favs" sender:self.cornerButton];
		} else if (index == 3) {
			NSLog(@"drinks");
            [self performSegueWithIdentifier:@"favs" sender:self.cornerButton];
		}
	}
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"yoooo");
    if (self.myIndex == 2)   {
        
        ViewController* controller = (ViewController *) [segue destinationViewController];
        controller.viewTitle = @"Favorites";
        NSLog(@"blehhhh");
        controller.numnum = 2;
    }
    else if (self.myIndex == 3)    {
        ViewController* controller = (ViewController *) [segue destinationViewController];
        controller.viewTitle = @"All Drinks";
        controller.numnum = 3;
    }
    else if ([segue.identifier isEqualToString:@"mixToDetail"])  {
        DetailViewController* controller = (DetailViewController *) [segue destinationViewController];
        controller.theDrink = self.myDrink;
        
    }
}


- (IBAction)addIngred:(id)sender {
    NSLog(@"add");
    if (self.secondIngred.isHidden == TRUE) {
        [self.secondIngred setHidden:FALSE];
        [self.removeButton setHidden:FALSE];
    }
    else if (self.thirdIngred.isHidden == TRUE){
        [self.thirdIngred setHidden:FALSE];
    }
    else if (self.fourthIngred.isHidden == TRUE){
        [self.fourthIngred setHidden:FALSE];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Slow Down!" message:@"Let's keep it to four ingredients, eh?" delegate:nil cancelButtonTitle:@"Ugh, fine" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)removeIngred:(id)sender {
    NSLog(@"remove");
    if (self.fourthIngred.isHidden == FALSE) {
        [self.fourthIngred setText:nil];
        [self.fourthIngred setHidden:TRUE];
        NSLog(@"4");
        NSLog(self.fourthIngred.isHidden ? @"Yes": @"No");
    }
    else if (self.thirdIngred.isHidden == FALSE){
        [self.thirdIngred setText:nil];
        [self.thirdIngred setHidden:TRUE];
        NSLog(@"3");
    }
    else if (self.secondIngred.isHidden == FALSE){
        [self.secondIngred setText:nil];
        [self.secondIngred setHidden:TRUE];
        [self.removeButton setHidden:TRUE];
        NSLog(@"2");
    }
}



- (IBAction)mix:(id)sender {
        PFQuery *query = [PFQuery queryWithClassName:@"Drinks"];
        [query whereKey:@"firstIngred" equalTo:self.firstIngred.text];
        NSArray *results= [query findObjects];
        if (results.count > 0){
             self.myDrink = [results objectAtIndex:0];
            [self performSegueWithIdentifier:@"mixToDetail" sender:sender];
            NSLog(@"result found");
        }
        else{
            [query whereKey:@"secondIngred" equalTo:self.firstIngred.text];
            results= [query findObjects];
            if (results.count > 0){
                // segue to detail view of first object in list
                NSLog(@"result found");
            }
            else{
                [query whereKey:@"thirdIngred" equalTo:self.firstIngred.text];
                results= [query findObjects];
                if (results.count > 0){
                    // segue to detail view of first object in list
                    NSLog(@"result found");
                }
                else{
                    [query whereKey:@"fourthIngred" equalTo:self.firstIngred.text];
                    results= [query findObjects];
                    if (results.count > 0){
                        // segue to detail view of first object in list
                        NSLog(@"result found");
                    }
                    else{
                        [query whereKey:@"firstIngred" equalTo:self.secondIngred.text];
                        results= [query findObjects];
                        if (results.count > 0){
                            // segue to detail view of first object in list
                            NSLog(@"result found");
                        }
                        else{
                            [query whereKey:@"secondIngred" equalTo:self.secondIngred.text];
                            results= [query findObjects];
                            if (results.count > 0){
                                // segue to detail view of first object in list
                                NSLog(@"result found");
                            }
                            else{
                                [query whereKey:@"thirdIngred" equalTo:self.secondIngred.text];
                                results= [query findObjects];
                                if (results.count > 0){
                                    // segue to detail view of first object in list
                                    NSLog(@"result found");
                                }
                                else{
                                    [query whereKey:@"fourthIngred" equalTo:self.secondIngred.text];
                                    results= [query findObjects];
                                    if (results.count > 0){
                                        // segue to detail view of first object in list
                                        NSLog(@"result found");
                                    }
                                    else{
                                        [query whereKey:@"firstIngred" equalTo:self.thirdIngred.text];
                                        results= [query findObjects];
                                        if (results.count > 0){
                                            // segue to detail view of first object in list
                                            NSLog(@"result found");
                                        }
                                        else{
                                            [query whereKey:@"secondIngred" equalTo:self.thirdIngred.text];
                                            results= [query findObjects];
                                            if (results.count > 0){
                                                // segue to detail view of first object in list
                                                NSLog(@"result found");
                                            }
                                            else{
                                                [query whereKey:@"thirdIngred" equalTo:self.thirdIngred.text];
                                                results= [query findObjects];
                                                if (results.count > 0){
                                                    // segue to detail view of first object in list
                                                    NSLog(@"result found");
                                                }
                                                else{
                                                    [query whereKey:@"fourthIngred" equalTo:self.thirdIngred.text];
                                                    results= [query findObjects];
                                                    if (results.count > 0){
                                                        // segue to detail view of first object in list
                                                        NSLog(@"result found");
                                                    }
                                                    else{
                                                        [query whereKey:@"firstIngred" equalTo:self.fourthIngred.text];
                                                        results= [query findObjects];
                                                        if (results.count > 0){
                                                            // segue to detail view of first object in list
                                                            NSLog(@"result found");
                                                        }
                                                        else{
                                                            [query whereKey:@"secondIngred" equalTo:self.fourthIngred.text];
                                                            results= [query findObjects];
                                                            if (results.count > 0){
                                                                // segue to detail view of first object in list
                                                                NSLog(@"result found");
                                                            }
                                                            else{
                                                                [query whereKey:@"thirdIngred" equalTo:self.fourthIngred.text];
                                                                results= [query findObjects];
                                                                if (results.count > 0){
                                                                    // segue to detail view of first object in list
                                                                    NSLog(@"result found");
                                                                }
                                                                else{
                                                                    [query whereKey:@"fourthIngred" equalTo:self.fourthIngred.text];
                                                                    results= [query findObjects];
                                                                    if (results.count > 0){
                                                                        // segue to detail view of first object in list
                                                                        NSLog(@"result found");
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
}
@end
