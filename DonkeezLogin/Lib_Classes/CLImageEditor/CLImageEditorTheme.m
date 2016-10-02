

#import "CLImageEditorTheme.h"

@implementation CLImageEditorTheme

#pragma mark - singleton pattern

static CLImageEditorTheme *_sharedInstance = nil;

+ (CLImageEditorTheme*)theme
{
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[CLImageEditorTheme alloc] init];
    });
    return _sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (_sharedInstance == nil) {
            _sharedInstance = [super allocWithZone:zone];
            return _sharedInstance;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}
//
//- (id)init
//{
//    self = [super init];
//    if (self) {
//        self.bundleName                     = @"CLImageEditor";
//        self.backgroundColor                = [UIColor whiteColor];
//        self.toolbarColor                   = [UIColor colorWithWhite:1 alpha:0.8];
//		self.toolIconColor                  = @"black";
//        self.toolbarTextColor               = [UIColor blackColor];
//        self.toolbarSelectedButtonColor     = [[UIColor cyanColor] colorWithAlphaComponent:0.2];
//        self.toolbarTextFont                = [UIFont systemFontOfSize:10];
//        self.statusBarStyle                 = UIStatusBarStyleDefault;
//    }
//    return self;
//}

//- (id)init
//{
//    self = [super init];
//    if (self) {
//        self.bundleName                     = @"CLImageEditor";
//        self.backgroundColor                = [UIColor blackColor];
//        self.toolbarColor                   = [UIColor blackColor];
//        self.toolIconColor                  = @"inv";
//        self.toolbarTextColor               = [UIColor grayColor];
//        self.toolbarSelectedButtonColor     = [[UIColor cyanColor] colorWithAlphaComponent:0.2];
//        self.toolbarTextFont                = [UIFont systemFontOfSize:10];
//        self.statusBarStyle                 = UIStatusBarStyleDefault;
//    }
//    return self;
//}

- (id)init
{
    self = [super init];
    if (self) {
        self.bundleName                     = @"CLImageEditor";
        self.backgroundColor                = [UIColor blackColor];
        self.toolbarColor                   = [UIColor blackColor];
        self.toolIconColor                  = @"grey";
        self.toolbarTextColor               = [UIColor grayColor];
        self.toolbarSelectedButtonColor     = [[UIColor cyanColor] colorWithAlphaComponent:0.2];
        self.toolbarTextFont                = [UIFont systemFontOfSize:10];
        self.statusBarStyle                 = UIStatusBarStyleDefault;
    }
    return self;
}
@end