//
//  CheckMarksSingleton.m
//  KumonApp
//
//  Created by malena mesarina on 3/3/14.
//  Copyright (c) 2014 malena mesarina. All rights reserved.
//

#import "CheckMarksSingleton.h"

@implementation CheckMarksSingleton

//@synthesize correctCheckmarksDic;

+(CheckMarksSingleton*) singleObj {
		
	static dispatch_once_t once;
    static CheckMarksSingleton *_instance;
    dispatch_once(&once, ^ { _instance = [self new]; });
    return _instance;
	
}

- (id)init {
    self = [super init];
    if (self) {
        self.correctCheckmarksDic = [[NSMutableDictionary alloc] init];
    }
	
    return self;
}

@end
