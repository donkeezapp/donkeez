
#import "HashValue.h"

@implementation HashValue

- (id)initWithBuffer:(const void *)buffer hashValueType:(HashValueType)aType
{
	self = [super init];
	if (self != nil)
	{
		if (aType == HASH_VALUE_MD5_TYPE)
		{
			memcpy(value, buffer, sizeof(HashValueMD5Hash));
		}
		else if (aType == HASH_VALUE_SHA_TYPE)
		{
			memcpy(value, buffer, sizeof(HashValueShaHash));
		}
		type = aType;
	}
	return self;
}

- (id)initHashValueMD5HashWithBytes:(const void *)bytes length:(NSUInteger)length
{
	self = [super init];
	if (self != nil)
	{
		CC_MD5(bytes, (CC_LONG)length, value);
		type = HASH_VALUE_MD5_TYPE;
	}
	return self;
}

+ (HashValue *)md5HashWithData:(NSData *)data
{
	return [[HashValue alloc]
		initHashValueMD5HashWithBytes:[data bytes]
		length:[data length]]
	;
}

+ (HashValue *)md5HashWithString:(NSString*) string
{
    return [[HashValue alloc] initHashValueMD5HashWithBytes:[string UTF8String] length:strlen([string UTF8String])];
}

- (id)initSha256HashWithBytes:(const void *)bytes length:(NSUInteger)length
{
	self = [super init];
	if (self != nil)
	{
		CC_SHA256(bytes, (CC_LONG)length, value);
		type = HASH_VALUE_SHA_TYPE;
	}
	return self;
}

+ (HashValue *)sha256HashWithData:(NSData *)data
{
	return [[HashValue alloc]
		initSha256HashWithBytes:[data bytes]
		length:[data length]];
}

- (NSString *)description
{
	NSInteger byteLength = 0;
	if (type == HASH_VALUE_MD5_TYPE)
	{
		byteLength = sizeof(HashValueMD5Hash);
	}
	else if (type == HASH_VALUE_SHA_TYPE)
	{
		byteLength = sizeof(HashValueShaHash);
	}

	NSMutableString *stringValue =
		[NSMutableString stringWithCapacity:byteLength * 2];
	NSInteger i;
	for (i = 0; i < byteLength; i++)
	{
		[stringValue appendFormat:@"%02x", value[i]];
	}
	
	return stringValue;
}

- (NSUInteger)hash
{
	return *((NSUInteger *)value);
}

- (const void *)value
{
	return value;
}

- (HashValueType)type
{
	return type;
}

- (BOOL)isEqual:(id)other
{
	if ([other isKindOfClass:[HashValue class]] &&
		((HashValue *)other)->type == type &&
		memcmp(((HashValue *)other)->value, value, HASH_VALUE_STORAGE_SIZE) == 0)
	{
		return YES;
	}
	
	return NO;
}

- (id)copyWithZone:(NSZone *)zone
{
	return [[[self class] allocWithZone:zone] initWithBuffer:value hashValueType:type];
}

- (id)initWithCoder:(NSCoder *)aCoder
{
	self = [super init];
	if (self != nil)
	{
		NSData *valueData = [aCoder decodeObjectForKey:kPPValue];
		memcpy(value, [valueData bytes], [valueData length]);
		[valueData self];
		type = [aCoder decodeIntForKey:@"type"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
	[encoder
		encodeObject:[NSData dataWithBytes:value length:HASH_VALUE_STORAGE_SIZE]
		forKey:kPPValue];
	[encoder encodeInt:type forKey:@"type"];
}

@end
