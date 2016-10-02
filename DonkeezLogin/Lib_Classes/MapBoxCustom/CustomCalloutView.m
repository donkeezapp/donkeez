//
//  CustomCalloutView.m
//  SportsMatch
//
//  Created by Zhang RenJun on 6/22/16.
//  Copyright © 2016 Zhang RenJun. All rights reserved.
//

#import "CustomCalloutView.h"
static CGFloat const tipHeight = 10.0;
static CGFloat const tipWidth = 20.0;

@interface CustomCalloutView (){
    
    UIView * cellView;
}

@property (strong, nonatomic) UIButton *mainBody;

@end

@implementation CustomCalloutView
{
    id <MGLAnnotation> _representedObject;
    __unused UIView *_leftAccessoryView;/* unused */
    __unused UIView *_rightAccessoryView;/* unused */
    __weak id <MGLCalloutViewDelegate> _delegate;
}

@synthesize representedObject = _representedObject;
@synthesize leftAccessoryView = _leftAccessoryView;/* unused */
@synthesize rightAccessoryView = _rightAccessoryView;/* unused */
@synthesize delegate = _delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        // Create and add a subview to hold the callout’s text
        UIButton *mainBody = [UIButton buttonWithType:UIButtonTypeSystem];
        mainBody.backgroundColor = [self backgroundColorForCallout];
        mainBody.tintColor = [UIColor whiteColor];
        mainBody.contentEdgeInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
        mainBody.layer.cornerRadius = 4.0;
        self.mainBody = mainBody;
        
        [self addSubview:self.mainBody];
    }
    
    return self;
}

#pragma mark - MGLCalloutView API

- (void)presentCalloutFromRect:(CGRect)rect inView:(UIView *)view constrainedToView:(UIView *)constrainedView animated:(BOOL)animated
{
    // Do not show a callout if there is no title set for the annotation
    if (![self.representedObject respondsToSelector:@selector(title)])
    {
        return;
    }
    
    [view addSubview:self];
    
    // Prepare title label
//    [self.mainBody setTitle:self.representedObject.title forState:UIControlStateNormal];
    [self.mainBody sizeToFit];
    
    
    if ([self isCalloutTappable])
    {
        // Handle taps and eventually try to send them to the delegate (usually the map view)
        [self.mainBody addTarget:self action:@selector(calloutTapped) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        // Disable tapping and highlighting
        self.mainBody.userInteractionEnabled = NO;
    }
    
    // Prepare our frame, adding extra space at the bottom for the tip
//    CGFloat frameWidth = self.mainBody.bounds.size.width;
//    CGFloat frameHeight = self.mainBody.bounds.size.height + tipHeight;
    CGFloat frameWidth = [GD GetScreenSize].width * 0.9;
    CGFloat frameHeight = 219 + tipHeight;
    CGFloat frameOriginX = rect.origin.x + (rect.size.width/2.0) - (frameWidth/2.0);
    CGFloat frameOriginY = rect.origin.y - frameHeight;
    
    self.frame = CGRectMake(frameOriginX, frameOriginY,
                            frameWidth, frameHeight);
    
    if(!_isActivityMode){
       cellView = [[[NSBundle mainBundle] loadNibNamed:@"TournamentCell" owner:self options:nil] objectAtIndex:0];
        UILabel * lblDate = [cellView viewWithTag:10];
        UILabel * lblTitle = [cellView viewWithTag:11];
        UIImageView * img = [cellView viewWithTag:12];
        UILabel * lblGender = [cellView viewWithTag:13];
        UILabel * lblAge = [cellView viewWithTag:14];
        
        UILabel * lblEmail = [cellView viewWithTag:15];
        UILabel * lblPhone = [cellView viewWithTag:16];
        
        UIButton * btnDetail = [cellView viewWithTag:17];
        UIButton * btnJoin = [cellView viewWithTag:18];
    //    NSInteger idx = [annotation.subtitle integerValue];
    //    TournamentModel * tm = (TournamentModel*)[_curData objectAtIndex:idx];
    
  
        lblTitle.text = _tournamentModel.tournament_title;
        lblAge.text = [NSString stringWithFormat:@"%ld ~ %ld (age)",(long) _tournamentModel.tournament_min_age,(long) _tournamentModel.tournament_max_age];
        
        NSDateFormatter * df = [[NSDateFormatter alloc]init];
        
        [df setDateFormat:@"yyyy.MM.dd HH:mm"];
        
        lblDate.text = [NSString stringWithFormat:@"%@ - %@", [df stringFromDate:_tournamentModel.fromDate], [df stringFromDate:_tournamentModel.toDate]];
        
        lblEmail.text = [NSString stringWithFormat:@"Email : %@", _tournamentModel.tournament_owner_email];
        lblPhone.text = [NSString stringWithFormat:@"Phone : %@", _tournamentModel.tournament_owner_mobile];
        
        [img setMHImageWithURL:[NSURL URLWithString:_tournamentModel.thumbnail_image]];
        
        lblGender.text = [NSString stringWithFormat:@"%@ (Gender)", [kAppDelegate getType:[_tournamentModel.tournament_type integerValue]]];
        
//
        CGPoint point = self.mainBody.frame.origin;
        [cellView setFrame:CGRectMake(point.x,point.y, [GD GetScreenSize].width * 0.9, 219)];

        
        [view addSubview:cellView];
//        [view addSubview:lblDate];
//        [view addSubview:lblTitle];
//        [view addSubview:lblGender];
//        [view addSubview:lblPhone];
//        [view addSubview:img];
//        [view addSubview:lblAge];
//        [view addSubview:lblEmail];
    }else{
        
        cellView = [[[NSBundle mainBundle] loadNibNamed:@"EventsCell" owner:self options:nil] objectAtIndex:0];
        UILabel * lblDate = [cellView viewWithTag:10];
        UILabel * lblTitle = [cellView viewWithTag:11];
        UIImageView * img = [cellView viewWithTag:12];
        UILabel * lblSportType = [cellView viewWithTag:13];
        UILabel * lblGender = [cellView viewWithTag:14];
        UILabel * lblAge = [cellView viewWithTag:15];
        
        UILabel * lblOwner = [cellView viewWithTag:16];
        
        UIButton * btnDetail = [cellView viewWithTag:17];
        UIButton * btnJoin = [cellView viewWithTag:18];
        
        
        lblTitle.text = _tournamentModel.tournament_title;
        lblAge.text = [NSString stringWithFormat:@"%ld ~ %ld (age)",(long) _eventModel.activity_min_age,(long) _eventModel.activity_max_age];
        
        NSDateFormatter * df = [[NSDateFormatter alloc]init];
        
        [df setDateFormat:@"yyyy.MM.dd HH:mm"];
        
        lblDate.text = [NSString stringWithFormat:@"%@ - %@", [df stringFromDate:_eventModel.fromDate], [df stringFromDate:_eventModel.toDate]];
        
        lblSportType.text = [kAppDelegate getSportsType:[_eventModel.activity_sport integerValue]];
        lblOwner.text = isSet(_eventModel.activity_owner_fname)?_eventModel.activity_owner_fname:@"";
        [img setMHImageWithURL:[NSURL URLWithString:_tournamentModel.thumbnail_image]];
        
        lblGender.text = [NSString stringWithFormat:@"%@ (Gender)", [kAppDelegate getType:_eventModel.activity_type ]];
        
//        

        CGPoint point = self.mainBody.frame.origin;
        [cellView setFrame:CGRectMake(point.x,point.y, [GD GetScreenSize].width * 0.9, 219)];
        [view addSubview:cellView];
//        [view addSubview:lblDate];
//        [view addSubview:lblTitle];
//        [view addSubview:lblGender];
//        [view addSubview:lblSportType];
//        [view addSubview:img];
//        [view addSubview:lblAge];
//        [view addSubview:lblOwner];
        
    }
    
    
    if (animated)
    {
        self.alpha = 0.0;
        
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1.0;
        }];
    }
}

