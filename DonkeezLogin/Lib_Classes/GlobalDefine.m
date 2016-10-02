

#import "GlobalDefine.h"
#import <CommonCrypto/CommonDigest.h>


@implementation GlobalDefine

//static MRProgressOverlayView * mrPV;

+(CGSize)GetScreenSize{
    CGRect screenRect  = [[UIScreen mainScreen] bounds] ;
    return screenRect.size;
    // iPhone 4 320x480 = iPad Retina
    // iPhone 5 320x568
    // iPhone 6 375x667
}
+ (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}


+(NSArray *) getCityList
{
    
    return  @[@"Alba", @"Arad", @"Argeș", @"Bacău", @"Bihor", @"Bistrița-Năsăud", @"Botoșani", @"Brașov", @"Brăila", @"Buzău", @"Caraș-Severin", @"Cluj", @"Constanța", @"Covasna", @"Călărași", @"Dolj", @"Dâmbovița", @"Galați", @"Giurgiu", @"Gorj", @"Harghita", @"Hunedoara", @"Ialomiţa", @"Iași", @"Ilfov", @"Maramureș", @"Mehedinți", @"Mureș", @"Neamț", @"Olt",	@"Prahova", @"SatuMare", @"Sibiu", @"Suceava", @"Sălaj", @"Teleorman", @"Timiș", @"Tulcea", @"Vaslui", @"Vrancea", @"Vâlcea", @"Bucharest"];
}
#pragma  mark -HUD relation
+(void)showSVHUD{
    
//    [SVProgressHUD setBackgroundColor:[UIColor blackColor] ];
//    [SVProgressHUD setRingThickness:3.];
//    [SVProgressHUD setForegroundColor:Color_Slider];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
//    [SVProgressHUD show];
//    
    
    [YXSpritesLoadingView    show];
    
}
+(void)showSVHUDMask:(BOOL)isMasked{
    
//    [SVProgressHUD setBackgroundColor:[UIColor blackColor] ];
//    [SVProgressHUD setRingThickness:3.];
//    [SVProgressHUD setForegroundColor:Color_Slider];
//    
//    if(isMasked){
//        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
//    }
//    [SVProgressHUD show];
    
    [YXSpritesLoadingView show];
    
}
+(void)hideSV{
//    [SVProgressHUD dismiss];
    [YXSpritesLoadingView dismiss];
}
//
//+(void)showMrPB {
//    mrPV = [MRProgressOverlayView new];
//    mrPV.titleLabelText = @"";
//    
//    CGRect frame = mrPV.frame;
//    frame.size = CGSizeMake(50, 50);
//    [mrPV setFrame:frame];
//    [mrPV setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
//    
//    [kAppDelegate.window addSubview:mrPV];
//    [mrPV show:YES];
//    
//}
//+(void)hideMrPB{
//    [mrPV dismiss:YES];
//}


+(void)SetDropButton:(UIButton*)btn imgName:(NSString*)name{
    
    [GD SetNormalButton:btn BorderWitdh:0. Radius:0. Title:btn.titleLabel.text FontSize:15. ImgName:name ImgXOffset:0 ImgYOffset:0. toLeft:NO isOnBar:NO];
    
//    [btn addBottomBorder:Color_bar ForRect:btn.frame];
    
}

+(void)DefButton:(UIView*)view{
    
    [view setBackgroundColor:Color_bar];
    [view makeRounded:view.frame.size.height / 2.];
    [view setTintColor:[UIColor whiteColor]];
    
    
}
//+(void)ShowLoader:(UIView*)view
//{
//    [view bringSubviewToFront:[DejalBezelActivityView activityViewForView:view]];
//}
//
//+(void) HideLoader
//{
//    [DejalBezelActivityView removeViewAnimated:YES];
//}

+(UIActivityIndicatorView* )activityViewToView:(UIView*) view
{
    
    UIActivityIndicatorView* av = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    av.color = [UIColor grayColor];
    av.hidesWhenStopped=YES;
    [view addSubview:av];
    av.center = CGPointMake(view.frame.size.width*.5, view.frame.size.height*.5);
    [av startAnimating];
    return av;
    
}
//  /////
+ (void)makeCornerRadius:(UIView *)view Radius:(CGFloat)radius borderColor:(UIColor *)borderColor backgroundColor:(UIColor *)backgroundColor
{
    view.layer.cornerRadius = radius;
    view.layer.borderWidth = 1.0f;
    view.layer.borderColor = borderColor.CGColor;
    view.clipsToBounds = YES;
    view.backgroundColor = backgroundColor;
}

