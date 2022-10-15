//
//  Configuration.h
//  SampleAppObjC
//
//  Created by Pallab Maiti on 15/10/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Configuration : NSObject

@property () NSString *DATA_PLANE_URL_LOCAL;
@property () NSString *DATA_PLANE_URL_PROD;
@property () NSString *CONTROL_PLANE_URL;
@property () NSString *WRITE_KEY;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithDATA_PLANE_URL_LOCAL:(NSString *)DATA_PLANE_URL_LOCAL DATA_PLANE_URL_PROD:(NSString *)DATA_PLANE_URL_PROD CONTROL_PLANE_URL:(NSString *)CONTROL_PLANE_URL WRITE_KEY:(NSString *)WRITE_KEY;

@end

NS_ASSUME_NONNULL_END
