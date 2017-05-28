## Installation

Install Google Maps Sdk

```ruby
pod 'GoogleMaps'
```

download files
GMSMapView+KYCalloutView.h
GMSMapView+KYCalloutView.m

Put the files in the project

# Usage
# Initialize
```objc
UIView *calloutView = [[UIView alloc] initWithFrame:CGRectMake(0,0,200, 150)];
calloutView.backgroundColor = [UIColor blackColor];
calloutView.layer.cornerRadius = 3;

self.googleMapView.calloutView = calloutView; // Initialize calloutView
```
# Show CalloutView for point  
```objc
CGPoint point = [self.googleMapView.projection pointForCoordinate:marker.position];
point.y = point.y - 25;

[self.googleMapView showCalloutViewForPoint:point duration:0.25 completion:nil];
```

# Show CalloutView for coordinate
```objc
CLLocationCoordinate2D coordinate = marker.position;

[self.googleMapView showCalloutViewForCoordinate:coordinate duration:0.25 completion:nil];
```
