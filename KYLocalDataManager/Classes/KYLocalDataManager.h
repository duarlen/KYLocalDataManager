
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KYLocalDataManager : NSObject

/// 当前用户 ID
/// 当用户登录后设置 `用户的 id`
/// 用户退出后设置为 `nil`
@property (nullable, nonatomic, copy) NSString *currentUserId;


/// 单例初始化
+ (instancetype)shareInstance;


/// 获取数据
/// - Parameters:
///   - key: 获取数据使用的 Key
///   - common: 是否是公共数据，需要和用户绑定时设置 NO。（有些数据是需要跟用户绑定的）
- (nullable id)objectForKey:(nonnull NSString *)key common:(BOOL)common;


/// 设置数据
/// - Parameters:
///   - object: 设置的数据
///   - key: 设置数据对应的 Key
///   - common: 是否为公共数据，需要和用户绑定时设置 NO。（有些数据是需要跟用户绑定的）
- (void)setObject:(nonnull id)object key:(nonnull NSString *)key common:(BOOL)common;

@end

NS_ASSUME_NONNULL_END
