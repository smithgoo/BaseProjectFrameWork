//
//  RSADataSigner.h
//  SafepayService
//
//  Created by wenbi on 11-4-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataSigner.h"

@interface RSADataSigner : NSObject <DataSigner> {
	NSString * _privateKey;
}

- (id)initWithPrivateKey:(NSString *)privateKey;
//该签名方法仅供参考,外部商户可用自己方法替换
- (NSString *)signString:(NSString *)string;
@end
