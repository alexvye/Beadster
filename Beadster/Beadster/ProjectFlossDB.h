//
//  ProjectFlossDB.h
//  Beadster
//
//  Created by Alex Vye on 2014-12-10.
//  Copyright (c) 2014 Alex Vye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ProjectDB;

@interface ProjectFlossDB : NSManagedObject

@property (nonatomic, retain) NSString * brand;
@property (nonatomic, retain) NSString * detailedLabel;
@property (nonatomic, retain) NSString * fileName;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * primaryLabel;
@property (nonatomic, retain) NSString * project;
@property (nonatomic, retain) NSNumber * quantity;
@property (nonatomic, retain) ProjectDB *projectRel;

@end
