//
//  AppDelegate.m
//  Space Saver
//
//  Created by Justin Oakes on 9/7/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import "AppDelegate.h"
#import "AppsController.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize windowController;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [AppsController sharedInstance];
}

-(void)applicationDidBecomeActive:(NSNotification *)notification {
    self.authController = [[AutherizationController alloc] init];
    
    if ([self.authController appIsRegistered]) {
        NSLog(@"YES");
    } else {
        MainViewController *mainView = (MainViewController *)[[[NSApplication sharedApplication] mainWindow] contentViewController];
        [mainView performSegueWithIdentifier:@"register" sender:self.windowController];
    }
}

- (IBAction)refreshApps:(id)sender {
    [[AppsController sharedInstance] findAllApplications];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

-(BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag {
    if (flag) {
        return NO;
    } else {
        NSStoryboard *sb = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
        windowController = [sb instantiateControllerWithIdentifier:@"window"];
        [windowController showWindow:self];
        return YES;
    }
}

@end
