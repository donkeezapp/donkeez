//
//  Annotation.h
//  
//
//  Created by Admin on 10/16/15.
//
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Annotation : NSObject<MKAnnotation>

@property(nonatomic,assign) CLLocationCoordinate2D coordinate;
@property(nonatomic,copy)NSString* title;
@property(nonatomic,copy)NSString* subtitle;
@property(nonatomic,copy)NSString* imgName;


@end
