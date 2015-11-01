//
//  WindowController.m
//  Space Saver
//
//  Created by Justin Oakes on 10/12/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import "WindowController.h"
#import "MainViewController.h"
#import "constants.h"

@interface WindowController ()


@end

@implementation WindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    MainViewController *vc = (MainViewController *) self.contentViewController;
    self.delegate = vc;
}



- (IBAction)removeToolbarItemPressed:(id)sender {
    [self.delegate removeButtonPushedInMode:kDeleteMode];
}

- (IBAction)resetToolBarItemPressed:(id)sender {
    [self.delegate removeButtonPushedInMode:kResetMode];
}


@end
