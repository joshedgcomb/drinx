//
//  ViewController.m
//  AWCollectionViewDialLayoutDemo
//
//  Created by Antoine Wette on 14.03.14.
//  Copyright (c) 2014 Antoine Wette. All rights reserved.
//

#import "ViewController.h"
#import "AWCollectionViewDialLayout.h"

@interface ViewController ()

@end

static NSString *cellId = @"cellId";
static NSString *cellId2 = @"cellId2";


@implementation ViewController{
    NSMutableDictionary *thumbnailCache;
    BOOL showingSettings;
    UIView *settingsView;
    
    UILabel *radiusLabel;
    UISlider *radiusSlider;
    UILabel *angularSpacingLabel;
    UISlider *angularSpacingSlider;
    UILabel *xOffsetLabel;
    UISlider *xOffsetSlider;
    UISegmentedControl *exampleSwitch;
    AWCollectionViewDialLayout *dialLayout;
    
    int type;
}

@synthesize collectionView, items, editBtn;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    type = 0;
    showingSettings = NO;
    allDrinks = [[NSMutableArray alloc] init];
    myImages = [self downloadAllDrinks];
    
    [collectionView registerNib:[UINib nibWithNibName:@"dialCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellId];
    [collectionView registerNib:[UINib nibWithNibName:@"dialCell2" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellId2];
    
    
    NSError *error;
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"drinks" ofType:@"json"];
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:NULL];
    //NSLog(@"jsonString:%@",jsonString);
    items = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    settingsView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-44)];
    [settingsView setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.6]];
    [self.view addSubview:settingsView];
    [self buildSettings];
    
    
    CGFloat radius = radiusSlider.value * 1000;
    CGFloat angularSpacing = angularSpacingSlider.value * 90;
    CGFloat xOffset = xOffsetSlider.value * 320;
    CGFloat cell_width = 240;
    CGFloat cell_height = 100;
    [radiusLabel setText:[NSString stringWithFormat:@"Radius: %i", (int)radius]];
    [angularSpacingLabel setText:[NSString stringWithFormat:@"Angular spacing: %i", (int)angularSpacing]];
    [xOffsetLabel setText:[NSString stringWithFormat:@"X offset: %i", (int)xOffset]];
    
    
    
    dialLayout = [[AWCollectionViewDialLayout alloc] initWithRadius:radius andAngularSpacing:angularSpacing andCellSize:CGSizeMake(cell_width, cell_height) andAlignment:WHEELALIGNMENTCENTER andItemHeight:cell_height andXOffset:xOffset];
    [collectionView setCollectionViewLayout:dialLayout];

    [editBtn setTarget:self];
    [editBtn setAction:@selector(goBack:)];
    
    [self switchExample];
    
}

-(IBAction)goBack:(id)sender    {
    [self performSegueWithIdentifier:@"backFromFavorites" sender:self];
}

-(void)buildSettings{
    NSArray *viewArr = [[NSBundle mainBundle] loadNibNamed:@"iphone_settings_view" owner:self options:nil];
    UIView *innerView = [viewArr objectAtIndex:0];
    CGRect frame = innerView.frame;
    frame.origin.y = (self.view.frame.size.height/2 - frame.size.height/2)/2;
    innerView.frame = frame;
    [settingsView addSubview:innerView];
    
    radiusLabel = (UILabel*)[innerView viewWithTag:100];
    radiusSlider = (UISlider*)[innerView viewWithTag:200];
    [radiusSlider addTarget:self action:@selector(updateDialSettings) forControlEvents:UIControlEventValueChanged];
    
    angularSpacingLabel = (UILabel*)[innerView viewWithTag:101];
    angularSpacingSlider = (UISlider*)[innerView viewWithTag:201];
    [angularSpacingSlider addTarget:self action:@selector(updateDialSettings) forControlEvents:UIControlEventValueChanged];
    
    xOffsetLabel = (UILabel*)[innerView viewWithTag:102];
    xOffsetSlider = (UISlider*)[innerView viewWithTag:202];
    [xOffsetSlider addTarget:self action:@selector(updateDialSettings) forControlEvents:UIControlEventValueChanged];
    
    exampleSwitch = (UISegmentedControl*)[innerView viewWithTag:203];
    [exampleSwitch addTarget:self action:@selector(switchExample) forControlEvents:UIControlEventValueChanged];
}

