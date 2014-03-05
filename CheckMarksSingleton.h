//
//  CheckMarksSingleton.h
//  KumonApp
//
//  Created by malena mesarina on 3/3/14.
//  Copyright (c) 2014 malena mesarina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckMarksSingleton : NSObject

@property(nonatomic, strong) NSMutableDictionary *correctCheckmarksDic;

+(CheckMarksSingleton*) singleObj;
@end
