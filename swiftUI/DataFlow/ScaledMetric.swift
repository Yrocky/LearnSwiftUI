//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// A dynamic property that scales a numeric value.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
@propertyWrapper public struct ScaledMetric<Value> : DynamicProperty where Value : BinaryFloatingPoint {

    /// Creates the scaled metric with an unscaled value and a text style to
    /// scale relative to.
    public init(wrappedValue: Value, relativeTo textStyle: Font.TextStyle)

    /// Creates the scaled metric with an unscaled value using the default
    /// scaling.
    public init(wrappedValue: Value)

    /// The value scaled based on the current environment.
    public var wrappedValue: Value { get }
}

