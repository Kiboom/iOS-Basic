//
//  MasterViewController.m
//  MidTerm
//
//  Created by 김기범 on 2016. 4. 11..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "KBAlbumViewController.h"
#import "KBDetailViewController.h"

@interface KBAlbumViewController ()

@property NSMutableArray *objects;
@property BOOL willHideTableHeader;
@end

@implementation KBAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(sortTable:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (KBDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    self.notiCenter = [NSNotificationCenter defaultCenter];
    [self.notiCenter addObserver:self
                        selector:@selector(reloadTableView)
                            name:@"modelInitialized"
                          object:nil];
    self.model = [[KBDataModel alloc] init];
    [self.model initializeData];
    self.tableView.rowHeight = 80;
    self.willHideTableHeader = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadTableView {
    self.objects = [self.model.datas mutableCopy];
    [self.tableView reloadData];
}

- (void)sortTable:(id)sender {
    self.willHideTableHeader = NO;
    [self.notiCenter addObserver:self selector:@selector(reloadTableView) name:@"sorted" object:nil];
    [self.model sort];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if(motion == UIEventSubtypeMotionShake) {
        self.willHideTableHeader = YES;
        [self.model initializeData];
    }
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *object = self.objects[indexPath.row];
        KBDetailViewController *controller = (KBDetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSArray *years = [self.model getYearArray];
    return [years count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *years = [self.model getYearArray];
    return [self.model getNumberElementInYear:years[section]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSArray *years = [self.model getYearArray];
    int offset = 0;
    for(int i=0 ; i<indexPath.section ; i++){
        offset+=[self.model getNumberElementInYear:years[i]];
    }
    NSDictionary *object = self.objects[indexPath.row + offset];
    
    cell.titleLabel.text = [object objectForKey:@"title"];
    cell.detailLabel.text = [object objectForKey:@"date"];
    cell.background.image = [UIImage imageNamed:[object objectForKey:@"image"]];
    cell.background.contentMode = UIViewContentModeCenter;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(self.willHideTableHeader == YES) {
        return nil;
    }
    NSArray *years = [self.model getYearArray];
    return years[section];
}

@end
