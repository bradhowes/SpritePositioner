//
//  BRHRandomness.swift
//  DataSampler
//
//  Created by Brad Howes on 9/22/16.
//  Copyright © 2016 Brad Howes. All rights reserved.
//

import Foundation
import GameKit

public protocol RandomSource: class {

    func uniform(lower: CGFloat, upper: CGFloat) -> CGFloat

    func uniform(lower: Int, upper: Int) -> Int
}

public extension RandomSource {
    public func binary() -> Bool {
        return uniform(lower: 0, upper: 1) == 0
    }
}

/// Uniform random number generator. Provides methods for generating numbers in ranges.
public final class RandomUniform: RandomSource {
    
    /// Random number source
    private(set) var randomSource: GKARC4RandomSource
    
    /**
     Intialize random number generator.
     */
    public init() {
        randomSource = GKARC4RandomSource()
        randomSource.dropValues(1000)
    }

    /**
     Return a random `Double` value that is withing a given range, the probability of each number in the range being
     uniform.
     
     - parameter lower: lower bound of the range (inclusive)
     - parameter upper: upper bound of the range (inclusive)
     
     - returns: new `Double` value
     */
    public func uniform(lower: Double, upper: Double) -> Double {
        return Double(randomSource.nextUniform()) * (upper - lower) + lower
    }

    /**
     Return a random `CGFloat` value that is withing a given range, the probability of each number in the range being
     uniform.

     - parameter lower: lower bound of the range (inclusive)
     - parameter upper: upper bound of the range (inclusive)

     - returns: new `CGFloat` value
     */
    public func uniform(lower: CGFloat, upper: CGFloat) -> CGFloat {
        return CGFloat(randomSource.nextUniform()) * (upper - lower) + lower
    }

    /**
     Return a random `Int` value that is within a given range, the probability of each number in the range being
     uniform.

     - parameter lower: lower bound of the range (inclusive)
     - parameter upper: upper bound of the range (inclusive)

     - returns: new `Int` value
     */
    public func uniform(lower: Int, upper: Int) -> Int {
        return Int((randomSource.nextUniform() * Float(upper - lower)).rounded()) + lower
    }
}
