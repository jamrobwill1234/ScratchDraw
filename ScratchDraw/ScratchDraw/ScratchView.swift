//
//  ScratchView.swift
//  ScratchDraw
//
//  Created by James Williams on 5/14/15.
//  Copyright (c) 2015 James Williams. All rights reserved.
//

import UIKit

enum shapetype {
    case line
    case ellipse
    case rectangle
    
}

class ScratchView: UIView {
    
    var currentColor = UIColor.blackColor()
    
    var scratches: [Scratch] = []
    
    
    override func drawRect(rect: CGRect) {
        
        
        var context = UIGraphicsGetCurrentContext()
        
        //CGContextSetLineDash(<#c: CGContext!#>, <#phase: CGFloat#>, <#lengths: UnsafePointer<CGFloat>#>, <#count: Int#>)
        CGContextSetLineWidth(context, 5.0)
        CGContextSetLineCap(context, kCGLineCapRound)
        
        //        UIColor.blackColor().set()
        
        for scratch in scratches {
            
            if let firstPoint = scratch.points.first {
                
                switch scratch.type {
                    
                case .Ellipse :
                    
                    scratch.drawEllipseWithContext(context)
                    
                case .Line :
                    scratch.drawLineWithContext(context)
                    
                case .Triangle :
                    scratch.drawTriangleWithContext(context)
                    
                case .Rect :
                     scratch.drawRectWithContext(context)
                    
                    
                    
                    
                }
                
            }
        }
        
    }
    
    
    func newScratchWithStartPoint(point: CGPoint) {
        
        var scratch = Scratch()
        scratch.points = [point,point]
        
        
        scratch.type = .Triangle
        
        
        scratch.fillColor = currentColor
        scratches.append(scratch)
        setNeedsDisplay()
        
    }
    
    func updateCurrentScratchLastPoint(point: CGPoint) {
        
        if scratches.last != nil {
            
            
            scratches[scratches.count - 1].points[1] = point
            setNeedsDisplay()
            
            
            
        }
        
        
        
    }
    
    
    func addPointToCurrentScratch(point: CGPoint) {
        
        if scratches.count > 0 {
            
            scratches[scratches.count - 1].points.append(point)
            setNeedsDisplay()
            
        }
        
        
    }
    
    
    
    
    
    
    
}

enum ScratchType {
    case Line
    case Rect
    case Ellipse
    case Triangle
}

class Scratch {
    var type: ScratchType = ScratchType.Line
    var points: [CGPoint] = []
    var fillColor: UIColor?
    var strokeColor: UIColor?
    var strokeSize: Double = 0
    var shapetype: [CGRect] = []
    
    func drawLineWithContext(context: CGContextRef) {
        
        if let fillColor = fillColor {
            
            fillColor.set()
            
            
            CGContextMoveToPoint(context, points[0].x , points[0].y)
            
            
            
            for point in points {
                
                
                CGContextAddLineToPoint(context, point.x, point.y)
            }
            
            CGContextFillPath(context)
            
            
            
        }
        
        
    }
    
    
    func drawEllipseWithContext(context: CGContextRef) {
        
        if let fillColor = fillColor {
            
            fillColor.set()
            
            let x = points[0].x
            let y = points[0].y
            
            let width = points[1].x - points[0].x
            let height = points[1].y - points[0].y
            
            let rect = CGRectMake(x, y, width, height)
            
            CGContextFillEllipseInRect(context, rect)
            
        }
        
    }
    
    
    func drawRectWithContext(context: CGContextRef) {
        
        if let fillColor = fillColor {
            
            fillColor.set()
            
            let x = points[0].x
            let y = points[0].y
            
            let width = points[1].x - points[0].x
            let height = points[1].y - points[0].y
            
            let rect = CGRectMake(x, y, width, height)
            
            CGContextFillRect(context, rect)
            
        }
        
    }
    
    func drawTriangleWithContext(context: CGContextRef) {
        
        if let fillColor = fillColor {
        
        fillColor.set()
            
            //Move to point picks up pencil add line connects them and draws
        CGContextMoveToPoint(context, points[1].x, points[1].y)
            
        CGContextAddLineToPoint(context, points[0].x, points[1].y)
            
            //add one point plus another point divided by two to find the median
            
            let midX = (points[0].x + points[1].x) / 2.0
            
            CGContextAddLineToPoint(context, midX, points[0].y)
            // automatically fill for the last point but if you want to change it you must
            CGContextAddLineToPoint(context, points[1].x, points[1].y)
            
            CGContextFillPath(context)
            
        
        
    }
}


//line dash
// line cap
// line join
}