+ (void)setRounded:(UIView *)view borderColor:(UIColor *)borderColor backgroundColor:(UIColor *)backgroundColor Radius:(CGFloat)R
{
    if(R == -1)
        R = view.frame.size.height / 2.0f;
    view.layer.cornerRadius = R;
    view.layer.borderWidth = 1.0f;
    view.layer.borderColor = borderColor.CGColor;
    view.clipsToBounds = YES;
    view.backgroundColor = backgroundColor;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}



+(void)SetNormalTextField:(UITextField*)txt BorderWitdh:(CGFloat)borderW Radius:(CGFloat)R placeHolder:(NSString*)placeholder FontSize:(CGFloat)fontSize borderColor:(UIColor*)brdColor
{
    txt.backgroundColor=CLEAR_COLOR;
    txt.layer.borderColor=[Color_MainFore CGColor];
    txt.textColor=Color_MainFore;
//    txt.colorPlaceholder=BD_MAIN_FORE_COLOR;
    //    [GlobalDefine setPlaceHolderColorForTextField:txt Color:BD_MAIN_FORE_COLOR];
    if(R==-1)
        R = txt.frame.size.height/2.;
    
    txt.placeholder=placeholder;
    txt.font=[UIFont systemFontOfSize:fontSize];
    
    [txt setBorderForColor:brdColor width:borderW radius:R];
    
}
+(void)SetZMUITextField:(ZMUITextField*)txt BorderWitdh:(CGFloat)borderW Radius:(CGFloat)R placeHolder:(NSString*)placeholder FontSize:(CGFloat)fontSize
{
    txt.backgroundColor=CLEAR_COLOR;
    txt.layer.borderColor=[Color_bar CGColor];
    txt.textColor=Color_MainFore;
//    txt.colorPlaceholder=BD_MAIN_FORE_COLOR;
//    [GlobalDefine setPlaceHolderColorForTextField:txt Color:BD_MAIN_FORE_COLOR];
    if(R==-1)
        txt.layer.cornerRadius=txt.frame.size.height/2.;
    else
        txt.layer.cornerRadius=R;
    txt.clipsToBounds=YES;
    txt.layer.borderWidth=borderW;
    
    txt.placeholder=placeholder;
    txt.font=[UIFont systemFontOfSize:fontSize];
    
}

+(void)setButton:(UIButton*)button  Image:(NSString*)imgName toLeft:(BOOL)isLeft ImgXOffset:(CGFloat)xOffset ImgYOffset:(CGFloat)yOffset title:(NSString*)title
{
    button.tintColor=Color_MainFore;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    if(!imgName || [imgName isEqualToString:@""]){
        
    }
    else{
        if(isLeft)
            [GlobalDefine AddImageToButtonLeft:button XOffset:xOffset YOffset:yOffset imageName:imgName];
        else
            [GlobalDefine AddImageToButtonRight:button XOffset:xOffset YOffset:yOffset imageName:imgName];
    }
}

+(void)SetNormalButton:(UIButton*)button BorderWitdh:(CGFloat)borderW Radius:(CGFloat)R Title:(NSString*)title FontSize:(CGFloat)fontSize ImgName:(NSString*)imgName ImgXOffset:(CGFloat)xOffset ImgYOffset:(CGFloat)yOffset toLeft:(BOOL)isLeft isOnBar:(BOOL)isBar
{
    button.tintColor=Color_MainFore;
    button.layer.borderWidth=borderW;
    button.layer.borderColor=[Color_MainFore CGColor];
    if(R>0){
        button.layer.cornerRadius=R;
        [button setClipsToBounds:YES];
    }
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    
    [button setBackgroundColor:[UIColor clearColor]];
    
    UIColor *hicol=isBar?BD_HILIGHTED_BAR_COLOR:BD_HILIGHTED_MAIN_COLOR;
    
    
    [button setBackgroundImage:[GlobalDefine imageWithColor:hicol] forState:UIControlStateHighlighted];
    button.titleLabel.font=[UIFont systemFontOfSize:fontSize];
    
    if(!imgName || [imgName isEqualToString:@""]){
        
    }
    else{
        if(isLeft)
            [GlobalDefine AddImageToButtonLeft:button XOffset:xOffset YOffset:yOffset imageName:imgName];
        else
            [GlobalDefine AddImageToButtonRight:button XOffset:xOffset YOffset:yOffset imageName:imgName];
    }
}

