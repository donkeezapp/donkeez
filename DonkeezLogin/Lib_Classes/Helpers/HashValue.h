

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

#define HASH_VALUE_STORAGE_SIZE 48
#define kPPValue   @"value"

typedef struct
{
	char value[CC_SHA256_DIGEST_LENGTH];
} HashValueShaHash;

typedef struct
{
	char value[CC_MD5_DIGEST_LENGTH];
} HashValueMD5Hash;

typedef enum
{
	HASH_VALUE_MD5_TYPE,
	HASH_VALUE_SHA_TYPE
} HashValueType;

@interface HashValue : NSObject <NSCoding, NSCopying>
{
	unsigned char value[HASH_VALUE_STORAGE_SIZE];
	HashValueType type;
}

- (id)initWithBuffer:(const void *)buffer hashValueType:(HashValueType)aType;
- (id)initHashValueMD5HashWithBytes:(const void *)bytes length:(NSUInteger)length;
+ (HashValue *)md5HashWithData:(NSData *)data;
+ (HashValue *)md5HashWithString:(NSString*) string;
- (id)initSha256HashWithBytes:(const void *)bytes length:(NSUInteger)length;
+ (HashValue *)sha256HashWithData:(NSData *)data;

- (const void *)value;
- (HashValueType)type;

@end
