//
//  GMSMapView+KYCalloutView.h
//  KYGoogleMapController
//
//  Created by Konstantin Yunevich on 20.05.17.
//  Copyright © 2017 Konstantin Yunevich. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h>


//typedef NS_ENUM(NSInteger, KYCalloutViewStyle) {
//    KYCalloutViewStyleDark,
//    KYCalloutViewStyleLight,
//    KYCalloutViewStyleCustom
//};

typedef NS_ENUM(NSInteger, KYCalloutViewAnimationStyle) {
    KYCalloutViewAnimationStyleAlpha
};

typedef void (^KYCalloutViewCompletion)(void);

@interface GMSMapView (KYCalloutView)

@property (strong, nonatomic, nullable) UIView *calloutView;

- (void)showCalloutViewForCoordinate:(CLLocationCoordinate2D)coordinate duration:(NSTimeInterval)duration completion:(KYCalloutViewCompletion _Nullable)completionHandler;
- (void)showCalloutViewForPoint:(CGPoint)point duration:(NSTimeInterval)duration completion:(KYCalloutViewCompletion _Nullable)completionHandler;
- (void)hideCalloutViewWithDuration:(NSTimeInterval)duration completion:(KYCalloutViewCompletion _Nullable)completionHandler;

@end