+(void)addBorderLayerToImageView:(UIImageView*)imageView radius:(CGFloat)kCornerRadius width:(CGFloat)kBorderWidth color:(UIColor*)color
{
    CALayer *borderLayer = [CALayer layer];
    CGRect borderFrame = CGRectMake(0, 0, (imageView.frame.size.width), (imageView.frame.size.height));
    [borderLayer setBackgroundColor:[[UIColor clearColor] CGColor]];
    [borderLayer setFrame:borderFrame];
    
    
    if(kCornerRadius==-1)
       kCornerRadius=imageView.frame.size.width/2.;
    
    [borderLayer setCornerRadius:kCornerRadius];
    
    imageView.layer.cornerRadius=kCornerRadius;
    imageView.clipsToBounds=YES;
    [borderLayer setBorderWidth:kBorderWidth];
    [borderLayer setBorderColor:[color CGColor]];
    [imageView.layer addSublayer:borderLayer];
    
}




+(void)AddImageToButtonLeft:(UIButton*)button XOffset:(CGFloat)xOffset YOffset:(CGFloat)yOffset imageName:(NSString*)imgName
{
  
    CGRect rectTitle=[GlobalDefine getStringSize:button.titleLabel.text lineBreakMode:button.titleLabel.lineBreakMode font:button.titleLabel.font];
    
    
    CGSize sizeBtn=button.bounds.size;
    CGFloat y=(sizeBtn.height-rectTitle.size.height)/2.;
//    CGRect rectImg=CGRectMake((button.frame.size.width-rectTitle.size.width)/2.-rectTitle.size.height,yOffset , rectTitle.size.height, rectTitle.size.height);
     CGRect rectImg=CGRectMake(xOffset,y , rectTitle.size.height, rectTitle.size.height);
    
    UIImageView* btnimg=[[UIImageView alloc]initWithFrame:rectImg];
    [btnimg setImage:[UIImage imageNamed:imgName]];
    [button addSubview:btnimg];
    
    button.contentEdgeInsets=UIEdgeInsetsMake(0,btnimg.frame.size.width+xOffset*2 , 0, xOffset*2);

}

+(void)AddImageToButtonRight:(UIButton*)button XOffset:(CGFloat)xOffset YOffset:(CGFloat)yOffset imageName:(NSString*)imgName
{
    CGRect rectTitle=[GlobalDefine getStringSize:button.titleLabel.text lineBreakMode:button.titleLabel.lineBreakMode font:button.titleLabel.font];
    CGFloat imgW=rectTitle.size.height;
//    CGRect rectImg=CGRectMake(xOffset,yOffset , rectTitle.size.height, rectTitle.size.height);
    CGSize sizeBtn=button.frame.size;
    CGFloat y=(sizeBtn.height-rectTitle.size.height)/2.;
    
    CGFloat xImg=sizeBtn.width- xOffset-imgW;
    
    UIImageView* btnimg=[[UIImageView alloc]initWithFrame:CGRectMake(xImg, y ,imgW , imgW)];
    
    
    [btnimg setImage:[UIImage imageNamed:imgName]];
    [button addSubview:btnimg];
    
    button.contentEdgeInsets=UIEdgeInsetsMake(0,0 , 0, xOffset);
    
}

+(NSAttributedString*)HtmlToAttributedString:(NSString*)htmlString{
    
//    NSString * htmlString = @"<ul><li>Sure ,I am sure Physics will be depend on our life closely.</li><li>Thanks for your question</li></ul>";
    NSError *error ;
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *str = [[NSAttributedString alloc] initWithData:data
                               
                                                               options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                         NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]}
                                                    documentAttributes:nil error:&error];
    //    _txtView.scrollRangeToVisible(NSMakeRange(0, 0))
//    [_tvTest scrollRangeToVisible:NSMakeRange(0, 0)];
//    
//    [_tvTest setAttributedText:str];

    return str;
    
}

