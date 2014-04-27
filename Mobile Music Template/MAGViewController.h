//
//  MAGViewController.h
//  Mobile Music Template
//
//  Created by Jesse Allison on 10/17/12.
//  Copyright (c) 2012 MAG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PdDispatcher.h"
#import <CoreMotion/CoreMotion.h>

@interface MAGViewController : UIViewController {
    PdDispatcher *dispatcher;
    void *patch;
}

@property (strong, nonatomic) CMMotionManager *motionManager;
@property (weak, nonatomic) IBOutlet UIButton *tak;

@property (weak, nonatomic) IBOutlet UIButton *dum;


@end
