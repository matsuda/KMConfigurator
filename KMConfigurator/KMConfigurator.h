//
//  KMConfigurator.h
//  KMConfigurator
//
//  Created by Kosuke Matsuda on 2013/07/04.
//  Copyright (c) 2013年 matsuda. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *kKMConfiguratorEnvironmentDefault;

@interface KMConfigurator : NSObject

@property (nonatomic, copy) NSString *environment;
@property (nonatomic, readonly) NSDictionary *config;

- (id)initWithEnvironment:(NSString *)environment;

@end

@interface KMConfigurator (Protected)

+ (NSString *)configurationFileName;

@end
