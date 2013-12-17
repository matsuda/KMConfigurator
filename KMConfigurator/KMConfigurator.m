//
//  KMConfigurator.m
//  KMConfigurator
//
//  Created by Kosuke Matsuda on 2013/07/04.
//  Copyright (c) 2013年 matsuda. All rights reserved.
//

#import "KMConfigurator.h"

NSString * kKMConfiguratorEnvironmentDefault = @"default";

@implementation KMConfigurator {
    NSMutableDictionary *_config;
}

- (id)init
{
    return [self initWithEnvironment:kKMConfiguratorEnvironmentDefault];
}

- (id)initWithEnvironment:(NSString *)environment
{
    self = [super init];
    if (self) {
        self.environment = environment;
    }
    return self;
}

- (NSDictionary *)config
{
    if (!_config) {
        [self loadConfig];
    }
    return _config;
}

- (void)setEnvironment:(NSString *)environment
{
    if (_environment != environment) {
        _environment = [environment copy];
        [self loadConfig];
    }
}

- (id)valueForKey:(NSString *)key
{
    return [self.config valueForKey:key];
}

- (void)loadConfig
{
    if ([self.environment isEqualToString:kKMConfiguratorEnvironmentDefault]) {
        _config = [[NSDictionary dictionaryWithDictionary:[self defaultConfiguration]] mutableCopy];
    } else {
        _config = [[NSDictionary dictionaryWithDictionary:[self customConfiguration]] mutableCopy];
    }
}

- (NSMutableDictionary *)defaultConfiguration
{
    NSMutableDictionary *config = [NSMutableDictionary dictionary];
    return [self configurationWithConfiguration:config forEnvironment:kKMConfiguratorEnvironmentDefault];
}

- (NSMutableDictionary *)customConfiguration
{
    NSMutableDictionary *config = [self defaultConfiguration];
    return [self configurationWithConfiguration:config forEnvironment:self.environment];
}

- (NSMutableDictionary *)configurationWithConfiguration:(NSMutableDictionary *)configuration forEnvironment:(NSString *)environment
{
    NSDictionary *dict = [[self class] configurationPlist];
    NSDictionary *env = dict[environment];
    if (env) {
        // overwrite per enviroment
        for (NSString *key in env) {
            [configuration setObject:env[key] forKey:key];
        }
    }
    return configuration;
}

+ (NSDictionary *)configurationPlist
{
    NSString *path = [[NSBundle mainBundle] pathForResource:[self configurationFileName] ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    // NSLog(@"plist >>>>> %@", dict);
    return dict;
}

+ (NSString *)configurationFileName
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
    return nil;
}

@end
