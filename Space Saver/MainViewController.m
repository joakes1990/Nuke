//
//  ViewController.m
//  Space Saver
//
//  Created by Justin Oakes on 9/7/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import "MainViewController.h"
#import "ApplicationCell.h"
#import "AppsController.h"
#import "Application.h"
#import "constants.h"

@interface MainViewController() <NSTableViewDataSource, NSTableViewDelegate>

@property (strong) IBOutlet NSTableView *tableView;
@property (strong) IBOutlet NSProgressIndicator *spinner;
@property (strong) IBOutlet NSView *populationView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTable) name:kUpdatedAppsArrayNotification object:nil];
    [self.spinner startAnimation:nil];
    }

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [[AppsController sharedInstance].apps count];
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    if ([tableColumn.identifier isEqualToString:@"cell"]) {
        ApplicationCell *cell = [tableView makeViewWithIdentifier:@"cell" owner:self];
        cell.nameLabel.stringValue = [AppsController sharedInstance].apps[row].name;
        cell.appIcon.image = [AppsController sharedInstance].apps[row].icon;
        return cell;
    }
        return nil;
}

-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 80;
}

- (void) updateTable {
    [self.tableView reloadData];
    [self.populationView removeFromSuperview];
}
@end
