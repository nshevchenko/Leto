//
//  Feed.h
//  Leto
//
//  Created by Shevchenko Nik on 10/08/2015.
//  Copyright (c) 2015 Shevchenko Nik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Feed : NSObject

@property (strong, nonatomic) NSString* title;

- (id) initWithTitle:(NSString*)title;

@end
