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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.cornerMenu = [[ALRadialMenu alloc] init];
    self.cornerMenu.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
		}
	}
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ViewController* controller = (ViewController *)segue.destinationViewController;
    controller.viewTitle = segue.identifier;
}


@end