+(CGRect) getStringSize:(NSString*)myString lineBreakMode:(NSLineBreakMode)lineBreakMode font:(UIFont*)myFont
{
    CGSize maximumSize = CGSizeMake(480, 9999);

    CGRect myStringSize =[myString boundingRectWithSize:maximumSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:myFont} context:nil];
    
    return myStringSize;
}

+(void)phoneCall:(NSString*)phoneNumber{

    
    NSString *cleanedString = [[phoneNumber componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    NSString *escapedPhoneNumber = [cleanedString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *phoneURLString = [NSString stringWithFormat:@"telprompt:%@", escapedPhoneNumber];
    NSURL *phoneURL = [NSURL URLWithString:phoneURLString];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneURL]) {
        [[UIApplication sharedApplication] openURL:phoneURL];
    }else
    {
        UIAlertView * calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [calert show];
    }

}


+(NSInteger)getHourFromDate:(NSDate*)date
{
   
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date]; // Get necessary date

    return [components hour];
    
}
+(NSInteger)getMinutesFromDate:(NSDate*)date
{
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date]; // Get necessary date
    
    return [components minute];
    
}
+(NSInteger)getSecondFromDate:(NSDate*)date
{
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date]; // Get necessary date
    
    return [components second];
    
}




+(NSInteger)getYearFromDate:(NSDate*)date
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date]; // Get necessary date
    
    return [components year];
    
}
+(NSInteger)getMonthFromDate:(NSDate*)date
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date]; // Get necessary date
    
    return [components month];
    
}
+(NSInteger)getDayFromDate:(NSDate*)date
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date]; // Get necessary date
    
    return [components day];
    
}
+(NSDate*)getDateFromYear:(NSInteger)y month:(NSInteger)m day:(NSInteger)d
{
    
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    
//    //gather date components from date
//    NSDateComponents *dateComponents = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:[NSDate date]];
//    
//    //set date components
//    [dateComponents setDay:d];
//    [dateComponents setMonth:m];
//    [dateComponents setYear:y];
//    
//    //save date relative from date
//    NSDate *date = [calendar dateFromComponents:dateComponents];
//    return  date;
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString * datestr = [NSString stringWithFormat:@"%02ld/%02ld/%ld",(long)d , (long)m, (long)y];
    NSDate * date = [dateFormatter dateFromString:datestr];
    return date;
    
}
+(NSDate*)getStartDateOfWeekFromYear:(NSInteger)y Month:(NSInteger)m Day:(NSInteger)d
{
    
    NSDate *today=[GlobalDefine getDateFromYear:y month:m day:d];
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];// you can use your format.
    
    //Week Start Date
    
    NSCalendar *gregorian = [[NSCalendar alloc]        initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:today];
    
    NSInteger dayofweek = [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:today] weekday];// this will give you current day of week
    
    [components setDay:([components day] - ((dayofweek) - 2))];// for beginning of the week.
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    
    
    return beginningOfWeek;
    
    
}

+(NSDate*)getEndDateOfWeekFromYear:(NSInteger)y Month:(NSInteger)m Day:(NSInteger)d
{
    NSDate *today=[GlobalDefine getDateFromYear:y month:m day:d];
    NSInteger dayofweek = [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:today] weekday];
    NSLog(@"getEndDateOfWeekFromYear:  %@  %ld",today , (long)dayofweek);
    
    if(dayofweek == 1){
        return [GlobalDefine getDateFromYear:y month:m day:d];
    }
    
    
    NSCalendar *gregorianEnd = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *componentsEnd = [gregorianEnd components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:today];
    
    NSInteger Enddayofweek = [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:today] weekday];// this will give you current day of week
    
    [componentsEnd setDay:([componentsEnd day]+(7-Enddayofweek)+1)];// for end day of the week
    
    NSDate *EndOfWeek = [gregorianEnd dateFromComponents:componentsEnd];
    
    return EndOfWeek;
    
}