- (void)dismissCalloutAnimated:(BOOL)animated
{
    if (self.superview)
    {
        if (animated)
        {
            [UIView animateWithDuration:0.2 animations:^{
                self.alpha = 0.0;
            } completion:^(BOOL finished) {
                [cellView removeFromSuperview];
                [self removeFromSuperview];
            }];
        }
        else
        {
            [cellView removeFromSuperview];
            [self removeFromSuperview];
        }
    }
}

#pragma mark - Callout interaction handlers

- (BOOL)isCalloutTappable
{
    if ([self.delegate respondsToSelector:@selector(calloutViewShouldHighlight:)]) {
        return [self.delegate performSelector:@selector(calloutViewShouldHighlight:) withObject:self];
    }
    
    return NO;
}

- (void)calloutTapped
{
    if ([self isCalloutTappable] && [self.delegate respondsToSelector:@selector(calloutViewTapped:)])
    {
        [self.delegate performSelector:@selector(calloutViewTapped:) withObject:self];
    }
}
#pragma mark - Custom view styling

- (UIColor *)backgroundColorForCallout
{
    return [UIColor darkGrayColor];
}

- (void)drawRect:(CGRect)rect
{
    // Draw the pointed tip at the bottom
    UIColor *fillColor = [self backgroundColorForCallout];
    
    CGFloat tipLeft = rect.origin.x + (rect.size.width / 2.0) - (tipWidth / 2.0);
    CGPoint tipBottom = CGPointMake(rect.origin.x + (rect.size.width / 2.0), rect.origin.y + rect.size.height);
    CGFloat heightWithoutTip = rect.size.height - tipHeight;
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef tipPath = CGPathCreateMutable();
    CGPathMoveToPoint(tipPath, NULL, tipLeft, heightWithoutTip);
    CGPathAddLineToPoint(tipPath, NULL, tipBottom.x, tipBottom.y);
    CGPathAddLineToPoint(tipPath, NULL, tipLeft + tipWidth, heightWithoutTip);
    CGPathCloseSubpath(tipPath);
    
    [fillColor setFill];
    CGContextAddPath(currentContext, tipPath);
    CGContextFillPath(currentContext);
    CGPathRelease(tipPath);
}

@end