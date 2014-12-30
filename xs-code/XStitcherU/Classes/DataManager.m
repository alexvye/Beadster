//
//  DataManager.m
//  XFloss
//
//  Created by Alex Vye on 10-08-05.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DataManager.h"
#import <CoreData/CoreData.h>
#import "FlossDB.h"
#import "XFlossAppDelegate.h"
#import "System.h"
#import "BrandDB.h"

NSMutableArray *groups;
NSMutableArray *floss;
NSMutableArray *shoppingList;
NSMutableDictionary *flossQuantity;

NSPersistentStoreCoordinator* persistentStoreCoordinator;

@implementation DataManager

static DataManager* _instance = nil;


+(DataManager*)instance

{
    @synchronized (_instance)
    {
        if ( !_instance || _instance == NULL )
        {
            // allocate the shared instance, because it hasn't been done yet
            _instance = [[DataManager alloc] init];
        }
        
        return _instance;
    }
}

////////////////////////////////
// cell routines
////////////////////////////////

-(void)saveShopping:(id)floss {
    //
    // increment
    //
    FlossDB* saveFloss = (FlossDB*)floss;
    saveFloss.shoppingQuantity = [NSNumber numberWithInt:saveFloss.shoppingQuantity.intValue+1];
    
    //
    // Save
    //
    XFlossAppDelegate *appDelegate = (XFlossAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSError *error;
    if(![appDelegate.managedObjectContext save:&error]) {
        NSLog(@"Error %@", [error localizedDescription]);
    }
}

-(void)saveQuantity:(id)floss {
    //
    // Save
    //
    XFlossAppDelegate *appDelegate = (XFlossAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSError *error;
    if(![appDelegate.managedObjectContext save:&error]) {
        NSLog(@"Error %@", [error localizedDescription]);
    }
}

- (BOOL) anyProjects {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    XFlossAppDelegate *appDelegate = (XFlossAppDelegate *)[[UIApplication sharedApplication] delegate];
    [request setEntity: [NSEntityDescription entityForName: @"Project" inManagedObjectContext: appDelegate.managedObjectContext]];
    
    NSError *error = nil;
    NSUInteger count = [appDelegate.managedObjectContext countForFetchRequest: request error: &error];
    
    if(count == 0) {
        return FALSE;
    } else {
        return TRUE;
    }
}

-(NSArray*)loadProjects {
    XFlossAppDelegate *appDelegate = (XFlossAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = appDelegate.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Project" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"name" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSError *error = nil;
    NSArray* projects = [moc executeFetchRequest:request error:&error];
    
    return projects;
}

//
// clean up memory
//
- (void)dealloc {
}
			  
@end
