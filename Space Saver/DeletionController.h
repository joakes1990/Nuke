//
//  DeletionController.h
//  Space Saver
//
//  Created by Justin Oakes on 10/19/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "Application.h"

@interface DeletionController : NSObject

- (BOOL) appIsRunning:(Application *)app;

- (void) removeComponetFromMac:(NSDictionary *)componets;

@end
