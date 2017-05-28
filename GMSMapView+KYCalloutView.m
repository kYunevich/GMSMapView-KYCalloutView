//
//  GMSMapView+KYCalloutView.m
//  KYGoogleMapController
//
//  Created by Konstantin Yunevich on 20.05.17.
//  Copyright © 2017 Konstantin Yunevich. All rights reserved.
//

#import "GMSMapView+KYCalloutView.h"
#import <objc/runtime.h>

static void * KYGoogleMapCalloutViewType = &KYGoogleMapCalloutViewType;
static void * KYGoogleMapCalloutView = &KYGoogleMapCalloutView;

//static CGFloat const kDefaultCalloutViewPresentAnimationDuration = 0.25;
static CGFloat const kCalloutViewMinAlpha = 0.0;
static CGFloat const kCalloutViewMaxAlpha = 1.0;

@implementation GMSMapView (KYCalloutView)

@dynamic calloutView;

#pragma mark - callout view associated
- (void)setCalloutView:(UIView *)calloutView {
    objc_setAssociatedObject(self, KYGoogleMapCalloutView, calloutView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)calloutView {
    return objc_getAssociatedObject(self, KYGoogleMapCalloutView);
}


#pragma - Public Methods

#pragma mark - Show callout view with coordinate
- (void)showCalloutViewForCoordinate:(CLLocationCoordinate2D)coordinate duration:(NSTimeInterval)duration completion:(KYCalloutViewCompletion)completionHandler {
    
    if (self.calloutView) {
        [self addCalloutViewToMap];
        CGPoint point = [self.projection pointForCoordinate:coordinate];
        [self showCalloutViewForPoint:point duration:duration completion:completionHandler];
    }
}

#pragma mark - Show callout view with point
- (void)showCalloutViewForPoint:(CGPoint)point duration:(NSTimeInterval)duration completion:(KYCalloutViewCompletion)completionHandler {
    if (self.calloutView) {
        [self addCalloutViewToMap];
        
        CGRect calloutViewFrame = self.calloutView.frame;
        CGSize calloutViewSize = calloutViewFrame.size;
        
        
        CGFloat calloutX = point.x - calloutViewSize.width / 2;
        CGFloat calloutY = point.y - calloutViewSize.height;
        
        self.calloutView.frame = CGRectMake(calloutX,
                                            calloutY,
                                            calloutViewSize.width,
                                            calloutViewSize.height);
        
        [self enableCalloutViewWithAlpha:kCalloutViewMaxAlpha
                                duration:duration
                              completion:completionHandler];
        
    }
}

#pragma mark - Hide callout view
- (void)hideCalloutViewWithDuration:(NSTimeInterval)duration completion:(KYCalloutViewCompletion)completionHandler {
    if (self.calloutView) {
        
        __weak typeof(self)weakSelf = self;
        [self enableCalloutViewWithAlpha:kCalloutViewMinAlpha duration:duration completion:^{
           
            __strong typeof(self)self = weakSelf;
            [self removeCalloutViewFromMap];
            
            if (completionHandler) {
                completionHandler();
            }
            
        }];
    }
}

#pragma mark - Private Methods
- (void)enableCalloutViewWithAlpha:(CGFloat)alpha duration:(NSTimeInterval)duration completion:(KYCalloutViewCompletion)completion {
    
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:duration animations:^{
        __strong typeof(self)self = weakSelf;
        self.calloutView.alpha = alpha;
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}


- (void)addCalloutViewToMap {
    UIView *calloutView = self.calloutView;
    if (![self.subviews containsObject:calloutView]) {
        [self addSubview:calloutView];
    }
}


- (void)removeCalloutViewFromMap {
    UIView *calloutView = self.calloutView;
    if ([self.subviews containsObject:calloutView]) {
        [calloutView removeFromSuperview];
    }
}

@end
