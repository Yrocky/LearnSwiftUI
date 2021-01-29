//
//  DoEffect.swift
//  DoSwiftUI
//
//  Created by rocky on 2021/1/26.
//

import SwiftUI

struct DoEffect: View {
    var body: some View {
        ExampleContainterView("Effect") {
            
            doTransformEffect
            
            doRotationEffect
            
            doScaleEffect
            
            doBlur
            
            doColorInvert
            
            doColorMultiply
        }
    }
    
    let transform = CGAffineTransform(rotationAngle: 30 * (.pi / 180))
    
    var doTransformEffect: some View {
        VExampleView("transformEffect") {
         
            Text("Hello world~")
                .transformEffect(transform)
                .border(Color.orange)
        }
    }
    
    var doRotationEffect: some View {
        HExampleView("rotationEffect") {
            
            Text("Hello world!")
                .rotationEffect(Angle(degrees: 30), anchor: .center)
                .border(Color.orange)
            
            Text("Hello world!")
                .rotationEffect(Angle(degrees: 30), anchor: .topLeading)
                .border(Color.green)
            
            Text("Hello world!")
                .rotationEffect(Angle(degrees: 30), anchor: .bottomTrailing)
                .border(Color.pink)
        }
    }
    
    var doScaleEffect: some View {
        
        VExampleView("scaleEffect") {
            
            Text("Hello world")
                .scaleEffect()
                .border(Color.gray)
            
            Text("Hello world")
                .scaleEffect(1.3)// default center
                .border(Color.orange)
            
            Text("Hello world")
                .scaleEffect(1.3, anchor: .topLeading)
                .border(Color.green)
            
            Text("Hello world")
                .scaleEffect(1.3, anchor: .top)
                .border(Color.green)
            
            Text("Hello world")
                .scaleEffect(1.3, anchor: .bottomTrailing)
                .border(Color.green)
        }
    }
    
    @State private var blurRadius: CGFloat = 1
    
    var doBlur: some View {
        VExampleView("blur") {
            
            Text("Hello world")
                .blur(radius: blurRadius)// default opaque false
            
            Text("Hello world")
                .blur(radius: blurRadius, opaque: true)
            
            Text("\(blurRadius)")
            
            Slider(value: $blurRadius, in: 0...5)
        }
    }
    
    var doColorInvert: some View {
        HExampleView("colorInvert") {
         
            Color
                .green
                .frame(width: 50, height: 50)
                .overlay(InnerSircleView())
                .overlay(Text("Normal"))
            
            Color
                .green
                .frame(width: 50, height: 50)
                .overlay(InnerSircleView())
                .colorInvert()
                .overlay(Text("Invert"))
        }
    }
    
    var doColorMultiply: some View {
        HExampleView("colorMultiply") {
            Color
                .green
                .frame(width: 50, height: 50)
                .overlay(InnerSircleView())
                .overlay(Text("Normal"))
            
            Color
                .green
                .frame(width: 50, height: 50)
                .overlay(InnerSircleView())
                .colorMultiply(.blue)
                .overlay(Text("Invert"))
        }
    }
    struct InnerSircleView: View {
        var body: some View{
            Circle()
                .fill(Color.orange)
                .frame(width: 40, height: 40, alignment: .center)
        }
    }
}

struct DoEffect_Previews: PreviewProvider {
    static var previews: some View {
        DoEffect()
    }
}
