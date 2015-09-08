//
//  AppsController.m
//  Space Saver
//
//  Created by Justin Oakes on 9/7/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import "AppsController.h"
#import <Cocoa/Cocoa.h>
#import "constants.h"

static NSString *const kApplicationPath = @"/Applications/";

@interface AppsController()

@property (strong, nonatomic) NSMutableArray<Application *> *apps;

@end

@implementation AppsController


+ (instancetype) sharedInstance {
    static AppsController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AppsController alloc] init];
        [sharedInstance findAllApplications];
    });
    return sharedInstance;
}


- (void)findAllApplications {
    _apps = [[NSMutableArray alloc] init];
    NSArray *applications = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:kApplicationPath error:nil];
    for (NSString *name in applications) {
        if ([name containsString:@".app"]) {
            NSString *appPath = [kApplicationPath stringByAppendingString:name];
            NSString *infoPlistPath = [appPath stringByAppendingString:@"/Contents/info.plist"];
            
            NSDictionary *dictionaryForPlist = [[NSDictionary alloc] initWithContentsOfFile:infoPlistPath];
            NSString *bundelID = dictionaryForPlist[@"CFBundleIdentifier"];
            
            NSString *iconPath = [appPath stringByAppendingString:[NSString stringWithFormat:@"/Contents/Resources/%@", dictionaryForPlist[@"CFBundleIconFile"]]];
            if (![iconPath containsString:@".icns"]) {
                iconPath = [iconPath stringByAppendingString:@".icns"];
            }
            NSImage *iconImage = [[NSImage alloc] initWithContentsOfFile:iconPath];
            
            
            long long size = [self folderSize:appPath];
            NSLog(@"%@ %lld", name, size);
            Application *basicApplication = [Application applicationWithName:name Path:appPath BundelIdentifier:bundelID icon:iconImage AndSize:size];
            [self.apps addObject:basicApplication];
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kUpdatedAppsArrayNotification object:nil];
}

- (unsigned long long int)folderSize:(NSString *)folderPath {
    NSArray *filesArray = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:folderPath error:nil];
    NSEnumerator *filesEnumerator = [filesArray objectEnumerator];
    NSString *fileName;
    unsigned long long int fileSize = 0;
    
    while (fileName = [filesEnumerator nextObject]) {
        NSDictionary *fileDictionary = [[NSFileManager defaultManager] attributesOfItemAtPath:folderPath error:nil];
        fileSize += [fileDictionary fileSize];
    }
    return [[NSNumber numberWithLongLong:fileSize] floatValue];
}

@end
