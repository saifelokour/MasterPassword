/**
* Copyright Maarten Billemont (http://www.lhunath.com, lhunath@lyndir.com)
*
* See the enclosed file LICENSE for license information (LGPLv3). If you did
* not receive this file, see http://www.gnu.org/licenses/lgpl-3.0.txt
*
* @author   Maarten Billemont <lhunath@lyndir.com>
* @license  http://www.gnu.org/licenses/lgpl-3.0.txt
*/

//
//  MPAlgorithmV3
//
//  Created by Maarten Billemont on 13/01/15.
//  Copyright 2015 lhunath (Maarten Billemont). All rights reserved.
//

#import "MPAlgorithmV3.h"
#import "MPEntities.h"

@implementation MPAlgorithmV3

- (MPAlgorithmVersion)version {

    return MPAlgorithmVersion3;
}

- (BOOL)tryMigrateSite:(MPSiteEntity *)site explicit:(BOOL)explicit {

    if ([site.algorithm version] != [self version] - 1)
        // Only migrate from previous version.
        return NO;

    if (!explicit) {
        if (site.type & MPSiteTypeClassGenerated &&
            site.user.name.length != [site.user.name dataUsingEncoding:NSUTF8StringEncoding].length) {
            // This migration requires explicit permission for types of the generated class.
            site.requiresExplicitMigration = YES;
            return NO;
        }
    }

    // Apply migration.
    site.requiresExplicitMigration = NO;
    site.algorithm = self;
    return YES;
}

@end