+(NSString*)getMonthNameWithDate:(NSDate*)date{
    

    
    return    [GlobalDefine getMonthNameinRomanian: [GlobalDefine getMonthFromDate:date]-1];
    
}
+(NSString*)getMonthNameinRomanian:(NSInteger)monthidx{
    
    NSArray * namelist = @[[MCLocalization stringForKey:@"January"], [MCLocalization stringForKey:@"February"], [MCLocalization stringForKey:@"March"], [MCLocalization stringForKey:@"April"], [MCLocalization stringForKey:@"May"], [MCLocalization stringForKey:@"June"], [MCLocalization stringForKey:@"July"], [MCLocalization stringForKey:@"August"], [MCLocalization stringForKey:@"September"], [MCLocalization stringForKey:@"October"], [MCLocalization stringForKey:@"November"], [MCLocalization stringForKey:@"December"]];
    
    return  [namelist objectAtIndex:monthidx];
    
}


+(BOOL)isSameDate1:(NSDate*)date1 Date2:(NSDate*)date2{
    if (date1 == nil || date2 == nil) {
        return NO;
    }
    
    NSInteger y1 = [GlobalDefine getYearFromDate:date1];
    NSInteger y2 = [GlobalDefine getYearFromDate:date2];
    
    NSInteger m1 = [GlobalDefine getMonthFromDate:date1];
    NSInteger m2 = [GlobalDefine getMonthFromDate:date2];
    
    NSInteger d1 = [GlobalDefine getDayFromDate:date1];
    NSInteger d2 = [GlobalDefine getDayFromDate:date2];
    
    if(y1==y2 && m1==m2 && d1==d2){
        
        return YES;
        
    }
    
    
    
    return NO;
    
    
}

+(NSArray*)getHolidayListByYear:(NSInteger)year{
    
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate * mothersDay = [GlobalDefine getEndDateOfWeekFromYear:year Month:5 Day:1];
    NSDate * fathersDay = [GlobalDefine getEndDateOfWeekFromYear:year Month:5 Day:8];
//    NSDate* nnn = [dateFormatter dateFromString:[NSString stringWithFormat:@"01/01/%ld",year]];
    
    NSArray* holidays = @[
                          [dateFormatter dateFromString:[NSString stringWithFormat:@"01/01/%ld",(long)year]],
                          [dateFormatter dateFromString:[NSString stringWithFormat:@"02/01/%ld",(long)year]],
                          [dateFormatter dateFromString:[NSString stringWithFormat:@"24/01/%ld",(long)year]],
                          [dateFormatter dateFromString:[NSString stringWithFormat:@"13/04/%ld",(long)year]],
                          [dateFormatter dateFromString:[NSString stringWithFormat:@"01/05/%ld",(long)year]],
                          [dateFormatter dateFromString:[NSString stringWithFormat:@"10/05/%ld",(long)year]],
                          [dateFormatter dateFromString:[NSString stringWithFormat:@"01/06/%ld",(long)year]],
                          [dateFormatter dateFromString:[NSString stringWithFormat:@"15/08/%ld",(long)year]],
                          [dateFormatter dateFromString:[NSString stringWithFormat:@"30/11/%ld",(long)year]],
                          [dateFormatter dateFromString:[NSString stringWithFormat:@"01/12/%ld",(long)year]],
                          [dateFormatter dateFromString:[NSString stringWithFormat:@"25/12/%ld",(long)year]],
                          [dateFormatter dateFromString:[NSString stringWithFormat:@"26/12/%ld",(long)year]],
                          mothersDay,
                          fathersDay
                          
                          ];
    
    return  holidays;

}
+(NSArray*)getHolidayListByMonth:(NSInteger)month Year:(NSInteger)year{
    NSMutableArray * resList = [[NSMutableArray alloc]init];
    
    NSArray * hList = [GlobalDefine getHolidayListByYear:year];
    
    
    for(int i=0 ; i<hList.count ; i++){
        NSDate * hd = (NSDate*)[hList objectAtIndex:i];
        NSInteger hmonth = [GlobalDefine getMonthFromDate:hd];
        
        if(hmonth == month){
            [resList addObject:hd];
        }
    }
    
    return resList;
}


