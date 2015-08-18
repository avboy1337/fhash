//
//  NSProgressIndicator+ESSProgressIndicatorCategory.m
//  Briefly
//
//  Created by Matthias Gansrigler on 06.05.2015.
//  Copyright (c) 2015 Eternal Storms Software. All rights reserved.
//

#import "NSProgressIndicator+ESSProgressIndicatorCategory.h"

@interface ESSProgressBarAnimation : NSAnimation

@property (strong) NSProgressIndicator *progInd;
@property (assign) double initValue;
@property (assign) double newValue;

- (instancetype)initWithProgressBar:(NSProgressIndicator *)ind
					 newDoubleValue:(double)val;

@end


@implementation NSProgressIndicator (ESSProgressIndicatorCategory)

- (void)animateToDoubleValue:(double)val
{
	ESSProgressBarAnimation *anim = [[ESSProgressBarAnimation alloc] initWithProgressBar:self
																		  newDoubleValue:val];
	[anim startAnimation];
}

@end


@implementation ESSProgressBarAnimation

- (instancetype)initWithProgressBar:(NSProgressIndicator *)ind
					 newDoubleValue:(double)val
{
    
    
	if (self = [super initWithDuration:0.3 animationCurve:NSAnimationLinear])
	{
		self.progInd = ind;
        self.initValue = self.progInd.doubleValue;
		self.newValue = val;
		self.animationBlockingMode = NSAnimationNonblockingThreaded;
		return self;
	}
	
	return nil;
}

- (void)setCurrentProgress:(NSAnimationProgress)currentProgress
{
	[super setCurrentProgress:currentProgress];
	
	double delta = self.newValue - self.progInd.doubleValue;
    if ((delta * (self.newValue - self.initValue)) > 0) {
        self.progInd.doubleValue = self.progInd.doubleValue + (delta * currentProgress);
    }
}

@end