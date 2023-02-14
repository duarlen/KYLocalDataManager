
#import "KYLocalDataManager.h"

/*
 目录结构：
                1. common： 通用的数据
 LocalData →    2. user1：绑定用户 1 的
                3. user2：绑定用户 2 的
*/


// 用户本地数据 Root Key
#define LOCAL_DATA_ROOT_KEY @"UserLocalDataRootKey"

// 公共的用户数据 Key
#define Local_DATA_COMMON_USER_KEY @"Common"

@implementation KYLocalDataManager


+ (instancetype)shareInstance {
    static KYLocalDataManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[KYLocalDataManager alloc] init];
    });
    return instance;
}


#pragma mark: --- Public

// 获取数据
- (nullable id)objectForKey:(nonnull NSString *)key common:(BOOL)common {
    if (key == nil) {
        return nil;
    }
    NSDictionary *userDictionary = [self userDictionaryWithCommon:common];
    return [userDictionary objectForKey:key];
}

// 设置数据
- (void)setObject:(nonnull id)object key:(nonnull NSString *)key common:(BOOL)common {
    if (object == nil || key == nil) {
        return;
    }
    NSMutableDictionary *userDictionary = [[self userDictionaryWithCommon:common] mutableCopy];
    [userDictionary setObject:object forKey:key];
    [self updateUserDictionary:userDictionary common:common];
}


#pragma mark: --- Private: User 字典操作

// 获取用户的 Key，是否是通用数据
- (NSString *)keyForUserWithCommon:(BOOL)common {
    if (!common && self.currentUserId != nil && self.currentUserId.length > 0) {
        return self.currentUserId;
    }
    return Local_DATA_COMMON_USER_KEY;
}

// 获取用户的字典
- (NSDictionary *)userDictionaryWithCommon:(BOOL)common {
    NSString *key = [self keyForUserWithCommon:common];
    NSDictionary *rootDictionary = [self rootDictionary];
    NSDictionary *userDictionary = [rootDictionary objectForKey:key];
    if (userDictionary == nil || ![userDictionary isKindOfClass:[NSDictionary class]]) {
        userDictionary = [NSDictionary dictionary];
        [self updateUserDictionary:userDictionary common:common];
    }
    return userDictionary;
}

// 更新用户的字典
- (void)updateUserDictionary:(NSDictionary *)userDictionary common:(BOOL)common {
    if (userDictionary == nil || ![userDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSString *key = [self keyForUserWithCommon:common];
    NSMutableDictionary *rootDictionary = [[self rootDictionary] mutableCopy];
    [rootDictionary setObject:userDictionary forKey:key];
    [self updateRootDictionary:rootDictionary];
}


#pragma mark: --- Private: Root 字典操作

// 获取本地数据根字典
- (NSDictionary *)rootDictionary {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDictionary *rootDictionary = [ud objectForKey:LOCAL_DATA_ROOT_KEY];
    if (rootDictionary == nil || ![rootDictionary isKindOfClass:[NSDictionary class]]) {
        rootDictionary = [NSDictionary dictionary];
        [self updateRootDictionary:rootDictionary];
    }
    return rootDictionary;
}

// 更新本地数据根字典
- (void)updateRootDictionary:(NSDictionary *)dictionary {
    if (dictionary == nil || ![dictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:dictionary forKey:LOCAL_DATA_ROOT_KEY];
    [ud synchronize];
}

@end
