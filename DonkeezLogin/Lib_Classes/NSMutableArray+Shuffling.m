//  NSMutableArray_Shuffling.h



//  NSMutableArray_Shuffling.m

#import "NSMutableArray+Shuffling.h"

@implementation NSMutableArray (Shuffling)

- (void)shuffle
{
    
    static BOOL seeded = NO;
    if(!seeded)
    {
        seeded = YES;
        srandom((uint)time(NULL));
    }
    
    NSUInteger count = [self count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        int nElements = (int)(count - i);
        int n = (int)((random() % nElements) + i);
        [self exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

@end