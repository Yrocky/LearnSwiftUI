//
//  DoAnimation.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/18.
//

import SwiftUI

struct DoAnimation: View {
    
    @State private var titleVisible = true
    @State private var transitionFlag = true
    
    var body: some View {
        
        ExampleContainerView("Animation"){

            /*:
             `Animation`在swiftUI是对动画的抽象，并且为View提供了添加动画的modifer：
             ```swift
             func animation<V>(_ animation: Animation?, value: V) -> some View where V : Equatable
             ```
             目前有一些内置的动画，比如`spring`、`ease*`、`linear`、`timingCurve`等，
             并且还提供了诸如可以修改动画`delay`、`speed`、`repeat`的方法。
             
             > ease* 表示各种ease(In/Out)动画
             
             */
            
            doEase
            
            doSpring
            
            doInterpolatingSpring
            
            doTimingCurve
            
            doDelay
            
            doSpeed
            
            doRepeatCount
        }
    }
    
    @State private var easeOffset: CGFloat = 0
    
    var doEase: some View {
        VExampleView("ease(In/Out)、linear") {
            /*:
             
             */
            AnimationExampleView(
                "easeInOut",
                offset: easeOffset,
                color: Color.blue,
                animation: .easeInOut
            )
            
            AnimationExampleView(
                "easeIn",
                offset: easeOffset,
                color: Color.purple,
                animation: .easeIn
            )
            
            AnimationExampleView(
                "easeOut",
                offset: easeOffset,
                color: Color.green,
                animation: .easeOut
            )
            
            AnimationExampleView(
                "linear",
                offset: easeOffset,
                color: Color.orange,
                animation: .linear
            )
            
            MakeAnimationButton($easeOffset)
        }
    }
    
    @State private var springOffset: CGFloat = 0
    @ObservedObject private var spring = SpringProp()
    
    var doSpring: some View {
        
        VExampleView("spring") {
            /*:
             
             */
            AnimationExampleView(
                "Default spring",
                offset: springOffset,
                color: Color.red,
                animation: .spring()
            )
            
            AnimationExampleView(
                "spring",
                offset: springOffset,
                color: Color.purple,
                animation: .spring(
                    response: spring.response,
                    dampingFraction: spring.dampingFraction,
                    blendDuration: spring.blendDuration
                )
            )
            
            AnimationExampleView(
                "interactiveSpring",
                offset: springOffset,
                color: Color.green,
                animation: .interactiveSpring(
                    response: spring.response,
                    dampingFraction: spring.dampingFraction,
                    blendDuration: spring.blendDuration
                )
            )
            
            SpringSliderView("response", value: $spring.response)
            
            SpringSliderView("dampingFraction", value: $spring.dampingFraction)
            
            SpringSliderView("blendDuration", value: $spring.blendDuration)
            
            MakeAnimationButton($springOffset)
        }
    }
    
    @State private var interpolatingSpringOffset: CGFloat = 0
    @ObservedObject private var interpolatingSpring = InterpolatingSpringProp()

    var doInterpolatingSpring: some View {
        
        VExampleView("interpolatingSpring") {
            /*:
             
             */
            AnimationExampleView(
                offset: interpolatingSpringOffset,
                color: Color.orange,
                animation: .interpolatingSpring(
                    mass: interpolatingSpring.mass,
                    stiffness: interpolatingSpring.stiffness,
                    damping: interpolatingSpring.damping,
                    initialVelocity: interpolatingSpring.initialVelocity
                )
            )
            
            SpringSliderView("mass", value: $interpolatingSpring.mass, bounds: 0...10)
            
            SpringSliderView("stiffness", value: $interpolatingSpring.stiffness)
            
            SpringSliderView("damping", value: $interpolatingSpring.damping)
            
            SpringSliderView("initialVelocity", value: $interpolatingSpring.initialVelocity)
            
            MakeAnimationButton($interpolatingSpringOffset)
        }
    }
    
    @ObservedObject private var timingCurve = TimingCurveProp()
    @State private var timingCurveOffset: CGFloat = 0
    
    var doTimingCurve: some View {
        
        VExampleView("timingCurve") {
            /*:
             
             */
            AnimationExampleView(
                offset: timingCurveOffset,
                color: Color.green,
                animation: .timingCurve(
                    timingCurve.c0x,
                    timingCurve.c0y,
                    timingCurve.c1x,
                    timingCurve.c1y
                )
            )
            
            SpringSliderView("c0x", value: $timingCurve.c0x)
            
            SpringSliderView("c0y", value: $timingCurve.c0y)
            
            SpringSliderView("c1x", value: $timingCurve.c1x)
            
            SpringSliderView("c1y", value: $timingCurve.c1y)
            
            MakeAnimationButton($timingCurveOffset)
        }
    }
    
