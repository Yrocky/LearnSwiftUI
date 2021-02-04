//
//  DoAnimatable.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/29.
//

import SwiftUI

struct DoAnimatable: View {
    var body: some View {
        ExampleContainerView("Animatable") {
            /*:
             在动画框架中，动画所表示的都是在`一定时间内，一个状态经过一系列的连续变化，成为另一个状态`。
             比如一个View在x轴上经过1s移动100px的距离，如果是线性动画，运动轨迹就是每1/100s移动1px距离，
             由于时间很快并且是一个连续的动作，所以眼睛就会认为这是一个动画。
             在swiftUI中，使用`Animatable协议`来抽象可以发生连续变化的类型，
             它只有一个`animatableData`属性，表示可以发生变化的数据。
             
             ```swift
             public protocol Animatable {

                 /// The type defining the data to animate.
                 associatedtype AnimatableData : VectorArithmetic

                 /// The data to animate.
                 var animatableData: Self.AnimatableData { get set }
             }
             ```
             默认animatableData使用的是`VectorArithmetic协议`类型，其定义内容如下：
             
             ```swift
             public protocol VectorArithmetic : AdditiveArithmetic {

                 /// Multiplies each component of this value by the given value.
                 mutating func scale(by rhs: Double)

                 /// Returns the dot-product of this vector arithmetic instance with itself.
                 var magnitudeSquared: Double { get }
             }
             
             public protocol AdditiveArithmetic : Equatable {

                 /// The zero value.
                 static var zero: Self { get }

                 /// Adds two values and produces their sum.
                 static func + (lhs: Self, rhs: Self) -> Self

                 /// Adds two values and stores the result in the left-hand-side variable.
                 static func += (lhs: inout Self, rhs: Self)

                 /// Subtracts one value from another and produces their difference.
                 static func - (lhs: Self, rhs: Self) -> Self

                 /// Subtracts the second value from the first and stores the difference in the
                 /// left-hand-side variable.
                 static func -= (lhs: inout Self, rhs: Self)

                 /// Adds two values and stores the result in the left-hand-side variable.
                 public static func += (lhs: inout Self, rhs: Self)

                 /// Subtracts the second value from the first and stores the difference in the
                 /// left-hand-side variable.
                 public static func -= (lhs: inout Self, rhs: Self)

                 /// Returns the given number unchanged.
                 prefix public static func + (x: Self) -> Self
             }
             ```
             
             通过查看文档可以发现`Float`、`Double`、`CGFloat`这些基础类型都
             遵守了该协议，这样他们都可以作为Animatable的动画数据。
             而那些使用进行组合的数据类型，比如`CGPoint`、`CGSize`、`CGRect`、`Angle`、`EdgeInsets`、`StrokeStyle`、`UnitPoint`等也遵守了该协议，
             所不同的是，这些类型内部使用一个`AnimatablePair`来组装数据，比如CGPoint：
             
             ```swift
             extension CGPoint : Animatable {

                 /// The type defining the data to animate.
                 public typealias AnimatableData = AnimatablePair<CGFloat, CGFloat>

                 /// The data to animate.
                 public var animatableData: CGPoint.AnimatableData
             }
             ```
             
             经过`Animatable`、`VectorArithmetic`以及`AnimatablePair`的抽象，
             动画中状态转换过程中，数据变化的基本方式：`加`、`减`、`乘`、`除`框架已经确定好了，
             有了这个基础框架，动画引擎就可以根据不同的动画函数来修改动画数据，从而实现对应的动画效果。
             
             比如上面在x轴线性位移100px的例子，为了方便演示，我们放大移动时间为10s，
             使用代码来编写动画函数就是：
             
             ```swift
             let origin: CGFloat = 0
             let terminus: CGFloat = 100
             
             for i in 0..<11 {
                 
                 let pct = Double(i) / 10
                 
                 var length = terminus - origin
                 length.scale(by: pct)
                                  
                 print("current = \(origin + length)")
             }
             ```
             
             当我们在swiftUI中对一个View使用`offset`来修改位移会发现，变化的过程中并没有动画效果:
             
             ```swift
             Rectangle()
                 .fill(Color.orange)
                 .frame(width: 80, height: 40)
                 .offset(x: offsetValue)
             
             Button("offset") {
                 offsetValue = 100
             }
             ```
             
             这是因为，我们仅仅是定义了`数据的变化`，而没有决定`如何变化`以及变化`所需要的时长`。
             如果我们使用`animation`指明具体动画类型、时长之后，就会看到预期的动画效果：
             
             ```swift
             Rectangle()
                 .fill(Color.green)
                 .frame(width: 80, height: 40)
                 .offset(x: offsetValue)
                 .animation(.linear(duration: 1))
             
             Button("offset") {
                 offsetValue = 100
             }
             ```
             
             */
            
            doLinearAnimation
            
            doMoveOffset
        }
    }
    
    @State private var offsetValue: CGFloat = 0
    
    var doMoveOffset: some View {
        
        VExampleView("move offset") {
            
            Rectangle()
                .fill(Color.orange)
                .frame(width: 80, height: 40)
                .offset(x: offsetValue)
            
            Rectangle()
                .fill(Color.green)
                .frame(width: 80, height: 40)
                .offset(x: offsetValue)
                .animation(.linear(duration: 1))
            
            Button("move 100px") {
                offsetValue = 100
            }
        }
    }
    
    @State private var number: Int = 2020
    
    var doLinearAnimation: some View {
        VExampleView("linear") {
            
            Button("move 100px", action: linear)
            
            Text("\(number)")
                .animation(.easeInOut(duration: 4))
            
            Button("Happy new year"){
                number = 2021
            }
        }
    }
    
    func linear() {
        
        let origin: CGFloat = 0
        let terminus: CGFloat = 100
        
        
        for i in 0..<11 {
            
            let pct = Double(i) / 10
            
            var length = terminus - origin

            length.scale(by: pct)
            
            let current = origin + length
            
            print("current = \(current)")
        }
    }
}

fileprivate struct ExampleDate{
    var year: Int = 2020
    var month: Int = 12
    var day: Int = 31
}
//
//extension ExampleDate: VectorArithmetic{
//
//    mutating func scale(by rhs: Double) {
//        <#code#>
//    }
//
//    var magnitudeSquared: Double {
//        <#code#>
//    }
//
//    static var zero: ExampleDate {
//        <#code#>
//    }
//
//
//}

struct DoAnimatable_Previews: PreviewProvider {
    static var previews: some View {
        DoAnimatable()
    }
}
