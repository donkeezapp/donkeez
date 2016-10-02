#import "ZMUITextField.h"
#import "UIView+BorderSet.h"
#import "UIButton+Actvity.h"
#import "UIView+Toast.h"
#import "UIImage+Resize.h"
#import <SVProgressHUD/SVProgressHUD.h>
//#import <MRProgress/MRProgress.h>
#import "MCLocalization.h"
#import "NSData+Conversion.h"
#import "UIImage+WithColor.h"
#import "CAPSPageMenu.h"
#import "UIImageView+MHNetworking.h"
#import "SocialPostManager.h"
#import "Annotation.h"
#import "SlideNavigationController.h"
#import "CYAnimation.h"
#import "YXSpritesLoadingView.h"
#import "UserInfo.h"
#import "UIImage+Utility.h"

#define NLCString(str) NSLocalizedString(str, str)

#define myRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255. green:(g)/255. blue:(b)/255. alpha:(a)/255.]
//#define NAVBAR_HEIGHT 80
#define Color_bar myRGBA(	0,145,234,255)
#define Color_bar_hilighted myRGBA(	221,63,63,255)
#define Color_MainFore myRGBA(255,255,255,255)
#define Color_NavBar myRGBA(255,240,85 ,255)

#define Color_Slider myRGBA(103, 71, 209,255)
#define Color_Grey myRGBA(200, 200, 200,255)
#define Color_Lighter_Grey myRGBA(240, 239, 245,255)

#define Color_btn_white myRGBA(254,254,254,255)

#define BD_MAIN_BACK_COLOR myRGBA(143,30,118,255)

#define BD_HILIGHTED_BAR_COLOR myRGBA(0xec,0xf0,0xf1,255)
#define BD_HILIGHTED_MAIN_COLOR myRGBA(216,181,201,240)
#define CLEAR_COLOR [UIColor clearColor]
#define BD_POPVIEW_BACK_COLOR myRGBA(181,80,140,255)

#define SB_VIEW_CORNER_RADIUS 5.f


#define METERS_PER_MILE 1609.344


#define NOTI_DIDREGISTER_DEVICETOKEN @"NOTI_DIDREGISTER_DEVICETOKEN"
#define NOTIFICATION_DEVICEREG @"NOTIFICATION_DEVICEREG"
#define NOTI_USER_ACCEPT @"NOTI_USER_ACCEPT"
#define NOTI_RELOAD @"NOTI_RELOAD"
#define NOTI_PAGESEL_1 @"NOTI_PAGESEL_1"
#define NOTI_PAGESEL_2 @"NOTI_PAGESEL_2"
#define NOTI_PAGESEL_3 @"NOTI_PAGESEL_3"

#define NOTI_main_view @"NOTI_main_view"


#define isiPadDevice  [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad
//thread
#define MCLocalString(strval) [MCLocalization stringForKey:strval]

#define MAINTHREAD(block) if((block)) { dispatch_async(dispatch_get_main_queue(), block ); }
#define LOCALSTRING(str) [MCLocalization stringForKey: str ]

#define AlertViewWithMSG(msg) [[[UIAlertView alloc]initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
#define AlertViewWithTitleMSG(title, msg) [[[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
#define ToastView(view, msg)     [view makeToast:msg duration:1.5 position:CSToastPositionCenter image:nil];

#define StatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height

#define PNG_RIGHT @"Arrow.png"
#define PNG_DOWN @"Arrow2.png"
#define PNG_LEFT @"Arrow3.png"
#define PNG_MORE @"more.png"
#define PNG_ADD @"add.png"
#define PNG_PROFILE [UIImage imageNamed:@"Foto2"]

#define PATH_TO_PHOTO ([[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSAllDomainsMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"profilephoto.jpg"])


//#define test_server @"http://170.170.1.150/beauty_date_app/index.php"
#define test_server @"http://www.beauty-date.com/app/index.php"


#define Url_Get_Company_Data  [NSString stringWithFormat:@"%@%@", test_server,  @"/company/get_company_data"]


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

typedef enum {
    TabSearch = 1,
    TabHistory = 2,
    TabFavorite = 3,
    TabForum = 4
} Tab;

static inline bool isSet(NSString * _Nullable str){
    
    @try {
        if([str isKindOfClass:[NSNull class]] || str.length == 0 || str == nil || [str isEqualToString: @""]){
            return NO;
        }
    }
    @catch (NSException *exception) {
        return NO;
    }
    
    return YES;
}



