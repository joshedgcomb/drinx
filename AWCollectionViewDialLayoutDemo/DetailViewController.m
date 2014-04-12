//
//  DetailViewController.m
//  AWCollectionViewDialLayoutDemo
//
//  Created by jarthurcs on 4/12/14.
//  Copyright (c) 2014 Antoine Wette. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
    PFQuery *query = [PFQuery queryWithClassName:@"Drink"];
    [query whereKey:@"name" equalTo:@"Hugo"];
   
    NSArray *objects = [query findObjects];
    // The find succeeded.
    NSLog(@"Successfully retrieved drink");
    // Do something with the found objects
    for (PFObject *object in objects) {
        NSLog(@"%@", object.objectId);
        
        [self.name setText:[object objectForKey:@"name"]];
        [self.firstIngred setText:[object objectForKey:@"firstIngred"]];
        [self.secondIngred setText:[object objectForKey:@"secondIngred"]];
        [self.thirdIngred setText:[object objectForKey:@"thirdIngred"]];
        [self.fourthIngred setText:[object objectForKey:@"fourthIngred"]];
        
        
        NSNumber *taste = [object objectForKey:@"taste"];
        NSNumber *fresh = [object objectForKey:@"freshness"];
        float ttt = [taste floatValue];
        float fff = [fresh floatValue];
        NSLog(@"taste: %f", ttt);
        NSLog(@"fresh: %f", fff);
        [self.tasteSlide setValue:ttt];
        [self.freshSlide setValue:fff];
        
        PFFile *theImage = [object objectForKey:@"image"];
        NSData *imageData = [theImage getData];
        UIImage *image = [UIImage imageWithData:imageData];
        
        if (image != nil)   {
            [self.image setImage:image];
        }
        else{
            
            [self.image setImage:[UIImage imageNamed:@"Icon-round-Question_mark.jpg"]];
        }
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rate:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"Drink"];
    [query whereKey:@"name" equalTo:@"Hugo"];
    
    NSArray *objects = [query findObjects];
    // The find succeeded.
    NSLog(@"Successfully retrieved drink");
    // Do something with the found objects
    for (PFObject *object in objects) {
        NSLog(@"%@", object.objectId);
        
    NSNumber *score = [NSNumber numberWithFloat:self.tasteSlide.value + self.freshSlide.value];
        
    }

}

- (IBAction)favorite:(id)sender {
}
@end
