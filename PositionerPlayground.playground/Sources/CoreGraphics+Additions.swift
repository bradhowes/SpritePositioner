//
//  CGVector+Additions.swift
//  Robotroon
//
//  Created by Brad Howes on 11/20/16.
//  Copyright © 2016 Brad Howes. All rights reserved.
//

import CoreGraphics

extension CGVector {

    /**
     Support the '*' operator for scaling a CGVector value via CGFloat
     - parameter lhs: the CGVector to scale
     - parameter rhs: the scaling factor
     - returns: new CGVector value
     */
    public static func *(lhs: CGVector, rhs: CGFloat) -> CGVector {
        return CGVector(dx: lhs.dx * rhs, dy: lhs.dy * rhs)
    }

    /**
     Support the '*' operator for scaling a CGVector value via Double
     - parameter lhs: the CGVector to scale
     - parameter rhs: the scaling factor
     - returns: new CGVector value
     */
    static func *(lhs: CGVector, rhs: Double) -> CGVector {
        return lhs * CGFloat(rhs)
    }

    /**
     Support the '/' operator for scaling a CGVector value via CGFloat
     - parameter lhs: the CGVector to scale
     - parameter rhs: the scaling factor
     - returns: new CGVector value
     */
    public static func /(lhs: CGVector, rhs: CGFloat) -> CGVector {
        return CGVector(dx: lhs.dx / rhs, dy: lhs.dy / rhs)
    }

    /**
     Support the '*' operator for scaling a CGVector value via Double
     - parameter lhs: the CGVector to scale
     - parameter rhs: the scaling factor
     - returns: new CGVector value
     */
    static func /(lhs: CGVector, rhs: Double) -> CGVector {
        return lhs / CGFloat(rhs)
    }
}

extension CGPoint {

    /**
     Support the '+' operator for adding a CGVector to a CGPoint
     - parameter lhs: the CGPoint to add to
     - parameter rhs: the CGVector to add
     - returns: new CGPoint value
     */
    public static func + (lhs: CGPoint, rhs: CGVector) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.dx, y: lhs.y + rhs.dy)
    }
}

extension CGSize {

    /**
     Support the '+' operator for adding two CGSize values
     - parameter lhs: the CGSize to add to
     - parameter rhs: the CGSize to add
     - returns: new CGSize value
     */
    public static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }

    /**
     Support the '*' operator for scaling a CGSize value via CGFloat
     - parameter lhs: the CGSize to scale
     - parameter rhs: the scaling factor
     - returns: new CGSize value
     */
    public static func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
    }

    /**
     Support the '*' operator for scaling a CGSize value via Double
     - parameter lhs: the CGSize to scale
     - parameter rhs: the scaling factor
     - returns: new CGSize value
     */
    public static func * (lhs: CGSize, rhs: Double) -> CGSize {
        return lhs * CGFloat(rhs)
    }

    /**
     Support the '/' operator for scaling a CGSize value via CGFloat
     - parameter lhs: the CGSize to scale
     - parameter rhs: the scaling factor
     - returns: new CGSize value
     */
    public static func / (lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(width: lhs.width / rhs, height: lhs.height / rhs)
    }

    /**
     Support the '/' operator for scaling a CGSize value via Double
     - parameter lhs: the CGSize to scale
     - parameter rhs: the scaling factor
     - returns: new CGSize value
     */
    public static func / (lhs: CGSize, rhs: Double) -> CGSize {
        return lhs / CGFloat(rhs)
    }
}