    @State private var delayValue: Double = 1
    @State private var delayOffset: CGFloat = 0

    var doDelay: some View {
        VExampleView("delay") {
            /*:
             
             */
            AnimationExampleView(
                offset: delayOffset,
                color: .purple,
                animation: Animation.easeInOut.delay(delayValue)
            )
            
            SpringSliderView(
                "delayValue",
                value: $delayValue,
                bounds: 0...4
            )
            
            MakeAnimationButton($delayOffset)
        }
    }
    
    @State private var speed: Double = 1
    @State private var speedOffset: CGFloat = 0
    
    var doSpeed: some View {
        VExampleView("speed") {
            /*:
             
             */
            AnimationExampleView(
                offset: speedOffset,
                color: Color.green,
                animation: Animation.easeOut.speed(speed)
            )
            
            SpringSliderView(
                "speed",
                value: $speed,
                bounds: 0...2
            )
            
            MakeAnimationButton($speedOffset)
        }
    }
    
    @State private var repeatCount: Int = 1
    @State private var repeatCountOffset: CGFloat = 0
    @State private var autoreverses = false
    
    var doRepeatCount: some View {
        
        VExampleView("repeatCount、repeatForever") {
            /*:
             
             */
            AnimationExampleView(
                "repeatCount \(repeatCount)",
                offset: repeatCountOffset,
                color: Color.green,
                animation: Animation.easeOut.repeatCount(repeatCount, autoreverses: autoreverses)
            )
            
            AnimationExampleView(
                "repeatForever",
                offset: repeatCountOffset,
                color: Color.orange,
                animation: Animation.easeOut.repeatForever(autoreverses: autoreverses)
            )
            
            Toggle("autoreverses", isOn: $autoreverses)
            
            Stepper("repeatCount", value: $repeatCount, in: 0...5)
            
            MakeAnimationButton($repeatCountOffset)
        }
    }
}


fileprivate struct AnimationExampleView: View {
    
    let title: String
    var offset: CGFloat
    var animation: Animation
    let color: Color
    
    init(_ title: String = "", offset: CGFloat = 0,color: Color, animation: Animation = .default) {
        self.title = title
        self.offset = offset
        self.color = color
        self.animation = animation
    }
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                
                if title.count > 0 {
                    
                    Text(title)
                }
                
                Spacer()
            }
            
            HStack{
                
                Circle()
                    .fill(color)
                    .frame(width: 40, height: 40)
                    .offset(x: offset)
                    .animation(animation)
                
                Spacer()
            }
        }
    }
}

fileprivate struct SpringSliderView: View {
    
    let title: String
    var value: Binding<Double>
    let bounds: ClosedRange<Double>
    
    init(
        _ title: String,
        value: Binding<Double>,
        bounds: ClosedRange<Double> = 0...1
    ) {
        self.title = title
        self.value = value
        self.bounds = bounds
    }
    
    var body: some View{
        VStack{
            Text("\(title): \(value.wrappedValue)")
            
            Slider(value: value, in: bounds)
        }
    }
}

fileprivate struct MakeAnimationButton: View {
    
    let offset: Binding<CGFloat>
    
    init(_ offset: Binding<CGFloat>) {
        self.offset = offset
    }
    
    var body: some View {
        Button("Make it animation") {
            if offset.wrappedValue == 0 {
                offset.wrappedValue = 300
            } else {
                offset.wrappedValue = 0
            }
        }
        .accentColor(Color(red:1.00, green:0.31, blue:0.33))
        .padding()
        .background(Color(red:0.69, green:0.96, blue:0.40))
        .cornerRadius(6)
    }
}

fileprivate class SpringProp: ObservableObject {
    @Published var response: Double = 0.55
    @Published var dampingFraction: Double = 0.825
    @Published var blendDuration: Double = 0
}

fileprivate class InterpolatingSpringProp: ObservableObject {
    @Published var mass: Double = 1.4
    @Published var stiffness: Double = 0
    @Published var damping: Double = 0
    @Published var initialVelocity: Double = 0
}

fileprivate class TimingCurveProp: ObservableObject {
    @Published var c0x: Double = 0
    @Published var c0y: Double = 0
    @Published var c1x: Double = 0
    @Published var c1y: Double = 0
}

extension Color {
    
    static var random: Color {
        Color(
            red: Double.random(in: 0.01...0.9),
            green: Double.random(in: 0.01...0.9),
            blue: Double.random(in: 0.01...0.9)
        )
    }
}

struct DoAnimation_Previews: PreviewProvider {
    static var previews: some View {
        DoAnimation()
    }
}