-(void)switchExample{
    type = (int)exampleSwitch.selectedSegmentIndex;
    CGFloat radius = 0 ,angularSpacing  = 0, xOffset = 0;
    
    if(type == 0){
        [dialLayout setCellSize:CGSizeMake(240, 100)];
        [dialLayout setWheelType:WHEELALIGNMENTLEFT];
        
        radius = 300;
        angularSpacing = 18;
        xOffset = 70;
    }else if(type == 1){
        [dialLayout setCellSize:CGSizeMake(260, 50)];
        [dialLayout setWheelType:WHEELALIGNMENTCENTER];
        
        radius = 320;
        angularSpacing = 5;
        xOffset = 124;
    }
    
    [radiusLabel setText:[NSString stringWithFormat:@"Radius: %i", (int)radius]];
    radiusSlider.value = radius/1000;
    [dialLayout setDialRadius:radius];
    
    [angularSpacingLabel setText:[NSString stringWithFormat:@"Angular spacing: %i", (int)angularSpacing]];
    angularSpacingSlider.value = angularSpacing / 90;
    [dialLayout setAngularSpacing:angularSpacing];
    
    [xOffsetLabel setText:[NSString stringWithFormat:@"X offset: %i", (int)xOffset]];
    xOffsetSlider.value = xOffset/320;
    [dialLayout setXOffset:xOffset];
    
    
    [collectionView reloadData];

}

-(void)updateDialSettings{
    CGFloat radius = radiusSlider.value * 1000;
    CGFloat angularSpacing = angularSpacingSlider.value * 90;
    CGFloat xOffset = xOffsetSlider.value * 320;
    
    [radiusLabel setText:[NSString stringWithFormat:@"Radius: %i", (int)radius]];
    [dialLayout setDialRadius:radius];
    
    [angularSpacingLabel setText:[NSString stringWithFormat:@"Angular spacing: %i", (int)angularSpacing]];
    [dialLayout setAngularSpacing:angularSpacing];
    
    [xOffsetLabel setText:[NSString stringWithFormat:@"X offset: %i", (int)xOffset]];
    [dialLayout setXOffset:xOffset];
    
    [dialLayout invalidateLayout];
    //[collectionView reloadData];
    //NSLog(@"updateDialSettings");
}

-(void)toggleSettingsView{
    CGRect frame = settingsView.frame;
    if(showingSettings){
        editBtn.title = @"Edit";
        frame.origin.y = self.view.frame.size.height;
    }else{
        editBtn.title = @"Close";
        frame.origin.y = 44;
    }
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        settingsView.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
    
    showingSettings = !showingSettings;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return allDrinks.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell;
    if(type == 0){
        cell = [cv dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    }else{
        cell = [cv dequeueReusableCellWithReuseIdentifier:cellId2 forIndexPath:indexPath];
    }
    
    NSDictionary *item = [self.items objectAtIndex:indexPath.item];
    
    //NSString *playerName = [item valueForKey:@"name"];
    UILabel *nameLabel = (UILabel*)[cell viewWithTag:101];
    PFObject* currentDrink = [allDrinks objectAtIndex:indexPath.item];
    [nameLabel setText:[currentDrink objectForKey:@"name"]];
    
    
    NSString *hexColor = [item valueForKey:@"team-color"];
    
    
    if(type == 0){
        NSLog(@"hiii");
        
        UIView *borderView = [cell viewWithTag:102];
        
        borderView.layer.borderWidth = 1;
        borderView.layer.borderColor = [self colorFromHex:hexColor].CGColor;
        
        NSString *imgURL = [item valueForKey:@"picture"];
        UIImageView *imgView = (UIImageView*)[cell viewWithTag:100];
        [imgView setImage:nil];
        UIImage *imageProduct = [myImages objectAtIndex:indexPath.item];
        if(imageProduct){
            imgView.image = imageProduct;
        }
        else{
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(queue, ^{
                UIImage *image = [UIImage imageNamed:imgURL];
                dispatch_async(dispatch_get_main_queue(), ^{
                    imgView.image = image;
                    [thumbnailCache setValue:image forKey:imgURL];
                });
            });
        }
        
    }else{
        nameLabel.textColor = [self colorFromHex:hexColor];
    }    
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"didEndDisplayingCell:%i", (int)indexPath.item);
}


#pragma mark - UICollectionViewDelegate methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(240, 100);
}


- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0 , 0, 0, 0);
}

