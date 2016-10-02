//
//  CustomCalloutView.h
//  SportsMatch
//
//  Created by Zhang RenJun on 6/22/16.
//  Copyright © 2016 Zhang RenJun. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Mapbox;
@interface CustomCalloutView : UIView<MGLCalloutView>

@property(nonatomic, strong)TournamentModel * tournamentModel;
@property(nonatomic, strong)EventModel * eventModel;

@property(nonatomic)BOOL isActivityMode;

@end
