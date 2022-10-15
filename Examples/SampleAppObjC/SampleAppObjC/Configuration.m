//
//  Configuration.m
//  SampleAppObjC
//
//  Created by Pallab Maiti on 15/10/22.
//

#import "Configuration.h"

@implementation Configuration

- (instancetype)initWithDATA_PLANE_URL_LOCAL:(NSString *)DATA_PLANE_URL_LOCAL DATA_PLANE_URL_PROD:(NSString *)DATA_PLANE_URL_PROD CONTROL_PLANE_URL:(NSString *)CONTROL_PLANE_URL WRITE_KEY:(NSString *)WRITE_KEY {
    if (self = [super init]) {
        _DATA_PLANE_URL_PROD = DATA_PLANE_URL_PROD;
        _DATA_PLANE_URL_LOCAL = DATA_PLANE_URL_LOCAL;
        _CONTROL_PLANE_URL = CONTROL_PLANE_URL;
        _WRITE_KEY = WRITE_KEY;
    }
    return self;
}

@end
