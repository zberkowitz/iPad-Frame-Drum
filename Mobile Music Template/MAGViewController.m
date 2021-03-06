//
//  MAGViewController.m
//  Mobile Music Template
//
//  Created by Jesse Allison on 10/17/12.
//  Copyright (c) 2012 MAG. All rights reserved.
//

#import "MAGViewController.h"


@interface MAGViewController ()

@end

@implementation MAGViewController

@synthesize tak;
@synthesize dum;

double currentAcceleration = 0;
double previousAcceleration = 0;
double accelerationDifference = 0;

- (NSUInteger) supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //tak.transform = CGAffineTransformMakeRotation(M_PI / -4);
	
    // _________________ LOAD Pd Patch ____________________
    dispatcher = [[PdDispatcher alloc] init];
    [PdBase setDelegate:dispatcher];
    patch = [PdBase openFile:@"mag_template.pd" path:[[NSBundle mainBundle] resourcePath]];
    if (!patch) {
        NSLog(@"Failed to open patch!");
    }
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval  = 1.0/10000.0; // Update at 100Hz
    if (self.motionManager.accelerometerAvailable) {
        NSLog(@"Accelerometer avaliable");
        NSOperationQueue *queue = [NSOperationQueue currentQueue];
        [self.motionManager startAccelerometerUpdatesToQueue:queue
                                                 withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
                                                     CMAcceleration acceleration = accelerometerData.acceleration;
                                                     
                                                     currentAcceleration = acceleration.z;
                                                     accelerationDifference = fabs(currentAcceleration -  previousAcceleration);
                                                     previousAcceleration = currentAcceleration;
                                   

                                        }];
    }

}


/*
- (void)viewDidUnload
{
    // uncomment for pre-iOS 6 deployment
    [super viewDidUnload];
    [PdBase closeFile:patch];
    [PdBase setDelegate:nil];
}
 */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// _________________ UI Interactions with Pd Patch ____________________

- (IBAction)Tak:(UIButton *)sender {
     [PdBase sendFloat:accelerationDifference
            toReceiver:@"tak_velocity"];
    NSLog([NSString stringWithFormat:@"%f", accelerationDifference]);
    
}

- (IBAction)Dum:(UIButton *)sender {
    [PdBase sendFloat:accelerationDifference
           toReceiver:@"dum_velocity"];
    NSLog([NSString stringWithFormat:@"%f", accelerationDifference]);
}
- (IBAction)Pa:(UIButton *)sender {
    [PdBase sendFloat:accelerationDifference
           toReceiver:@"pa_velocity"];
}




@end