//
//+(NSString*)getDescriptionHoliday:(NSDate*)date{
//    
//    
//    NSInteger year = [GlobalDefine getYearFromDate:date];
//   
//
//       NSString * descriptonStr = [[NSString alloc]init];
//    NSArray* holidaysDescription = @[
//                                     @"New Years Day",
//                                     @"Day after New Years Day",
//                                     @"Unification Day",
//                                     @"Orthodox Easter Monday",
//                                     @"May Day",
//                                     @"Romanian Monarchy Day",
//                                     @"Descent of the Holy Spirit",
//                                     @"St Marys Day",
//                                     @"Feast of St Andrew",
//                                     @"National day",
//                                     @"Christmas Day",
//                                     @"Second day of Christmas",
//                                     @"Mothers Day",
//                                     @"Fathers Day"
//                                     ];
//    
//    NSArray* holidays = [GlobalDefine getHolidayListByYear:year];
//    
//    for (int i=0 ; i<holidays.count; i++) {
//        
//        NSDate * eachDate =(NSDate*) [holidays objectAtIndex:i];
//        
//        if([GlobalDefine isSameDate1:date Date2:eachDate]){
//            
//            if(descriptonStr.length>0){
//                
//                descriptonStr =  [descriptonStr stringByAppendingString:@", " ];
//            }
//                descriptonStr =  [descriptonStr stringByAppendingString:[holidaysDescription objectAtIndex:i] ];
//            
//            
//        }
//    }
//    
//    if(descriptonStr.length>0){
//        return  descriptonStr;
//    }
//    
//    return NO_HOLIDAY;
//}


+(NSInteger)isEarlierDate1:(NSDate*)date1 thanDate2:(NSDate*)date2{
    if ([date1 compare:date2] == NSOrderedDescending) {
//        NSLog(@"date1 is later than date2");
        return  0;
        
    } else if ([date1 compare:date2] == NSOrderedAscending) {
//        NSLog(@"date1 is earlier than date2");
        return 1;
    } else {
//        NSLog(@"dates are the same");
        return -1;
    }
}

+ (NSDate *)nextDay:(NSDate *)date {
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [calendar setLocale:[NSLocale currentLocale]];

    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    return [calendar dateByAddingComponents:comps toDate:date options:0];
}
+ (NSDate *)prevDay:(NSDate *)date {
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [calendar setLocale:[NSLocale currentLocale]];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:-1];
    return [calendar dateByAddingComponents:comps toDate:date options:0];
}

+(NSString *)getDuringofDate:(NSDate *)date1{
    
    NSInteger inter = [date1 timeIntervalSinceNow];
    
    
    NSInteger days = inter / (3600 * 24);
    
    NSInteger qd = inter % (3600*24);
    NSInteger hours = qd/(3600);
    NSInteger hq = qd % 3600;
    NSInteger mins = hq / 60;
    
    
    NSString * ret = [NSString stringWithFormat:@"%ldd %ldh %ldm", (long)days, (long)hours, (long)mins];
    
    return  ret;
    
    
}


+(NSString*) getWhatDate:(NSDate*)date{
    
//    NSString * res = @"";
    
    if([GlobalDefine isSameDate1:[NSDate date] Date2:date]){
        return  [MCLocalization stringForKey:@"TODAY"];
    }
    if([GlobalDefine isSameDate1:date Date2:[GlobalDefine prevDay:[NSDate date]]]){
        return [MCLocalization stringForKey:@"YESTERDAY"];
    }
    if([GlobalDefine isSameDate1:date Date2:[GlobalDefine nextDay:[NSDate date]]]){
        return [MCLocalization stringForKey:@"TOMORROW"];
    }
    
    NSDateFormatter * df =[[NSDateFormatter alloc]init];
    [df setDateFormat:@"MMM dd, yyyy"];
    
    return  [df stringFromDate:date];
    
}

+(NSInteger)GetDayOfWeek:(NSDate*)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"EEEE"];
    NSLog(@"%@", [dateFormatter stringFromDate: date]);
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] ;
    NSDateComponents *comps = [gregorian components:NSCalendarUnitWeekday fromDate: date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
    


}

