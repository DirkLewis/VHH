//
//  DynamicsViewController.m
//  WAHS
//
//  Created by Dirk Lewis on 7/1/13.
//  Copyright (c) 2013 VHH. All rights reserved.
//

#import "DynamicsViewController.h"

@interface DynamicsViewController ()

    
@end

@implementation DynamicsViewController{

    UIDynamicAnimator *_animator;
}

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

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dynamicAnimatorWillResume:(UIDynamicAnimator*)animator{
    NSLog(@"%@",animator);

}
- (void)dynamicAnimatorDidPause:(UIDynamicAnimator*)animator{
    NSLog(@"%@",animator);
}
- (IBAction)touchButton:(UIButton *)sender {
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    animator.delegate = self;
    
    UIGravityBehavior *g = [[UIGravityBehavior alloc]initWithItems:@[self.dynamicView,self.dynamicImageView]];
    //[g setXComponent:1.0f yComponent:1.0f];
    UICollisionBehavior *c = [[UICollisionBehavior alloc]initWithItems:@[self.dynamicView,self.dynamicImageView]];
    c.collisionDelegate = self;
    UIPushBehavior *p = [[UIPushBehavior alloc]initWithItems:@[self.dynamicImageView,self.dynamicView] mode:UIPushBehaviorModeContinuous];
    [p setActive:YES];
    [animator addBehavior:p];
    [c setCollisionMode:UICollisionBehaviorModeEverything];
    
    [c setTranslatesReferenceBoundsIntoBoundary:YES];
    [animator addBehavior:c];
    //[animator addBehavior:g];
    NSLog(@"Running: %i",animator.isRunning);
    
    NSLog(@"stopper %f %f",g.xComponent,g.yComponent);
    
    _animator = animator;
}

- (void)collisionBehavior:(UICollisionBehavior*)behavior beganContactForItem:(id <UIDynamicItem>)item1 withItem:(id <UIDynamicItem>)item2 atPoint:(CGPoint)p{
    NSLog(@"%@, %@, %f, %f",item1,item2,p.x,p.y);

}
- (void)collisionBehavior:(UICollisionBehavior*)behavior endedContactForItem:(id <UIDynamicItem>)item1 withItem:(id <UIDynamicItem>)item2{

    NSLog(@"%@, %@",item1,item2);
}


- (IBAction)handlePan:(UIPanGestureRecognizer *)sender {
    //CGPoint translation = [sender translationInView:self.view];
    CGPoint velocity = [sender velocityInView:self.view];
    
    CGFloat angle = atan2f(velocity.y, velocity.x);

    NSArray *behaviors = [_animator behaviors];
    for (id b in behaviors) {
        
        if ([b isKindOfClass:[UIGravityBehavior class]]) {
            [b setYComponent:-1.0];
        }
        if ([b isKindOfClass:[UIPushBehavior class]]) {
            //[b setTargetPoint:self.view.center forItem:self.dynamicView];
            [b setAngle:angle magnitude:0.50f];
        }
        
        
    }
    
}
@end
