//
//  SwipeUpViewController.m
//  WAHS
//
//  Created by Dirk Lewis on 6/28/13.
//  Copyright (c) 2013 VHH. All rights reserved.
//

#import "SwipeUpViewController.h"

@interface SwipeUpViewController ()

@end

@implementation SwipeUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handelPan:(UIPanGestureRecognizer *)recognizer{

    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:self.view];
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude / 400;
        float slideFactor = 0.1 * slideMult;
        CGPoint finalPoint = CGPointMake(recognizer.view.center.x + (velocity.x * slideFactor), recognizer.view.center.y + (velocity.y * slideFactor));
        finalPoint.x = MIN(MAX(finalPoint.x, 0), self.view.bounds.size.width);
        finalPoint.y = MIN(MAX(finalPoint.y, 0), self.view.bounds.size.height);
        
        [UIView animateWithDuration:slideFactor*2 animations:^{
            recognizer.view.center = finalPoint;
        }];

    }
}

- (IBAction)handlePinch:(UIPinchGestureRecognizer*)recognizer{

    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
    
}
- (IBAction)handleRotate:(UIRotationGestureRecognizer*)recognizer{

    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform,recognizer.rotation);
    recognizer.rotation = 0;
}

- (IBAction)handleViewPan:(UIPanGestureRecognizer *)sender {
    
    CGPoint translation = [sender translationInView:self.view];
    float position = sender.view.center.y - sender.view.bounds.size.height / 2;
    float translatedPosition = position + translation.y;
    float topPosition = 275.0f;
    float bottomPosition = 530.0f;
    
    float centerPosition = bottomPosition - sender.view.bounds.size.height / 2;
    float centerTopPosition = topPosition + sender.view.bounds.size.height/2;
    float centerbottomPosition = bottomPosition + sender.view.bounds.size.height/2;
    NSLog(@"%f %f",self.view.bounds.size.height,self.view.bounds.size.width);
    NSLog(@"top %f Translated POS %f",position, translatedPosition);

    if (translatedPosition <= topPosition || translatedPosition >= bottomPosition) {
        [sender setTranslation:CGPointMake(0, 0) inView:self.view];

        return;
    }
    
    sender.view.center = CGPointMake(sender.view.center.x, sender.view.center.y + translation.y);
    

    if (translation.y <= -15) {
        [UIView animateWithDuration:0.5f animations:^{
            sender.view.center = CGPointMake(sender.view.center.x, centerTopPosition);

        } completion:^(BOOL finished) {
            [sender setTranslation:CGPointMake(0, 0) inView:self.view];

        }];

    }
    else if (translation.y >= 15){
        [UIView animateWithDuration:0.5f animations:^{
            sender.view.center = CGPointMake(sender.view.center.x, centerbottomPosition);
            
        } completion:^(BOOL finished) {
            [sender setTranslation:CGPointMake(0, 0) inView:self.view];

        }];
    }

    if (sender.state == UIGestureRecognizerStateEnded) {
        if (translatedPosition < centerPosition ) {
            [UIView animateWithDuration:0.2f animations:^{
                sender.view.center = CGPointMake(sender.view.center.x, centerTopPosition);
                
            } completion:^(BOOL finished) {
                [sender setTranslation:CGPointMake(0, 0) inView:self.view];
                
            }];
        }
        else if (translatedPosition > centerPosition){
            [UIView animateWithDuration:0.2f animations:^{
                sender.view.center = CGPointMake(sender.view.center.x, centerbottomPosition);
                
            } completion:^(BOOL finished) {
                [sender setTranslation:CGPointMake(0, 0) inView:self.view];
                
            }];
        }
    }
    
    [sender setTranslation:CGPointMake(0, 0) inView:self.view];

}



//// called when a gesture recognizer attempts to transition out of UIGestureRecognizerStatePossible. returning NO causes it to transition to UIGestureRecognizerStateFailed
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    return YES;
//}
//
//// called when the recognition of one of gestureRecognizer or otherGestureRecognizer would be blocked by the other
//// return YES to allow both to recognize simultaneously. the default implementation returns NO (by default no two gestures can be recognized simultaneously)
////
//// note: returning YES is guaranteed to allow simultaneous recognition. returning NO is not guaranteed to prevent simultaneous recognition, as the other gesture's delegate may return YES
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    return YES;
//}
//
//// called before touchesBegan:withEvent: is called on the gesture recognizer for a new touch. return NO to prevent the gesture recognizer from seeing this touch
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    return YES;
//}
//
//
//- (IBAction)handleSwipe:(id)sender {
//    NSLog(@"swiping");
//
//}
@end