+(NSString*)getStringFromAddedMinutes:(NSInteger)minutes hour:(NSInteger)h minute:(NSInteger)m{
    
    
    m += minutes;
    h  += m / 60;
    m = m % 60;

    NSString *res = [NSString stringWithFormat:@"%ld:%ld",(long)h,(long)m];
    
    return  res;
    
}
+(UIImage*) drawText:(NSString*) text
             inImage:(UIImage*)  image
             atPoint:(CGPoint)   point
           textColor:(UIColor*) textColor
{
    
    //    UIFont *font = [UIFont boldSystemFontOfSize:12];
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    //    CGRect rect = CGRectMake(point.x, point.y, image.size.width, image.size.height);
    //    [[UIColor blackColor] set];
    [textColor setStroke];
    [textColor setFill];
    
    
    
    UIFont *font = [UIFont fontWithName:@"Courier" size:12];
    
    /// Make a copy of the default paragraph style
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    /// Set line break mode
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    /// Set text alignment
    paragraphStyle.alignment = NSTextAlignmentRight;
    
    NSDictionary *attributes = @{ NSFontAttributeName: font,
                                  NSForegroundColorAttributeName:textColor,
                                  NSParagraphStyleAttributeName: paragraphStyle };
    
    //    [text drawInRect:CGRectIntegral(rect) withAttributes:attributes];
    [text drawAtPoint:point withAttributes:attributes];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(NSString*)GetDocumentDirPath{
    NSArray * dirpaths;
    NSString * docsDir;
    dirpaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirpaths[0];
    return  docsDir;
}

+(NSArray*)ContentsOfDocumentDirectory{
    NSArray * dirpaths;
    NSString * docsDir;
    dirpaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirpaths[0];
    NSArray * contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:docsDir error:nil];
    
    return  contents;
}
+(NSString*)GetFileSizePrettyFormat:(NSInteger)byte{
//    double convertedValue = [value doubleValue];
//    int multiplyFactor = 0;
//    
//    NSArray *tokens = [NSArray arrayWithObjects:@"bytes",@"KB",@"MB",@"GB",@"TB",nil];
//    
//    while (convertedValue > 1024) {
//        convertedValue /= 1024;
//        multiplyFactor++;
//    }
//    
//    return [NSString stringWithFormat:@"%4.2f %@",convertedValue, [tokens objectAtIndex:multiplyFactor]];

  return  [NSByteCountFormatter stringFromByteCount:byte countStyle:NSByteCountFormatterCountStyleFile];
}

#pragma mark - AlertView relation
+(void)ShowAlertViewTitle:(NSString*)title message:(NSString*)message VC:(UIViewController*)vc Ok:(void(^)())okBlock {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(okBlock){
            okBlock();
        }
    }];
   
    [alert addAction:okAction];
    [vc presentViewController:alert animated:YES completion:nil];
}
+(void)ShowAlertYesNoTitle:(NSString*)title message:(NSString*)message VC:(UIViewController*)vc YESBlock:(void(^)())yesBlock cancelBlock:(void(^)())cancelBlock {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(yesBlock){
            yesBlock();
        }
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(cancelBlock){
            cancelBlock();
        }
    }];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [vc presentViewController:alert animated:YES completion:nil];
}

+(void)ShowAlertTextTitle:(NSString*)title message:(NSString*)message placeholder:(NSString *)placeholder VC:(UIViewController*)vc Ok:(void(^)(NSString * _Nonnull text))okBlock cancelBlock:(void(^)())cancelBlock{

    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title
                                                                              message: message
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = placeholder;
        textField.textColor = [UIColor blackColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleNone;
    }];

    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField * namefield = textfields[0];
//        UITextField * passwordfiled = textfields[1];
//        NSLog(@"%@:%@",namefield.text,passwordfiled.text);
        okBlock(namefield.text);
        
    }]];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(cancelBlock){
            cancelBlock();
        }
    }];
    [alertController addAction:cancelAction];
    [vc presentViewController:alertController animated:YES completion:nil];
    
}


//+(void)showAlert:(NSString*)msg {
//
//    [[[UIAlertView alloc] initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
//    
//}


+(BOOL) StringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

#pragma mark - String & NSDictionary relation

+(NSString *)getStringFrom:(NSDictionary*)dict forKey:(NSString*)keystr{
    
    NSString * ret = [dict objectForKey:keystr];
    ret = isSet(ret)?ret:@"";
    return ret;
    
}
+(NSInteger)getIntFrom:(NSDictionary*)dict forKey:(NSString*)keystr{
    
    NSInteger ret = [[dict objectForKey:keystr] integerValue];
    
   
    return ret;
    
}

+(CGFloat)getFloatFrom:(NSDictionary*)dict forKey:(NSString*)keystr{
    
    NSString * ret = [GlobalDefine getStringFrom:dict forKey:keystr];
    CGFloat retfloat = [ret floatValue];
    return retfloat;
    
}

