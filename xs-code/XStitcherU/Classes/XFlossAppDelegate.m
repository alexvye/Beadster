//
//  XFlossAppDelegate.m
//  XFloss
//
//  Created by Alex Vye on 10-08-05.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "XFlossAppDelegate.h"
#import "DataManager.h"
#import <CoreData/CoreData.h>
#import "BrandDB.h"
#import "FlossDB.h"
#import "ProjectDB.h"
#import "ProjectFlossDB.h"
#import "MenuTableViewController.h"
#import "Globals.h"

//
// legacy
//
#import "Project.h"

@implementation XFlossAppDelegate

@synthesize drawerController, centerNavController;

@synthesize window;
@synthesize tabBarController;

@synthesize managedObjectContext = __managedObjectContext;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize localSystem;

#pragma mark -
#pragma mark Application lifecycle

//
// used for system updates
//

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"INT_MAX:    %i",   INT_MAX);
    //
    // Check if we have upgraded from an old version
    //
    [self upgradeData];

    //
    // Draw the peek menu
    //
    
    if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
        storyboardName = @"Storyboard-iphone";
        buttonFontSize = 15;
    } else {
        // Storyboard-ipad.storyboard
        storyboardName = @"Storyboard-ipad";
        buttonFontSize = 40;
    }
    
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
    
    //
    // peek menu
    //
    UIViewController * leftSideDrawerViewController = [[MenuTableViewController alloc] init];
    leftSideDrawerViewController.view.backgroundColor = [UIColor blueColor];
    
    UINavigationController * leftSideNavController = [[UINavigationController alloc] initWithRootViewController:leftSideDrawerViewController];
    
    //
    // content
    //
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController *centerViewController = [storyboard instantiateInitialViewController];
    
    self.centerNavController = [[UINavigationController alloc] initWithRootViewController:centerViewController];
    
    //
    // put them together
    //
    self.drawerController = [[MMDrawerController alloc]
                        initWithCenterViewController:centerNavController leftDrawerViewController:leftSideNavController];
    
    [self.drawerController setShowsShadow:YES];

    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    [self.drawerController setMaximumRightDrawerWidth:200.0];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [self.drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         /*
         block = [[MMExampleDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
          */
     }];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    if( OSVersionIsAtLeastiOS7()){
        UIColor * tintColor = [UIColor colorWithRed:29.0/255.0
                                              green:173.0/255.0
                                               blue:234.0/255.0
                                              alpha:1.0];
        [self.window setTintColor:tintColor];
    }
    
    [self.window setRootViewController:drawerController];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}
- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */

- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Threads" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"XStitcher.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return __persistentStoreCoordinator;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (void)initialize {
    NSDictionary *defaults = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO], @"profit", @"default@gmail.com", @"export-email", nil];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
}

//
// Method to upgrade data storage from old file-base storage to core data storage. Leave old files
// there just in case
//
-(void)upgradeData {
    //
    // Check if the db has been populated
    //
    
     NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"System" inManagedObjectContext:self.managedObjectContext];
     
     NSFetchRequest *request = [[NSFetchRequest alloc] init];
     [request setEntity:entityDesc];
     
     NSError *error;
     NSArray* result = [self.managedObjectContext executeFetchRequest:request error:&error];
    
     if(result.count == 0) { // no db
         NSLog(@"No DB found, loading data");
         
         //
         // load the data
         //
         [self loadData];
         error = nil;
         
     } else {
         NSLog(@"DB found");
     }
  }