static inline void MyLogRect(CGRect rect,NSString * _Null_unspecified  msg)
{
    NSLog(@"//----------  %@  CGRect by zm software ----------",msg);
    NSLog(@"Rect's x %f,y %f,w %f,h %f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
    NSLog(@"//--------------- end ----------------");
    
   
}
@interface GlobalDefine : NSObject

+ (NSString * _Nonnull) md5:(NSString * _Null_unspecified) input;
//+(void)ShowLoaderWithView:(UIView* _Null_unspecified)view;


+(void)DefButton:(UIView  * _Nonnull)view;

+(void)SetDropButton:(UIButton* _Nonnull)btn imgName:(NSString* _Nonnull)name;
#pragma mark - imagerelation
+(NSString * _Nonnull)getDuringofDate:(NSDate * _Nonnull)date1;
+ (UIImage * _Nonnull)imageWithColor:(UIColor * _Nonnull)color withFrame:(CGRect)rect;
+ (UIImage * _Nonnull) imageWithView:(UIView * _Nonnull)view;
+ (UIImage * _Nonnull)captureView:(UIView * _Nonnull)view withArea:(CGRect)screenRect;
//+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage * _Nonnull)navbarImageWithBarColor:(UIColor * _Nonnull)color
                         StatusColor:(UIColor* _Nonnull)statusBarColor withFrame:(CGRect)rect;
+(void)SaveAvatar:(UIImage* _Nonnull)object;
+(UIImage * _Nonnull)GetAvatar;
+(void)WriteImageDefaultStore:(UIImage* _Null_unspecified)object forKey:(nonnull NSString *)key;
+(void)WriteDefaultStore:(id _Nonnull)object forKey:(NSString * _Nonnull)key;
+(id _Nonnull) ReadImageDefaultStoreforKey:(nonnull NSString *)key;
+(id _Nonnull)ReadDefaultStoreforKey:(nonnull NSString *)key;
+(void)LocalAvatarSet:(UIImageView* _Nonnull)imgView place:(NSString* _Nonnull)placeName key:(NSString* _Nonnull)key;

//+(void)ShowLoader:(UIView* _Nonnull)view;
//+(void)HideLoader;

+(void)showSVHUD;
+(void)hideSV;
+(void)showSVHUDMask:(BOOL)isMasked;

+(UIActivityIndicatorView* _Nonnull)activityViewToView:(UIView* _Nonnull) view;
+ (void)setRounded:(UIView * _Nonnull)view borderColor:(UIColor * _Nonnull)borderColor backgroundColor:(UIColor * _Nonnull)backgroundColor Radius:(CGFloat)R;
+ (UIImage * _Nonnull)imageWithColor:(UIColor * _Nonnull)color;
+(void)addBorderLayerToImageView:(UIImageView* _Nonnull)imageView radius:(CGFloat)kCornerRadius width:(CGFloat)kBorderWidth  color:(UIColor* _Nonnull)color;
+(void)AddImageToButtonLeft:(UIButton* _Nonnull)button XOffset:(CGFloat)xOffset YOffset:(CGFloat)yOffset imageName:(NSString* _Nonnull)imgName;
+(void)AddImageToButtonRight:(UIButton* _Nonnull)button XOffset:(CGFloat)xOffset YOffset:(CGFloat)yOffset imageName:(NSString* _Nonnull)imgName;
+(CGRect) getStringSize:(NSString* _Nonnull)myString lineBreakMode:(NSLineBreakMode)lineBreakMode font:(UIFont* _Nonnull)myFont;
+(void)SetNormalButton:(UIButton* _Nonnull)button BorderWitdh:(CGFloat)borderW Radius:(CGFloat)R Title:(NSString* _Nonnull)title FontSize:(CGFloat)fontSize ImgName:(NSString* _Nonnull)imgName ImgXOffset:(CGFloat)xOffset ImgYOffset:(CGFloat)yOffset toLeft:(BOOL)isLeft isOnBar:(BOOL)isBar;
+(void)SetNormalTextField:(UITextField*_Nonnull)txt BorderWitdh:(CGFloat)borderW Radius:(CGFloat)R placeHolder:(NSString* _Nonnull)placeholder FontSize:(CGFloat)fontSize borderColor:(UIColor*_Nonnull)brdColor;
+(void)SetZMUITextField:(ZMUITextField* _Nonnull)txt BorderWitdh:(CGFloat)borderW Radius:(CGFloat)R placeHolder:(NSString* _Nonnull)placeholder FontSize:(CGFloat)fontSize;
+(void)setButton:(UIButton* _Nonnull)button  Image:(NSString* _Nonnull)imgName toLeft:(BOOL)isLeft ImgXOffset:(CGFloat)xOffset ImgYOffset:(CGFloat)yOffset  title:(NSString* _Nonnull)title;
+(NSArray *_Nonnull) getCityList;

+ (void)makeCornerRadius:(UIView * _Nonnull)view Radius:(CGFloat)radius borderColor:(UIColor *_Nonnull)borderColor backgroundColor:(UIColor * _Nonnull)backgroundColor;
+(void)phoneCall:(NSString* _Nonnull)phoneNumber;



//#pragma mark - String & NSDictionary relation

+(NSString * _Nonnull)getStringFrom:(NSDictionary* _Nonnull)dict forKey:(NSString* _Nonnull)keystr;

+(NSInteger)getIntFrom:(NSDictionary* _Nonnull)dict forKey:(NSString* _Nonnull)keystr;

+(CGFloat)getFloatFrom:(NSDictionary* _Nonnull)dict forKey:(NSString* _Nonnull)keystr;

+(NSArray<NSString*> * _Nonnull)getArrFrom:(NSDictionary* _Nonnull)dict forKey:(NSString* _Nonnull)keystr sepStr:(NSString* _Nonnull)sepStr;

+(NSArray<NSDictionary*> * _Nonnull)getArrFrom:(NSDictionary* _Nonnull)dict forKey:(NSString* _Nonnull)keystr ;


// Dataformat convert

+(NSString* _Nonnull)intToString:(NSInteger)val;
+(NSString* _Nonnull)floatToString:(CGFloat)val;
+(NSString* _Nonnull)longToString:(long)val;
+(NSString* _Nonnull)doubleToString:(double)val;

+(double)StringToDouble:(NSString* _Nonnull)val;
+(CGFloat)StringToFloat:(NSString* _Nonnull)val;
+(long)StringTolong:(NSString* _Nonnull)val;
+(int)StringToInt:(NSString* _Nonnull)val;

///   Date relation
+(NSInteger)getHourFromDate:(NSDate * _Nonnull)date;
+(NSInteger)getMinutesFromDate:(NSDate* _Nonnull)date;
+(NSInteger)getSecondFromDate:(NSDate* _Nonnull)date;
+(NSInteger)getYearFromDate:(NSDate* _Nonnull)date;
+(NSInteger)getMonthFromDate:(NSDate* _Nonnull)date;
+(NSInteger)getDayFromDate:(NSDate* _Nonnull)date;
+(NSString* _Nonnull)getMonthNameWithDate:(NSDate* _Nonnull)date;
+(NSString*_Nonnull)getMonthNameinRomanian:(NSInteger)monthidx;
+(BOOL)isSameDate1:(NSDate*_Nonnull)date1 Date2:(NSDate* _Nonnull)date2;
+(NSArray* _Nonnull)getHolidayListByYear:(NSInteger)year;
//+(NSString*)getDescriptionHoliday:(NSDate*)date;
+(NSArray* _Nonnull)getHolidayListByMonth:(NSInteger)month Year:(NSInteger)year;
+(NSInteger)isEarlierDate1:(NSDate* _Nonnull)date1 thanDate2:(NSDate* _Nonnull)date2;
+(NSDate* _Nonnull)getDateFromYear:(NSInteger)y month:(NSInteger)m day:(NSInteger)d;
+ (NSDate * _Nonnull)nextDay:(NSDate * _Nonnull)date ;
+ (NSDate * _Nonnull)prevDay:(NSDate * _Nonnull)date;
+(NSString* _Nonnull) getWhatDate:(NSDate* _Nonnull)date;
+(CGSize)GetScreenSize;

+(NSInteger)GetDayOfWeek:(NSDate*_Nonnull)date;
+(NSString* _Nonnull)getStringFromAddedMinutes:(NSInteger)minutes hour:(NSInteger)h minute:(NSInteger)m;
+(UIImage* _Nonnull) drawText:(NSString* _Nonnull) text
             inImage:(UIImage* _Nonnull)  image
             atPoint:(CGPoint)   point
           textColor:(UIColor*_Nonnull) textColor;
//+(NSString*)getStringHourMinutesFromMinutes:(NSInteger)minutes;


+(BOOL) StringIsValidEmail:(NSString * _Nullable)checkString;
+(NSAttributedString*_Nonnull)HtmlToAttributedString:(NSString* _Nonnull)htmlString;

+(void)ShowAlertViewTitle:(NSString* _Nonnull)title message:(NSString* _Nonnull)message VC:(UIViewController* _Nonnull)vc Ok:(void(^_Nullable)())okBlock;
+(void)ShowAlertYesNoTitle:(NSString* _Nonnull)title message:(NSString* _Nonnull)message VC:(UIViewController* _Nonnull)vc YESBlock:(void(^ _Nonnull)())yesBlock cancelBlock:(void(^ _Nonnull)())cancelBlock;

+(void)ShowAlertTextTitle:(NSString * _Nonnull)title message:(NSString* _Nonnull)message placeholder:(NSString * _Nullable)placeholder VC:(UIViewController* _Nonnull)vc Ok:(void(^_Nullable)(NSString * _Nonnull text))okBlock  cancelBlock:(void(^ _Nullable)())cancelBlock;
// FileManage
+(  NSArray * _Null_unspecified )ContentsOfDocumentDirectory;
+(NSString* _Null_unspecified)GetDocumentDirPath;
+(NSString* _Null_unspecified)GetFileSizePrettyFormat:(NSInteger)byte;
//+(void )showAlert:(NSString* _Null_unspecified)msg;
+(NSString* _Null_unspecified)EncodeImageToBase64String:(UIImage* _Null_unspecified)image;
+(UIImage* _Null_unspecified)DecodeBase64ToImage:(NSString* _Null_unspecified)strEncodedData;
+(void)onMain:(void(^ _Null_unspecified)())block;
@end
