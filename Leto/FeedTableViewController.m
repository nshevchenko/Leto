//
//  FeedTableViewController.m
//  Leto
//
//  Created by Shevchenko Nik on 10/08/2015.
//  Copyright (c) 2015 Shevchenko Nik. All rights reserved.
//

#import "FeedTableViewController.h"

@interface FeedTableViewController ()

@end

@implementation FeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // init the feeds array
    _feedsArray = [[NSMutableArray alloc] init];

    // move table by 50 px
    [self.tableView setContentInset:UIEdgeInsetsMake(50,0,0,0)];
    
    NSURL *url = [NSURL URLWithString:@"http://www.fandango.com/rss/newmovies.rss"];

    _feedParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [_feedParser setDelegate:self];
    [_feedParser parse];
    
}

- (NSMutableArray*) sortFeedArray {
    NSArray *sortedArray = [_feedsArray sortedArrayUsingComparator:^NSComparisonResult(Feed *feed1, Feed *feed2){
        return [feed1.title compare:feed2.title];
    }];
    return sortedArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_feedsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* identifier = @"feedCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    Feed* feed = [_feedsArray objectAtIndex:(int)indexPath.row];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = feed.title;
//    NSLog(@"%@", feed.title);
    return cell;
}


// NSXML PARSING DELEGATES

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    _currentElement = elementName;
    if ([elementName isEqualToString:@"item"]) {
        _creatingFeed = [[Feed alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([_currentElement isEqualToString:@"title"]) {
        _creatingFeed.title = string;
    }
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"item"]) {
        [_feedsArray addObject:_creatingFeed];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    _feedsArray = [self sortFeedArray];
    [_feedTableView reloadData];
    
    NSLog(@"%i", (int)[_feedsArray count]);
}

@end
