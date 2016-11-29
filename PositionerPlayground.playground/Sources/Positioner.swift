//
//  Positioner.swift
//  Robotroon
//
//  Created by Brad Howes on 11/26/16.
//  Copyright © 2016 Brad Howes. All rights reserved.
//

import CoreGraphics
import SpriteKit

public class Positioner: Sequence, IteratorProtocol {

    public typealias FilterProc = (CGPoint)->Bool

    public var count: Int { return randomPositions.count }
    public var isEmpty: Bool { return count == 0 }

    public let bounds: CGRect
    public let randomSource: RandomSource
    public let xSpacing: CGFloat
    public let xVar: CGFloat
    public let ySpacing: CGFloat
    public let yVar: CGFloat

    private var randomPositions: [CGPoint] = []
    private var nextIndex: Int = 0

    public init(bounds: CGRect, minSeparation: CGSize, minVariance: CGSize, randomSource: RandomSource) {

        self.bounds = bounds
        self.randomSource = randomSource

        // The minimum amount of horizontal/vertical distance between points to guarantee minSeparation for any two
        // points.
        //
        let spacing = minSeparation + minVariance * 2.0

        // Amount of horizontal spacing between points in X to evenly distribute points within the available width
        //
        xSpacing = self.bounds.width / floor(self.bounds.width / spacing.width)

        // Allocate any increase in horizontal spacing over minSeparation to the horizontal variance
        //
        xVar = xSpacing / 2.0 - minVariance.width

        // Amount of vertical spacing between points in Y to evenly distribute points within the available height
        //
        ySpacing = self.bounds.height / floor(self.bounds.height / spacing.height)

        // Allocate any increase in vertical spacing over minSeparation to the vertical variance
        //
        yVar = ySpacing / 2.0 - minVariance.height
    }

    /**
     Generate a new collection of points that honor the initial settings for minimim separation and min variance in
     each axis.
     */
    public func generate(filter: FilterProc? = nil) {
        randomPositions.removeAll(keepingCapacity: true)
        var x = bounds.minX + xSpacing / 2.0
        while x <= bounds.maxX {
            var y = bounds.minY + ySpacing / 2.0
            while y <= bounds.maxY {
                let pt = CGPoint(x: x, y: y) + CGVector(dx: randomSource.uniform(lower: -xVar, upper: xVar),
                                                        dy: randomSource.uniform(lower: -yVar, upper: yVar))
                if filter == nil || filter!(pt) {
                    randomPositions.append(pt)
                }
                y += ySpacing
            }
            x += xSpacing
        }

        // Shuffle the slots, swapping the current one with any one above it (increasing index). This is the 
        // Fisher-Yates algorithm which guarantees equal probability of all permutations of the items.
        //
        let upperLimit = randomPositions.count - 1
        for index in 0..<upperLimit {
            let other = randomSource.uniform(lower: index, upper: upperLimit)
            if index != other {
                swap(&randomPositions[index], &randomPositions[other])
            }
        }

        nextIndex = 0
    }

    /**
     Obtain an iterator for the sequence of random points.
     - returns: self
     */
    public func makeIterator() -> Positioner {
        if nextIndex != 0 {
            generate()
        }
        return self
    }

    /**
     Obtain the next value from the 'iterator' obtained by `makeIterator()`
     - returns: next random point or nil if there are no more available
     */
    public func next() -> CGPoint? {
        guard nextIndex < randomPositions.count else { return nil }
        let pos = randomPositions[nextIndex]
        nextIndex += 1
        return pos
    }

    public func debugView(scene: SKScene) {
        randomPositions.forEach {
            let sprite = SKSpriteNode(color: UIColor.cyan, size: CGSize(width: 3, height: 3))
            sprite.position = $0
            scene.addChild(sprite)
        }
    }
}
