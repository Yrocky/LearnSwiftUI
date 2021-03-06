//
//  DoGeometryEffect.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/29.
//

import SwiftUI

struct DoGeometryEffect: View {
    var body: some View {
        
//        ExampleContainerView("GeometryEffect") {
//
//            doHeroAnimation
            
            doFlippEffect
//        }
    }
    
    @Namespace private var ns
    @State private var showCircle = false
    
    var doHeroAnimation: some View {
        
        HExampleView("Hero animation") {
         
            /*:
             通过这个动画，我们会发现，并没有按照我们预期的那样很连续的修改，
             只是系统做了一个对两个View的offset、opacity动画而已，衔接的并不连贯。
             */
            if !showCircle {
                
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 100, height: 60)
                    .matchedGeometryEffect(id: "shap", in: ns)
            }
            
            Button("make it animation"){
                withAnimation(.easeIn(duration: 2)) {
                    showCircle.toggle()
                }
            }
            
            if showCircle {
                
                Circle()
                    .fill(Color.green)
                    .frame(width: 60, height: 60)
                    .matchedGeometryEffect(id: "shap", in: ns)
            }
        }
    }
    
    @State private var isFlipped = false
    @Namespace private var animation
    
    enum AnimationItem: String, Hashable {
        case shape
        case text
    }
    
    var doFlippEffect: some View {
//        VExampleView("matchedGeometryEffect") {
        VStack{
            /*:
             `.matchedGeometryEffect`很类似于
             
             虽然看起来是两个相同元素，但是在SwiftUI看来，他们并不是相同的，所以在切换的时候，如果放慢动画的速度，会发现其实是有两份元素的。
             
             // todo: 截图
             
             如果想让
             */
            VStack {
                if isFlipped {
                    Circle()
                        .fill(Color.pink)
                        .frame(width: 50, height: 50)
                    
                    Text("Learn SwiftUI")
                } else {
                    Text("Learn SwiftUI")
                    
                    Circle()
                        .fill(Color.green)
                        .frame(width: 50, height: 50)
                }
            }
            
            VStack {
                if isFlipped {
                    Circle()
                        .fill(Color.pink)
                        .frame(width: 50, height: 50)
                        .matchedGeometryEffect(id: AnimationItem.shape, in: animation)
                    
                    Text("Learn SwiftUI")
                        .foregroundColor(.pink)
                        .matchedGeometryEffect(id: AnimationItem.text, in: animation)
                } else {
                    Text("Learn SwiftUI")
                        .foregroundColor(.green)
                        .matchedGeometryEffect(id: AnimationItem.text, in: animation)
                    
                    /*:
                     在不同的View之间切换会发现，并不是很流畅，比如从`RoundedRectangle`变为`Circle`，则会发现其实是有两个View在做切换，而不是一个View做形变。
                     */
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.green)
                        .frame(width: 150, height: 50)
                        .matchedGeometryEffect(id: AnimationItem.shape, in: animation)
                }
            }
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 4)) {
                self.isFlipped.toggle()
            }
        }
    }
}

extension View {

    
}

struct DoGeometryEffect_Previews: PreviewProvider {
    static var previews: some View {
        DoGeometryEffect()
    }
}