+(NSArray<NSString*> *)getArrFrom:(NSDictionary*)dict forKey:(NSString*)keystr sepStr:(NSString*)sepStr{
    
    NSString * str = [GlobalDefine getStringFrom:dict forKey:keystr];
    if(!isSet(str)){
        return @[];
    }
    
    NSArray * ret = [str componentsSeparatedByString:sepStr];
    if(ret.count > 0){
        NSMutableArray * retM = [NSMutableArray new];
        
        for (NSString * each in ret) {
            if(isSet(each)){
                [retM addObject:each];
            }
        }
        return retM;
    }else{
        return @[];
    }
    
    
}

+(NSArray<NSDictionary*> *)getArrFrom:(NSDictionary*)dict forKey:(NSString*)keystr {
    
  
    
    NSArray * ret = [dict objectForKey:keystr];
    
    if([ret isKindOfClass:[NSArray class]]){
        
        return ret;
        
    }else{
        return @[ret];
    }
    
}

// Dataformat convert

+(NSString*)intToString:(NSInteger)val{
    return [NSString stringWithFormat:@"%ld",(long)val];
}
+(NSString*)floatToString:(CGFloat)val{
    return [NSString stringWithFormat:@"%f",val];
}
+(NSString*)longToString:(long)val{
    return [NSString stringWithFormat:@"%ld",(long)val];
}
+(NSString*)doubleToString:(double)val{
    return [NSString stringWithFormat:@"%f",val];
}

+(double)StringToDouble:(NSString*)val{
    @try{
            return [val doubleValue];
    }
    @catch(NSException * ex){
        
    }
    
}
+(CGFloat)StringToFloat:(NSString*)val{
    return  [val floatValue];
}
+(long)StringTolong:(NSString*)val{
    return  (long)[val integerValue];
}
+(int)StringToInt:(NSString*)val{
    return (int)[val integerValue];
}


#pragma mark - image relation


+ (UIImage *)imageWithColor:(UIColor *)color withFrame:(CGRect)rect {
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
+ (UIImage *)navbarImageWithBarColor:(UIColor *)color
                         StatusColor:(UIColor*)statusBarColor withFrame:(CGRect)rect {
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [statusBarColor CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, rect.size.width, rect.origin.y));
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


+ (UIImage *)captureView:(UIView *)view withArea:(CGRect)screenRect {
    
    UIGraphicsBeginImageContext(screenRect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set];
    CGContextFillRect(ctx, screenRect);
    
    [view.layer renderInContext:ctx];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}




+(void)SaveAvatar:(UIImage*)object{
    
    [GD WriteImageDefaultStore:object forKey:@"def_avatar_origin"];
    
    
}
+(UIImage *)GetAvatar{
   UIImage * img = (UIImage*) [GD ReadImageDefaultStoreforKey:@"def_avatar_origin"];
    
    return  img;
}

+(void)WriteImageDefaultStore:(UIImage*)object forKey:(nonnull NSString *)key{
    NSData * data = UIImagePNGRepresentation(object);
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


+(void)WriteDefaultStore:(id)object forKey:(nonnull NSString *)key{
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
+(id)ReadImageDefaultStoreforKey:(nonnull NSString *)key{
    NSData * data = [[NSUserDefaults standardUserDefaults] dataForKey:key];
    UIImage * img = [[UIImage alloc] initWithData:data];
    return  img;
}
+(id)ReadDefaultStoreforKey:(nonnull NSString *)key{
    
    return     [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
}
+(void)LocalAvatarSet:(UIImageView*)imgView place:(NSString*)placeName key:(NSString*)key{
    
    UIImage * img = [self ReadImageDefaultStoreforKey:key];
    if(img){
        [imgView setImage:img];
    }else{
        [imgView setImage:[UIImage imageNamed:placeName]];
    }
    
}



+(NSString*)EncodeImageToBase64String:(UIImage*)image{
    
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
}
+(UIImage*)DecodeBase64ToImage:(NSString*)strEncodedData{
    NSData * data = [[NSData alloc] initWithBase64EncodedString:strEncodedData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

#pragma mark mainthread relation
+(void)onMain:(void(^)())block{
    dispatch_async(dispatch_get_main_queue(), ^{
        block();
    });
}
@end