//
// Loads the  data from a csv file to prime the database. Only needs to be done once, ever.
//
-(void)loadData {

     NSManagedObjectContext *context = [self managedObjectContext];
     NSError *error = nil;
         
     //
     // Load the threads
     //
         NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"beads" ofType:@"csv"];
         NSStringEncoding encoding = NSASCIIStringEncoding;
     
         if(filePath) {
             NSString *drugData = [NSString stringWithContentsOfFile:filePath encoding:encoding error:&error];
             NSScanner *scanner = [NSScanner scannerWithString:drugData];
             NSScanner *lineScanner;
             NSString *line;
             NSCharacterSet *commaSet = [NSCharacterSet characterSetWithCharactersInString:@","];
     
     //
     // The parsed data
     //
             NSString *brand;
             NSString *flossID;
             NSString *description;
             NSString *group;
     
             int i = 0;
             while(![scanner isAtEnd]) {
     //
     // get next line
     //
                 [scanner scanUpToCharactersFromSet:[NSCharacterSet newlineCharacterSet] intoString:&line];
                 lineScanner = [NSScanner scannerWithString:line];
     
     //
     // parse the line
     //
                 [lineScanner scanUpToCharactersFromSet:commaSet  intoString:&brand];
                 [lineScanner scanString:@"," intoString:NULL];
                 [lineScanner scanUpToCharactersFromSet:commaSet  intoString:&flossID];
                 [lineScanner scanString:@"," intoString:NULL];
                 [lineScanner scanUpToCharactersFromSet:commaSet  intoString:&description];
                 [lineScanner scanString:@"," intoString:NULL];
                 [lineScanner scanUpToCharactersFromSet:[NSCharacterSet newlineCharacterSet]  intoString:&group];
     
     //
     // store the data into DB
     //
                 FlossDB *floss = [NSEntityDescription
                                   insertNewObjectForEntityForName:@"Floss" inManagedObjectContext:context];
                 [floss setBrand:brand];
                 [floss setPrimaryLabel:flossID];
                 [floss setId:flossID];
                 [floss setDetailedLabel:description];
         
                 NSString *suffix = @".jpg";
      
                 NSString *fileName = [NSString stringWithFormat:@"%@%@",flossID, suffix];

                 [floss setFileName:fileName];
                 [floss setGroup:[NSNumber numberWithInt:[group intValue]]];
                 [floss setQuantity:[NSNumber numberWithInt:0]];
                 [floss setShoppingQuantity:[NSNumber numberWithInt:0]];
                 [floss setSort:[NSNumber numberWithInt:flossID.intValue]];
     
                 if(![context save:&error]) {
                     NSLog(@"Error - Could not save: %@",[error localizedDescription]);
                 }
     
     //
     // Update count
     //
                 i++;
             }
         NSLog(@"%d floss records loaded",i);
         }
         
    //
    // Now load the categories
    //
         filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"brand" ofType:@"csv"];
     
         if(filePath) {
             NSString *drugData = [NSString stringWithContentsOfFile:filePath encoding:encoding error:&error];
             NSScanner *scanner = [NSScanner scannerWithString:drugData];
             NSScanner *lineScanner;
             NSString *line;
             NSCharacterSet *commaSet = [NSCharacterSet characterSetWithCharactersInString:@","];
     
     //
     // The parsed data
     //
             NSString *brand;
             NSString *group;
             NSString* name;
     
             int i = 0;
             while(![scanner isAtEnd]) {
     //
     // get next line
     //
                 [scanner scanUpToCharactersFromSet:[NSCharacterSet newlineCharacterSet] intoString:&line];
                 lineScanner = [NSScanner scannerWithString:line];
     
     //
     // parse the line
     //
                 [lineScanner scanUpToCharactersFromSet:commaSet  intoString:&brand];
                 [lineScanner scanString:@"," intoString:NULL];
                 [lineScanner scanUpToCharactersFromSet:commaSet  intoString:&group];
                 [lineScanner scanString:@"," intoString:NULL];
                 [lineScanner scanUpToCharactersFromSet:[NSCharacterSet newlineCharacterSet]  intoString:&name];
     
     //
     // store the data into DB
     //
                BrandDB *branddb = [NSEntityDescription
                                    insertNewObjectForEntityForName:@"Brand" inManagedObjectContext:context];
                 [branddb setBrand:brand];
                 [branddb setName:name];
                 [branddb setGroup:[NSNumber numberWithInt:[group intValue]]];
     
                 if(![context save:&error]) {
                     NSLog(@"Error - Could not save: %@",[error localizedDescription]);
                 }
     
     //
     // Update count
     //
                 i++;
     
             }
             NSLog(@"%d category records loaded",i);
    //
    // Set the system data
    //
             self.localSystem = [NSEntityDescription
                                 insertNewObjectForEntityForName:@"System" inManagedObjectContext:context];
             [self.localSystem setUpdated:[NSNumber numberWithBool:false]];
             [self.localSystem setVersion:[NSNumber numberWithInt:5]];
             self.localSystem.last_update = [NSDate date];
             self.localSystem.last_device = [UIDevice currentDevice].name;
             
             if(![context save:&error]) {
                 NSLog(@"Error - Could not save: %@",[error localizedDescription]);
             }
         }
     }

@end
