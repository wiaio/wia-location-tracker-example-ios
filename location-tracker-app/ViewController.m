//
//  ViewController.m
//  location-tracker-app
//
//  Created by Cormac Chisholm on 28/11/2016.
//  Copyright © 2016 Wia. All rights reserved.
//

#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface ViewController ()

@property GMSMapView *mapView;
@property GMSCameraPosition *camera;
@property GMSMarker *marker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [WiaClient debug:YES];
    [[WiaClient sharedInstance] setDelegate:self];
    [[WiaClient sharedInstance] initWithToken:@"token"];
    [[NSNotificationCenter defaultCenter] addObserverForName:@"WiaStreamConnect" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"CONNECTED TO STREAM");
        [[WiaClient sharedInstance] subscribeToLocations:@{@"device": @"Device Id"}];

    }];
    [[WiaClient sharedInstance] connectToStream];

    self.camera = [GMSCameraPosition cameraWithLatitude:0.000000
                                              longitude:0.000000
                                                   zoom:16];
    self.mapView = [GMSMapView mapWithFrame:CGRectZero camera:self.camera];
    self.mapView.myLocationEnabled = YES;
    self.view = self.mapView;
    // Creates a marker in the center of the map.
    self.marker = [[GMSMarker alloc] init];
    self.marker.title = @"Location Device";
    self.marker.map = self.mapView;
}

- (void)newLocation:(WiaLocation *)location {
    CLLocationCoordinate2D coordinates;
    coordinates.latitude = [location.latitude doubleValue];
    coordinates.longitude = [location.longitude doubleValue];
    GMSCameraUpdate *updatedCamera = [GMSCameraUpdate setTarget:coordinates zoom:13];

    [self.mapView animateWithCameraUpdate:updatedCamera];
    self.marker.position = CLLocationCoordinate2DMake([location.latitude doubleValue], [location.longitude doubleValue]);
}

@end