- (unsigned int)intFromHexString:(NSString *)hexStr
{
    unsigned int hexInt = 0;
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    // Scan hex value
    [scanner scanHexInt:&hexInt];
    return hexInt;
}

-(UIColor*)colorFromHex:(NSString*)hexString{
    unsigned int hexint = [self intFromHexString:hexString];
    
    // Create color object, specifying alpha as well
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:1];
    
    return color;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSMutableArray*)downloadAllDrinks
{
    
    NSLog(@"dfsjlkafjls;");
    PFQuery *query = [PFQuery queryWithClassName:@"Drink"];
    //PFUser *user = [PFUser currentUser];
    //[query whereKey:@"objectId" equalTo:@"6wz5f8NQns"];
    NSArray* objects = [query findObjects];
    //[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        // If there are photos, we start extracting the data
        // Save a list of object IDs while extracting this data
        
        
       // NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        
        if (objects.count > 0) {
            NSLog(@"yoooo:");
            for (PFObject *eachObject in objects) {
                //NSLog([eachObject objectId]);
                [allDrinks addObject:eachObject];
                NSLog(@"%d",allDrinks.count);
            }
            
            }
        else    {
            NSLog(@"damnit");
        }
    //}];
    return [self setUpImages:allDrinks];
}

- (NSMutableArray*)setUpImages:(NSArray *)images
{
    // Contains a list of all the BUTTONS
    allDrinks = [images mutableCopy];
    NSMutableArray *imageDataArray = [NSMutableArray array];
    
    // This method sets up the downloaded images and places them nicely in a grid
        
        
        // Iterate over all images and get the data from the PFFile
        for (int i = 0; i < images.count; i++) {
            //NSLog(@"aaaaaalkajlkalalkaklsljaljaljdlldldljkasdljkadjlksjdajdlajsdl");
            PFObject *eachObject = [images objectAtIndex:i];
            NSLog([eachObject objectId]);
            PFFile *theImage = [eachObject objectForKey:@"image"];
            NSData *imageData = [theImage getData];
            NSLog(@"jlskdjfklds");
            UIImage *image = [UIImage imageWithData:imageData];

            NSLog(@"ajlsjdflkajsdlkfjalskdjflajsdlfkjalsdfjalsdjflaksjdf");
            if (image != nil)   {
            [imageDataArray addObject:image];
            }
            else{
                
                [imageDataArray addObject:[UIImage imageNamed:@"default.jpg"]];
            }
            
        }
        
        /*// Dispatch to main thread to update the UI
        dispatch_async(dispatch_get_main_queue(), ^{
            // Remove old grid
            for (UIView *view in [photoScrollView subviews]) {
                if ([view isKindOfClass:[UIButton class]]) {
                    [view removeFromSuperview];
                }
            }
            
            // Create the buttons necessary for each image in the grid
            for (int i = 0; i < [imageDataArray count]; i++) {
                PFObject *eachObject = [images objectAtIndex:i];
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                UIImage *image = [imageDataArray objectAtIndex:i];
                [button setImage:image forState:UIControlStateNormal];
                button.showsTouchWhenHighlighted = YES;
                [button addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
                button.tag = i;
                button.frame = CGRectMake(THUMBNAIL_WIDTH * (i % THUMBNAIL_COLS) + PADDING * (i % THUMBNAIL_COLS) + PADDING,
                                          THUMBNAIL_HEIGHT * (i / THUMBNAIL_COLS) + PADDING * (i / THUMBNAIL_COLS) + PADDING + PADDING_TOP,
                                          THUMBNAIL_WIDTH,
                                          THUMBNAIL_HEIGHT);
                button.imageView.contentMode = UIViewContentModeScaleAspectFill;
                [button setTitle:[eachObject objectId] forState:UIControlStateReserved];
                //[photoScrollView addSubview:button];
            }
            
            // Size the grid accordingly
            int rows = images.count / THUMBNAIL_COLS;
            if (((float)images.count / THUMBNAIL_COLS) - rows != 0) {
                rows++;
            }
            int height = THUMBNAIL_HEIGHT * rows + PADDING * rows + PADDING + PADDING_TOP;
            
            photoScrollView.contentSize = CGSizeMake(self.view.frame.size.width, height);
            photoScrollView.clipsToBounds = YES;
             */

    return imageDataArray;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"bonerSegue" sender:self];
}



@end
