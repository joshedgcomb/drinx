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
    //PFQuery *query = [PFQuery queryWithClassName:@"Drink"];
    //[query whereKey:@"name" equalTo:@"Hugo"];
   
    self.objects = [[NSArray alloc] initWithObjects:self.theDrink, nil];
    // The find succeeded.
    NSLog(@"Successfully retrieved drink");
    // Do something with the found objects
    for (PFObject *object in self.objects) {
        NSLog(@"%@", object.objectId);
        
        [self.name setText:[object objectForKey:@"name"]];
        [self.firstIngred setText:[object objectForKey:@"firstIngred"]];
        [self.secondIngred setText:[object objectForKey:@"secondIngred"]];
        [self.thirdIngred setText:[object objectForKey:@"thirdIngred"]];
        [self.fourthIngred setText:[object objectForKey:@"fourthIngred"]];
        
        
        NSNumber *taste = [object objectForKey:@"taste"];
        NSNumber *fresh = [object objectForKey:@"freshness"];
        self.ttt = [taste floatValue];
        self.fff = [fresh floatValue];
        NSLog(@"taste: %f", self.ttt);
        NSLog(@"fresh: %f", self.fff);
        [self.tasteSlide setValue:self.ttt];
        [self.freshSlide setValue:self.fff];
        
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
    
    // The find succeeded.
    NSLog(@"Successfully retrieved drink");
    // Do something with the found objects
    for (PFObject *object in self.objects) {
        NSLog(@"%@", object.objectId);
        NSNumber *score = [NSNumber numberWithFloat:(self.tasteSlide.value+self.ttt)/2 + (self.freshSlide.value+self.fff)/2];
        float scoreF = [score floatValue];
        NSLog(@"%f", scoreF);
        object[@"score"] = score;
        [self.tasteSlide setValue:(self.tasteSlide.value+self.ttt)/2];
        [self.freshSlide setValue:(self.freshSlide.value+self.fff)/2];
    }

}

- (IBAction)favorite:(id)sender {
    for (PFObject *object in self.objects) {
        NSLog(@"first: %@", object.objectId);
        PFObject *fav = [PFObject objectWithClassName:@"Favorites"];
        
        fav[@"name"]=[object objectForKey:@"name"];
        fav[@"firstIngred"]=[object objectForKey:@"firstIngred"];
        fav[@"secondIngred"]=[object objectForKey:@"secondIngred"];
        fav[@"thirdIngred"]=[object objectForKey:@"thirdIngred"];
        fav[@"fourthIngred"]=[object objectForKey:@"fourthIngred"];
        PFFile *theImage = [object objectForKey:@"image"];
        [fav setObject:theImage forKey:@"image"];
        fav[@"taste"] = [object objectForKey:@"taste"];
        fav[@"freshness"] = [object objectForKey:@"freshness"];
        fav[@"score"] = [object objectForKey:@"score"];
        
        [fav saveInBackground];
    }
}

- (IBAction)goBack:(id)sender {
    [self performSegueWithIdentifier:@"home" sender:sender];

}
@end
