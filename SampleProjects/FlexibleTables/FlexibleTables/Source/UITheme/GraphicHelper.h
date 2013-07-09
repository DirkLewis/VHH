//
//  GraphicHelper.h
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 4/16/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <Foundation/Foundation.h>


void drawLinearGradient(CGContextRef context, CGRect rect, UIColor *startColor, UIColor  *endColor);
CGRect rectFor1PxStroke(CGRect rect);
void draw1PxStroke(CGContextRef context, CGPoint startPoint, CGPoint endPoint, UIColor *color);
void drawGlossAndGradient(CGContextRef context, CGRect rect, UIColor *startColor, UIColor *endColor);

static inline double radians (double degrees) { return degrees * M_PI/180;}
CGMutablePathRef createArcPathFromBottomOfRect(CGRect rect, CGFloat arcHeight);
CGMutablePathRef createRoundedRectForRect(CGRect rect, CGFloat radius);

void drawArcAtPointCGPoint (CGContextRef context, CGFloat radius ,CGPoint centerPoint, CGFloat starting, CGFloat ending, UIColor *color, BOOL useShadow, CGBlendMode blendMode);